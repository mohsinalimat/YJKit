//
//  UIImage+YJCategory.h
//  YJKit
//
//  Created by Jack Huang on 16/3/20.
//  Copyright © 2016年 Jack Huang. All rights reserved.
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
+ (nonnull UIImage *)imageNamed:(NSString *)name inBundle:(nullable NSBundle *)bundle;


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
+ (nonnull UIImage *)imageNamed:(NSString *)name orientation:(UIImageOrientation)orientation inBundle:(nullable NSBundle *)bundle;

@end

NS_ASSUME_NONNULL_END