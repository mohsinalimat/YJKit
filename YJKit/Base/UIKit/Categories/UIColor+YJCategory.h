//
//  UIColor+YJCategory.h
//  YJKit
//
//  Created by huang-kun on 16/3/31.
//  Copyright © 2016年 huang-kun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YJColorComponents.h"

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (YJCategory)

+ (UIColor *)colorWithHex:(UInt32)hex;
+ (UIColor *)colorWithHex:(UInt32)hex alpha:(CGFloat)alpha;

+ (nullable UIColor *)colorWithHexString:(NSString *)hexString;
+ (nullable UIColor *)colorWithHexString:(NSString *)hexString alpha:(CGFloat)alpha;

+ (UIColor *)randomColor;

+ (UIColor *)colorWithRGBColor:(RGBColor)rgbColor;

/**
 *  Compare color objects whether they have same red, green, blue and alpha value.
 *  @param color The UIColor object.
 *  @return The result of comparison.
 */
- (BOOL)isEqualToColor:(UIColor *)color;

- (RGBColor)RGBColor;

@end


UIKIT_EXTERN NSString *NSStringFromRGBColor(RGBColor rgbColor);


@interface NSValue (YJColorExtension)

+ (NSValue *)valueWithRGBColor:(RGBColor)rgbColor;

- (RGBColor)RGBColorValue;

@end


@interface NSCoder (YJColorExtension)

- (void)encodeRGBColor:(RGBColor)rgbColor forKey:(NSString *)key;

- (RGBColor)decodeRGBColorForKey:(NSString *)key;

@end


NS_ASSUME_NONNULL_END