//
//  UIColor+YJCategory.h
//  YJKit
//
//  Created by huang-kun on 16/3/31.
//  Copyright © 2016年 huang-kun. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (YJCategory)

+ (UIColor *)colorWithHex:(UInt32)hex;
+ (UIColor *)colorWithHex:(UInt32)hex alpha:(CGFloat)alpha;

+ (nullable UIColor *)colorWithHexString:(NSString *)hexString;
+ (nullable UIColor *)colorWithHexString:(NSString *)hexString alpha:(CGFloat)alpha;

+ (UIColor *)randomRGBColor;

/**
 *  Compare color objects whether they have same red, green, blue and alpha value.
 *  @param color The UIColor object.
 *  @return The result of comparison.
 */
- (BOOL)isEqualToRGBColor:(UIColor *)color;

@end

NS_ASSUME_NONNULL_END