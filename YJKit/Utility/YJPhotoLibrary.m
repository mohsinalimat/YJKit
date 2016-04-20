//
//  YJPhotoLibrary.m
//  YJKit
//
//  Created by huang-kun on 16/4/19.
//  Copyright © 2016年 huang-kun. All rights reserved.
//

#if __has_include(<Photos/Photos.h>)
#import <Photos/Photos.h>
#endif

#import <AssetsLibrary/AssetsLibrary.h>

#import "YJPhotoLibrary.h"
#import "YJDebugMacros.h"
#import "YJObjcMacros.h"
#import "YJExecutionMacros.h"

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"

@interface YJPhotoLibrary ()
#if !(__IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_9_0)
@property (nonatomic, strong) ALAssetsLibrary *library;
@property (nonatomic, copy) NSURL *albumURL;
@property (nonatomic) int albumDeletionCount;
#endif
@property (nonatomic, copy) NSString *albumName;
@end

@implementation YJPhotoLibrary

+ (instancetype)sharedLibrary {
    static YJPhotoLibrary *lib;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        lib = [[YJPhotoLibrary alloc] init];
    });
    return lib;
}

- (instancetype)init {
    self = [super init];
    if (self) {
#if !(__IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_9_0)
        _library = [[ALAssetsLibrary alloc] init];
        // NOTICE:
        // 1. Must keep YJPhotoLibrary object alive, so it can receive notification for photo library changes.
        // 2. Delete Album in Photo App, then back to here. When received deletion notification, userInfo is empty!
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(_handleAssetsLibraryChanges:) name:ALAssetsLibraryChangedNotification object:nil];
#endif
    }
    return self;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
#if YJ_DEBUG
    NSLog(@"%@ dealloc", self.class);
#endif
}

- (void)saveImage:(UIImage *)image metadata:(NSDictionary *)metadata success:(void(^)(void))success failure:(void(^)(NSError *error))failure {
    if (!image) return;
    NSData *data = UIImagePNGRepresentation(image);
    [self saveImageData:data metadata:metadata toAlbumNamed:nil success:success failure:failure];
}

- (void)saveImageData:(NSData *)data metadata:(NSDictionary *)metadata success:(void (^)(void))success failure:(void (^)(NSError * error))failure {
    if (!data) return;
    [self saveImageData:data metadata:metadata toAlbumNamed:nil success:success failure:failure];
}

- (void)saveImage:(UIImage *)image metadata:(NSDictionary *)metadata toAlbumNamed:(NSString *)albumName success:(void(^)(void))success failure:(void(^)(NSError *error))failure {
    if (!image) return;
    NSData *data = UIImagePNGRepresentation(image);
    [self saveImageData:data metadata:metadata toAlbumNamed:albumName success:success failure:failure];
}

- (void)saveImageData:(NSData *)data metadata:(NSDictionary *)metadata toAlbumNamed:(NSString *)albumName success:(void(^)(void))success failure:(void(^)(NSError *error))failure {
    if (!data) return;
    self.albumName = albumName;

#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_9_0
    void(^successBlock)(void) = success;
    [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
        
        // create new image asset
        PHAssetCreationRequest *createPhotoToAssetRequest = [PHAssetCreationRequest creationRequestForAsset];
        [createPhotoToAssetRequest addResourceWithType:PHAssetResourceTypePhoto data:data options:nil];
        PHObjectPlaceholder *newlyAddedAsset = createPhotoToAssetRequest.placeholderForCreatedAsset;
        
        // fetch the albums (here always use custom-made type, not include any system default type, i.e. no smart album)
        PHFetchResult<PHAssetCollection *> *albums = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeAlbum subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];
        PHAssetCollection *targetAlbum = nil;
        
        for (PHAssetCollection *album in albums) {
            if ([album.localizedTitle isEqualToString:self.albumName]) {
                targetAlbum = album;
                break;
            }
        }
        
        if (!targetAlbum) { // create new album, then add image asset
            PHAssetCollectionChangeRequest *createAlbumRequest = [PHAssetCollectionChangeRequest creationRequestForAssetCollectionWithTitle:self.albumName];
            [createAlbumRequest addAssets:@[newlyAddedAsset]];
        } else { // add image asset to target album
            PHAssetCollectionChangeRequest *addPhotoToAlbumRequest = [PHAssetCollectionChangeRequest changeRequestForAssetCollection:targetAlbum];
            [addPhotoToAlbumRequest addAssets:@[newlyAddedAsset]];
        }
    } completionHandler:^(BOOL success, NSError * _Nullable error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (success && successBlock) successBlock();
            else if (error && failure) failure(error);
        });
    }];
