//
//  RGBColor.m
//  YJKit
//
//  Created by huang-kun on 16/5/22.
//  Copyright © 2016年 huang-kun. All rights reserved.
//

#import "RGBColor.h"

const RGBColor RGBColorZero = { 0, 0, 0, 0 };

NSString *NSStringFromRGBColor(RGBColor rgbColor) {
    return [NSString stringWithFormat:@"(RGBColor) { r:%@, g:%@, b:%@, a:%@ }",
            @(rgbColor.red), @(rgbColor.green), @(rgbColor.blue), @(rgbColor.alpha)];
}


@implementation NSValue (RGBColorExtension)

+ (NSValue *)valueWithRGBColor:(RGBColor)rgbColor {
    return [NSValue value:&rgbColor withObjCType:@encode(RGBColor)];
}

- (RGBColor)RGBColorValue {
    RGBColor rgbColor;
    [self getValue:&rgbColor];
    return rgbColor;
}

@end


@implementation NSCoder (RGBColorExtension)

- (void)encodeRGBColor:(RGBColor)rgbColor forKey:(NSString *)key {
    NSValue *value = [NSValue valueWithRGBColor:rgbColor];
    [self encodeObject:value forKey:key];
}

- (RGBColor)decodeRGBColorForKey:(NSString *)key {
    NSValue *value = [self decodeObjectForKey:key];
    return [value RGBColorValue];
}

@end


@implementation UIColor (RGBColorExtension)

+ (UIColor *)colorWithRGBColor:(RGBColor)rgbColor {
    return [UIColor colorWithRed:rgbColor.red green:rgbColor.green blue:rgbColor.blue alpha:rgbColor.alpha];
}

- (RGBColor)RGBColor {
    CGFloat r, g, b, a;
    [self getRed:&r green:&g blue:&b alpha:&a];
    return RGBColorMake(r, g, b, a);
}

@end
