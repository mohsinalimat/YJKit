//
//  UIImage+YJCategory.h
//  YJKit
//
//  Created by huang-kun on 16/3/20.
//  Copyright © 2016年 huang-kun. All rights reserved.
//

#import <UIKit/UIImage.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (YJCategory)

/**
 *  @brief  Returns the image object associated with the specified filename from specified bundle object.
 *  @discussion e.g. If there are images named "icon@2x.png", "icon@3x.png" in the same bundle, only pass the name as "icon". The types of image in bundle only support "png", "jpg", "jpeg".
 *
 *  @param name    The name of the file without scale information.
 *  @param bundle  The bundle object that contains the image resources, pass nil to use the main bundle.
 *
 *  @return Returns the matched image object that also cached in memory. The result can be nil.
 */
+ (nullable UIImage *)imageNamed:(NSString *)name scaledInBundle:(nullable NSBundle *)bundle;


/**
 *  @brief  Returns the image object associated with the specified filename from specified bundle object.
 *  @discussion e.g. If there are images named "icon@2x.png", "icon@3x.png" in the same bundle, only pass the name as "icon". The types of image in bundle only support "png", "jpg", "jpeg".
 *
 *  @param name         The name of the file without scale information.
 *  @param orientation  The orientation of the image data. You can use this parameter to specify any rotation factors applied to the image.
 *  @param bundle       The bundle object that contains the image resources, pass nil to use the main bundle.
 *
 *  @return Returns the matched image object that also cached in memory. The result can be nil.
 */
+ (nullable UIImage *)imageNamed:(NSString *)name orientation:(UIImageOrientation)orientation scaledInBundle:(nullable NSBundle *)bundle;

/**
 *  Get a resized image from original image.
 *  @param multiplier The multiple of current image width and height.
 *  @return Returns a resized image for specific condition.
 */
- (UIImage *)resizedImageByMultiplier:(CGFloat)multiplier;

/**
 *  Get a resized image from original image.
 *  @param width The final width of resized image.
 *  @return Returns a resized image for specific condition.
 */
- (UIImage *)resizedImageForWidth:(CGFloat)width;

/**
 *  Get a resized image from original image.
 *  @param height The final height of resized image.
 *  @return Returns a resized image for specific condition.
 */
- (UIImage *)resizedImageForHeight:(CGFloat)height;

/**
 *  Get a resized image from original image.
 *  @param widthInPixel The final width measured in pixel of resized image.
 *  @return Returns a resized image for specific condition.
 */
- (UIImage *)resizedImageForWidthInPixel:(CGFloat)widthInPixel;

/**
 *  Get a resized image from original image.
 *  @param heightInPixel The final height measured in pixel of resized image.
 *  @return Returns a resized image for specific condition.
 */
- (UIImage *)resizedImageForHeightInPixel:(CGFloat)heightInPixel;

@end

NS_ASSUME_NONNULL_END