#else
//    if (!albumName.length) { // save image to default album
//        [self _saveImageData:data metadata:metadata forGroup:nil success:success failure:failure];
//        return;
//    }
    @weakify(self)
    [self.library addAssetsGroupAlbumWithName:self.albumName resultBlock:^(ALAssetsGroup *group) {
        @strongify(self)
        if (group) { // get newly added album, and save image
            [self _saveImageData:data metadata:metadata forGroup:group success:success failure:failure];
        } else { // album is existed or deleted by user
            [self.library enumerateGroupsWithTypes:ALAssetsGroupAlbum usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
                @strongify(self)
                if (group) { // album is existed
                    NSString *name = (NSString *)[group valueForProperty:ALAssetsGroupPropertyName];
                    if ([name isEqualToString:self.albumName]) { // find the exact album and save image
                        [self _saveImageData:data metadata:metadata forGroup:group success:success failure:failure];
                        *stop = YES;
                    }
                } else { // album is deleted by user, and save image to default album
                    [self _saveImageData:data metadata:metadata forGroup:nil success:success failure:failure];
                }
            } failureBlock:^(NSError *error) {
                if (failure) failure(error);
            }];
        }
    } failureBlock:^(NSError *error) {
        if (failure) failure(error);
    }];
#endif
}

#if !(__IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_9_0) /* iOS_target_below_9.0 */

static execute_init(save_img_exe)

- (void)_saveImageData:(NSData *)imageData metadata:(NSDictionary *)metadata forGroup:(ALAssetsGroup *)group success:(void(^)(void))success failure:(void(^)(NSError *error))failure {
    execute_once_on(save_img_exe)
    @weakify(self)
    [self.library writeImageDataToSavedPhotosAlbum:imageData metadata:metadata completionBlock:^(NSURL *assetURL, NSError *error) {
        @strongify(self)
        if (!group) {
            if (success) success();
            execute_once_off(save_img_exe)
            return;
        }
        self.albumURL = (NSURL *)[group valueForProperty:ALAssetsGroupPropertyURL];
        [self.library assetForURL:assetURL resultBlock:^(ALAsset *asset) {
            [group addAsset:asset]; // add image asset to specific album
            if (success) success();
            execute_once_off(save_img_exe)
        } failureBlock:^(NSError *error) {
            if (failure) failure(error);
            execute_once_off(save_img_exe)
        }];
    }];
}

- (void)_handleAssetsLibraryChanges:(NSNotification *)notification {
    if (!self.albumURL) return;
    
    void(^handleDeletion)() = ^{
        self.albumURL = nil;
        if (self.forceAlbumCreationAfterUserDeleted) self.albumDeletionCount++;
    };
    
    if (notification.userInfo.count) {
        NSSet <NSURL *> *deletedGroupURLs = notification.userInfo[ALAssetLibraryDeletedAssetGroupsKey];
        if ([deletedGroupURLs containsObject:self.albumURL]) {
            handleDeletion();
        }
    } else {
        // check if the album exists
        [self.library groupForURL:self.albumURL resultBlock:^(ALAssetsGroup *group) {
            if (!group) handleDeletion();
        } failureBlock:nil];
    }
}

#define YJPhotoLibraryAssetsAlbumDeletionCountKey @"YJPhotoLibraryAssetsAlbumDeletionCountKey"

- (void)setAlbumDeletionCount:(int)albumDeletionCount {
    [[NSUserDefaults standardUserDefaults] setObject:@(albumDeletionCount) forKey:YJPhotoLibraryAssetsAlbumDeletionCountKey];
}

- (int)albumDeletionCount {
    return [[[NSUserDefaults standardUserDefaults] objectForKey:YJPhotoLibraryAssetsAlbumDeletionCountKey] intValue];
}

- (NSString *)albumName {
    if (!_albumName || !_albumName.length) {
        _albumName = [NSBundle mainBundle].infoDictionary[@"CFBundleDisplayName"] ?: @"Album";
        if (_forceAlbumCreationAfterUserDeleted) {
            int deletionCount = self.albumDeletionCount;
            if (deletionCount) {
                NSMutableString *name = [_albumName mutableCopy];
                for (int i = 0; i < deletionCount; i++) {
                    [name appendString:@" "];
                }
                _albumName = [name copy];
            }
        }
    }
    return _albumName;
}

#endif /* iOS_target_below_9.0 */

@end

#pragma clang diagnostic pop
