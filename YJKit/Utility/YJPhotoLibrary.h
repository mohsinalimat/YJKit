//
//  YJPhotoLibrary.h
//  YJKit
//
//  Created by huang-kun on 16/4/19.
//  Copyright © 2016年 huang-kun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YJConfigureMacros.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, YJPhotoLibraryAuthorizationStatus) {
    YJPhotoLibraryAuthorizationStatusNotDetermined = 0, // User has not yet made a choice with regards to this application
    YJPhotoLibraryAuthorizationStatusRestricted,        // This application is not authorized to access photo data. The user cannot change this application’s status, possibly due to active restrictions such as parental controls being in place.
    YJPhotoLibraryAuthorizationStatusDenied,            // User has explicitly denied this application access to photos data.
    YJPhotoLibraryAuthorizationStatusAuthorized         // User has authorized this application to access photos data.
};

/**
 *  A convenicent class for saving photo into iOS photo library. 
 *  It also provide the convenicent album creation and maybe you can force your album always exists if possible.
 */
@interface YJPhotoLibrary : NSObject

/**
 *  Retrieves the shared YJPhotoLibrary object.
 *
 *  @return The singleton YJPhotoLibrary object.
 */
+ (instancetype)sharedLibrary;

/**
 *  Returns information about your app’s authorization for accessing the user’s Photos library.
 *
 *  @return The current authorization status.
 */
+ (YJPhotoLibraryAuthorizationStatus)authorizationStatus;

/**
 *  Whether always create an album after saving a photo data, even user deleted it from photo library. Default is NO. If set this property to YES, the album will always exists in your photo library every time you save a photo by calling saving APIs from this class.
 *
 *  @note The value is always YES for setting minimum deployment target as iOS 9 and above.
 */
@property (nonatomic) BOOL forceAlbumCreationAfterUserDeleted YJ_UNAVALIBLE_FOR_MIN_DEPLOYMENT_TARGET_ABOVE_IOS_9;

/**
*  Saves given UIImage object and metadata to the Photos Album in APP's name.
*
*  @param image     The UIImage object to add to the album.
*  @param metadata  The metadata to associate with the image.
*  @param success   The block invoked after the save operation completes.
*  @param failure   The block invoked after the save operation fails.
*/
- (void)saveImage:(UIImage *)image metadata:(nullable NSDictionary *)metadata success:(nullable void(^)(void))success failure:(nullable void(^)(NSError *error))failure;

/**
 *  Writes given image data and metadata to the Photos Album in APP's name.
 *
 *  @param data      Data for the image to add to the album.
 *  @param metadata  The metadata to associate with the image.
 *  @param success   The block invoked after the save operation completes.
 *  @param failure   The block invoked after the save operation fails.
 */
- (void)saveImageData:(NSData *)data metadata:(nullable NSDictionary *)metadata success:(nullable void (^)(void))success failure:(nullable void (^)(NSError *error))failure;

/**
 *  Saves given UIImage object and metadata to the Photos Album with specified album name.
 *
 *  @param image     The UIImage object to add to the album.
 *  @param metadata  The metadata to associate with the image.
 *  @param albumName The name of album which stores the image. Passing nil will be using APP's name.
 *  @param success   The block invoked after the save operation completes.
 *  @param failure   The block invoked after the save operation fails.
 */
- (void)saveImage:(UIImage *)image metadata:(nullable NSDictionary *)metadata toAlbumNamed:(nullable NSString *)albumName success:(nullable void(^)(void))success failure:(nullable void(^)(NSError *error))failure;

/**
 *  Writes given image data and metadata to the Photos Album with specified album name.
 *
 *  @param data      Data for the image to add to the album.
 *  @param metadata  The metadata to associate with the image.
 *  @param albumName The name of album which stores the image. Passing nil will be using APP's name.
 *  @param success   The block invoked after the save operation completes.
 *  @param failure   The block invoked after the save operation fails.
 */
- (void)saveImageData:(NSData *)data metadata:(nullable NSDictionary *)metadata toAlbumNamed:(nullable NSString *)albumName success:(nullable void(^)(void))success failure:(nullable void(^)(NSError *error))failure;

@end

NS_ASSUME_NONNULL_END