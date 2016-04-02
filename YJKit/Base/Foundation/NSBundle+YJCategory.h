//
//  NSBundle+YJCategory.h
//  YJKit
//
//  Created by huang-kun on 16/3/20.
//  Copyright © 2016年 huang-kun. All rights reserved.
//

#import <Foundation/NSBundle.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSBundle (YJCategory)

/**
 *  @brief Retrieve a bundle object which positioned as sub-bundle of main bundle.
 *  @param name The name of bundle with no ".bundle" extension. Passing nil or empty name will return main bundle.
 *  @return Returns the bundle by specific name.
 */
+ (nullable NSBundle *)bundleWithName:(nullable NSString *)name;

/**
 *  @brief Retrieve a bundle object which positioned as sub-bundle of given bundle.
 *  @param name   The name of bundle without ".bundle" extension. Passing nil or empty name will return the "bundle" as second parameter.
 *  @param bundle The bundle object as the container. Passing nil will be the main bundle.
 *  @return Returns the bundle by specific name in the specific bundle object.
 */
+ (nullable NSBundle *)bundleWithName:(nullable NSString *)name inBundle:(nullable NSBundle *)bundle;

/**
 *  @brief Retrieve the proper path of resource by given name and type. 
 *  @discussion e.g. When specifying image name as "icon" and type as "png", "icon@2x.png" will be retrieved for iPhone 5s, and "icon@3x.png" for iPhone 6s plus from bundle if contains. If no result is retrieved from bundle by "@2x" or "@3x", then "icon.png" will be searched for last chance.
 *  @param name       The name of resource without type extension.
 *  @param ext        The type of resource. Passing nil means the no extension for file name.
 *  @param bundlePath The path of a top-level bundle directory.
 *  @return Returns the file path of the resource.
 */
+ (nullable NSString *)pathForScaledResource:(nullable NSString *)name ofType:(nullable NSString *)ext inDirectory:(NSString *)bundlePath;

/**
 *  @brief Retrieve the proper path of resource by given name and type.
 *  @discussion e.g. When specifying image name as "icon" and type as "png", "icon@2x.png" will be retrieved for iPhone 5s, and "icon@3x.png" for iPhone 6s plus from bundle if contains. If no result is retrieved from bundle by "@2x" or "@3x", then "icon.png" will be searched for last chance.
 *  @param name       The name of resource without type extension.
 *  @param ext        The type of resource. Passing nil means the no extension for file name.
 *  @param subpath    The name of the bundle subdirectory. Can be nil.
 *  @return Returns the file path of the resource.
 */
- (nullable NSString *)pathForScaledResource:(nullable NSString *)name ofType:(nullable NSString *)ext inDirectory:(nullable NSString *)subpath;

/**
 *  @brief Retrieve the proper path of resource by given name and type.
 *  @discussion e.g. When specifying image name as "icon" and type as "png", "icon@2x.png" will be retrieved for iPhone 5s, and "icon@3x.png" for iPhone 6s plus from bundle if contains. If no result is retrieved from bundle by "@2x" or "@3x", then "icon.png" will be searched for last chance.
 *  @param name   The name of resource without type extension. Passing nil or empty name will return the first file encountered of the supplied type.
 *  @param ext    The type of resource. Passing nil means the no extension for file name.
 *  @return Returns the file path of the resource.
 */
- (nullable NSString *)pathForScaledResource:(nullable NSString *)name ofType:(nullable NSString *)ext;

@end

NS_ASSUME_NONNULL_END
