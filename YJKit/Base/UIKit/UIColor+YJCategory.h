//
//  UIColor+YJCategory.h
//  YJKit
//
//  Created by Jack Huang on 16/3/31.
//  Copyright © 2016年 huang-kun. All rights reserved.
//

#import <UIKit/UIKit.h>

#ifndef RGBColor
#define RGBColor(hexValue, alphaValue) [UIColor colorWithHex:hexValue alpha:alphaValue];
#endif

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (YJCategory)

+ (UIColor *)colorWithHex:(UInt32)hex;
+ (UIColor *)colorWithHex:(UInt32)hex alpha:(CGFloat)alpha;

+ (nullable UIColor *)colorWithHexString:(NSString *)hexString;
+ (nullable UIColor *)colorWithHexString:(NSString *)hexString alpha:(CGFloat)alpha;

- (BOOL)isEqualToRGBColor:(UIColor *)color;

@end

NS_ASSUME_NONNULL_END