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

#import "YJObjcMacros.h"
#import "YJPhotoLibrary.h"

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"

@interface YJPhotoLibrary ()
#if !(__IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_9_0)
@property (nonatomic, strong) ALAssetsLibrary *library;
#endif
@end

@implementation YJPhotoLibrary

- (instancetype)init {
    self = [super init];
    if (self) {
#if !(__IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_9_0)
        _library = [[ALAssetsLibrary alloc] init];
#endif
    }
    return self;
}

- (void)saveImage:(UIImage *)image metadata:(NSDictionary *)metadata albumName:(NSString *)albumName success:(void(^)(void))success failure:(void(^)(NSError *error))failure {
    if (!image) return;
    NSData *data = UIImagePNGRepresentation(image);
    [self saveImageData:data metadata:metadata albumName:albumName success:success failure:failure];
}

- (void)saveImageData:(NSData *)data metadata:(NSDictionary *)metadata albumName:(NSString *)albumName success:(void(^)(void))success failure:(void(^)(NSError *error))failure {
    if (!data) return;
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_9_0
    void(^successBlock)(void) = success;
    [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
        
        // create new image asset
        PHAssetCreationRequest *createPhotoToAssetRequest = [PHAssetCreationRequest creationRequestForAsset];
        [createPhotoToAssetRequest addResourceWithType:PHAssetResourceTypePhoto data:data options:nil];
        PHObjectPlaceholder *newlyAddedAsset = createPhotoToAssetRequest.placeholderForCreatedAsset;
        
        // fetch the albums
        PHFetchResult<PHAssetCollection *> *albums = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeAlbum subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];
        PHAssetCollection *targetAlbum = nil;
        for (PHAssetCollection *album in albums) {
            if ([album.localizedTitle isEqualToString:albumName]) {
                targetAlbum = album;
                break;
            }
        }
        
        if (!targetAlbum) { // create new album, then add image asset
            PHAssetCollectionChangeRequest *createAlbumRequest = [PHAssetCollectionChangeRequest creationRequestForAssetCollectionWithTitle:albumName];
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
    if (!albumName) { // save image to default album
        [self _saveImageData:data metadata:metadata forGroup:nil success:success failure:failure];
        return;
    }
    @weakify(self)
    [self.library addAssetsGroupAlbumWithName:albumName resultBlock:^(ALAssetsGroup *group) {
        @strongify(self)
        if (group) { // get newly added album, and save image
            [self _saveImageData:data metadata:metadata forGroup:group success:success failure:failure];
        } else { // album is existed or deleted by user
            [self.library enumerateGroupsWithTypes:ALAssetsGroupAlbum usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
                @strongify(self)
                if (group) { // album is existed
                    NSString *name = (NSString *)[group valueForProperty:ALAssetsGroupPropertyName];
                    if ([name isEqualToString:albumName]) { // find the exact album and save image
                        [self _saveImageData:data metadata:metadata forGroup:group success:success failure:failure];
                        return;
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

#if !(__IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_9_0)
- (void)_saveImageData:(NSData *)imageData metadata:(NSDictionary *)metadata forGroup:(ALAssetsGroup *)group success:(void(^)(void))success failure:(void(^)(NSError *error))failure {
    @weakify(self)
    [self.library writeImageDataToSavedPhotosAlbum:imageData metadata:metadata completionBlock:^(NSURL *assetURL, NSError *error) {
        @strongify(self)
        if (!group) {
            if (success) success();
            return;
        }
        [self.library assetForURL:assetURL resultBlock:^(ALAsset *asset) {
            [group addAsset:asset]; // add image asset to specific album
            if (success) success();
        } failureBlock:^(NSError *error) {
            if (failure) failure(error);
        }];
    }];
}
#endif

@end

#pragma clang diagnostic pop
