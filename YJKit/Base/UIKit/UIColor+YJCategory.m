//
//  UIColor+YJCategory.m
//  YJKit
//
//  Created by Jack Huang on 16/3/31.
//  Copyright © 2016年 huang-kun. All rights reserved.
//
//  Source Code: https://github.com/mattquiros/UIColorHexColor

#import "UIColor+YJCategory.h"

@implementation UIColor (YJCategory)

+ (UIColor *)colorWithHex:(UInt32)hex {
    return [self colorWithHex:hex alpha:1.0];
}

+ (UIColor *)colorWithHex:(UInt32)hex alpha:(CGFloat)alpha {
    return [UIColor colorWithRed:((float)((hex & 0xFF0000) >> 16))/255.0
                           green:((float)((hex & 0xFF00) >> 8))/255.0
                            blue:((float)(hex & 0xFF))/255.0
                           alpha:alpha];
}

- (BOOL)isEqualToRGBColor:(UIColor *)color {
    CGFloat r1, g1, b1, a1;
    CGFloat r2, g2, b2, a2;
    [self getRed:&r1 green:&g1 blue:&b1 alpha:&a1];
    [self getRed:&r2 green:&g2 blue:&b2 alpha:&a2];
    return (r1 == r2 && g1 == g2 && b1 == b2 && a1 == a2) ? YES : NO;
}

@end
