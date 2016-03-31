//
//  UIScreen+YJCategory.m
//  YJKit
//
//  Created by Jack Huang on 16/3/21.
//  Copyright © 2016年 Jack Huang. All rights reserved.
//

#import "UIScreen+YJCategory.h"
#import "UIDevice+YJCategory.h"

#pragma mark - Convenience Functions

CGRect YJScreenBounds() {
    static CGRect bounds;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        bounds = [[UIScreen mainScreen] bounds];
    });
    return bounds;
}

CGSize YJScreenSize() {
    return YJScreenBounds().size;
}

CGFloat YJScreenScale() {
    static CGFloat scale;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        scale = [[UIScreen mainScreen] scale];
    });
    return scale;
}

#pragma mark - UIScreen

@implementation UIScreen (YJCategory)

- (CGSize)sizeInPixel {
    return [[[UIScreen mainScreen] currentMode] size];
}

- (UIScreenDisplayResolution)displayResolution {
    UIScreenDisplayResolution resolution = UIScreenDisplayResolutionUndefined;
    CGSize tempSize = [self sizeInPixel];
    CGSize pSize = (CGSize){ MIN(tempSize.width, tempSize.height), MAX(tempSize.width, tempSize.height) };
    // iPhone
    if (UIDevice.isPhone) {
        if (CGSizeEqualToSize(pSize, CGSizeMake(320, 480))) {
            resolution = UIScreenDisplayResolutionPixel320x480;
        } else if (CGSizeEqualToSize(pSize, CGSizeMake(640, 960))) {
            resolution = UIScreenDisplayResolutionPixel640x960;
        } else if (CGSizeEqualToSize(pSize, CGSizeMake(640, 1136))) {
            resolution = UIScreenDisplayResolutionPixel640x1136;
        } else if (CGSizeEqualToSize(pSize, CGSizeMake(750, 1334))) {
            resolution = UIScreenDisplayResolutionPixel750x1334;
        } else if (CGSizeEqualToSize(pSize, CGSizeMake(1125, 2001))) {
            resolution = UIScreenDisplayResolutionPixel1125x2001;
        } else if (CGSizeEqualToSize(pSize, CGSizeMake(1242, 2208))) {
            resolution = UIScreenDisplayResolutionPixel1242x2208;
        }
    }
    // iPad
    else if (UIDevice.isPad) {
        if (CGSizeEqualToSize(pSize, CGSizeMake(768, 1024))) {
            resolution = UIScreenDisplayResolutionPixel768x1024;
        } else if (CGSizeEqualToSize(pSize, CGSizeMake(1536, 2048))) {
            resolution = UIScreenDisplayResolutionPixel1536x2048;
        } else if (CGSizeEqualToSize(pSize, CGSizeMake(2048, 2732))) {
            resolution = UIScreenDisplayResolutionPixel2048x2732;
        }
    }
    return resolution;
}

- (UIScreenDisplayAspectRatio)displayAspectRatio {
    UIScreenDisplayAspectRatio ratio = UIScreenDisplayAspectRatioUndefined;
    CGSize pSize = [self sizeInPixel];
    
    BOOL (^equalRatio)(CGSize, CGSize) = ^(CGSize pSize, CGSize rSize) {
        CGSize ps = (CGSize){ MIN(pSize.width, pSize.height), MAX(pSize.width, pSize.height) };
        CGSize rs = (CGSize){ MIN(rSize.width, rSize.height), MAX(rSize.width, rSize.height) };
        CGFloat product1 = ps.width * rs.height;
        CGFloat product2 = ps.height * rs.width;
        BOOL equal = (product1 == product2) ? YES : NO;
        if (!equal && ABS(product1 - product2) < 20) equal = YES; // not exactly equal, but approximately equal
        return equal;
    };
    
    if (equalRatio(pSize,(CGSize){16,9})) {
        ratio = UIScreenDisplayAspectRatio_16_9;
    } else if (equalRatio(pSize,(CGSize){4,3})) {
        ratio = UIScreenDisplayAspectRatio_4_3;
    } else if (equalRatio(pSize,(CGSize){3,2})) {
        ratio = UIScreenDisplayAspectRatio_3_2;
    }
    
    return ratio;
}

@end
