//
//  YJPhotoLibrary.h
//  YJKit
//
//  Created by huang-kun on 16/4/19.
//  Copyright © 2016年 huang-kun. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YJPhotoLibrary : NSObject

/**
 *  Saves given UIImage object and metadata to the Photos Album.
 *
 *  @param image     The UIImage object to add to the album.
 *  @param metadata  The metadata to associate with the image.
 *  @param albumName The name of album which will contains the image. Passing nil will be the default album.
 *  @param success   The block invoked after the save operation completes.
 *  @param failure   The block invoked after the save operation fails.
 */
- (void)saveImage:(UIImage *)image metadata:(nullable NSDictionary *)metadata albumName:(nullable NSString *)albumName success:(nullable void(^)(void))success failure:(nullable void(^)(NSError *error))failure;

/**
 *  Writes given image data and metadata to the Photos Album.
 *
 *  @param data      Data for the image to add to the album.
 *  @param metadata  The metadata to associate with the image.
 *  @param albumName The name of album which will contains the image. Passing nil will be the default album.
 *  @param success   The block invoked after the save operation completes.
 *  @param failure   The block invoked after the save operation fails.
 */
- (void)saveImageData:(NSData *)data metadata:(nullable NSDictionary *)metadata albumName:(nullable NSString *)albumName success:(nullable void(^)(void))success failure:(nullable void(^)(NSError *error))failure;

@end

NS_ASSUME_NONNULL_END