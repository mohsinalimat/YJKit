//
//  UIScreen+YJCategory.h
//  YJKit
//
//  Created by Jack Huang on 16/3/21.
//  Copyright © 2016年 Jack Huang. All rights reserved.
//

#import <UIKit/UIScreen.h>

typedef NS_ENUM(NSInteger, UIScreenDisplayResolution) {
    UIScreenDisplayResolutionUndefined,
    // iPhone (includes iPod Touch)
    UIScreenDisplayResolutionPixel320x480,       // older type
    UIScreenDisplayResolutionPixel640x960,       // 4, 4s
    UIScreenDisplayResolutionPixel640x1136,      // 5, 5s, 6(display zoom), 6s(display zoom), SE 1
    UIScreenDisplayResolutionPixel750x1334,      // 6, 6s
    UIScreenDisplayResolutionPixel1125x2001,     // 6+(display zoom), 6s+(display zoom)
    UIScreenDisplayResolutionPixel1242x2208,     // 6+, 6s+
    // iPad
    UIScreenDisplayResolutionPixel768x1024,      // 1, 2, mini 1
    UIScreenDisplayResolutionPixel1536x2048,     // 3, 4, Air(1, 2) mini(2, 3, 4), Pro 2<9.7-inch>
    UIScreenDisplayResolutionPixel2048x2732,     // Pro (1, 2<12.9-inch>)
};

typedef NS_ENUM(NSInteger, UIScreenDisplayAspectRatio) {
    UIScreenDisplayAspectRatioUndefined,
    UIScreenDisplayAspectRatio_3_2,             // 3:2
    UIScreenDisplayAspectRatio_4_3,             // 4:3
    UIScreenDisplayAspectRatio_16_9,            // 16:9
};

/// Convenience function for acquiring [UIScreen mainScreen].bounds
CGRect YJScreenBounds();
/// Convenience function for acquiring [UIScreen mainScreen].bounds.size
CGSize YJScreenSize();
/// Convenience function for acquiring [UIScreen mainScreen].scale
CGFloat YJScreenScale();

#define kYJScreenBounds     YJScreenBounds()
#define kYJScreenSize       YJScreenSize()
#define kYJScreenScale      YJScreenScale()


@interface UIScreen (YJCategory)

/// The pixel size of the screen.
@property (nonatomic, readonly) CGSize sizeInPixel;

/// The value defines the display resolution of the device screen.
@property (nonatomic, readonly) UIScreenDisplayResolution displayResolution;

/// The value defines the display aspect ratio of the device screen.
@property (nonatomic, readonly) UIScreenDisplayAspectRatio displayAspectRatio;

@end
