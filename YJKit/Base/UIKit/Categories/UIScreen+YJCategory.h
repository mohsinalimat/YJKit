//
//  UIScreen+YJCategory.h
//  YJKit
//
//  Created by huang-kun on 16/3/21.
//  Copyright © 2016年 huang-kun. All rights reserved.
//

#import <UIKit/UIScreen.h>

typedef NS_ENUM(NSInteger, YJScreenDisplayResolution) {
    YJScreenDisplayResolutionUndefined,
    // iPhone (includes iPod Touch)
    YJScreenDisplayResolutionPixel320x480,       // older type
    YJScreenDisplayResolutionPixel640x960,       // 4, 4s
    YJScreenDisplayResolutionPixel640x1136,      // 5, 5s, 6(display zoom), 6s(display zoom), SE 1
    YJScreenDisplayResolutionPixel750x1334,      // 6, 6s
    YJScreenDisplayResolutionPixel1125x2001,     // 6+(display zoom), 6s+(display zoom)
    YJScreenDisplayResolutionPixel1242x2208,     // 6+, 6s+
    // iPad
    YJScreenDisplayResolutionPixel768x1024,      // 1, 2, mini 1
    YJScreenDisplayResolutionPixel1536x2048,     // 3, 4, Air(1, 2) mini(2, 3, 4), Pro 2<9.7-inch>
    YJScreenDisplayResolutionPixel2048x2732,     // Pro (1, 2<12.9-inch>)
};

typedef NS_ENUM(NSInteger, YJScreenDisplayAspectRatio) {
    YJScreenDisplayAspectRatioUndefined,
    YJScreenDisplayAspectRatio_3_2,             // 3:2
    YJScreenDisplayAspectRatio_4_3,             // 4:3
    YJScreenDisplayAspectRatio_16_9,            // 16:9
};

/// Convenience function for acquiring [UIScreen mainScreen].bounds
CGRect YJScreenBounds();
/// Convenience function for acquiring [UIScreen mainScreen].bounds.size
CGSize YJScreenSize();
/// Convenience function for acquiring [UIScreen mainScreen].scale
CGFloat YJScreenScale();


@interface UIScreen (YJCategory)

/// The pixel size of the screen.
@property (nonatomic, readonly) CGSize sizeInPixel;

/// The display resolution of the device screen.
@property (nonatomic, readonly) YJScreenDisplayResolution displayResolution;

/// The display aspect ratio of the device screen.
@property (nonatomic, readonly) YJScreenDisplayAspectRatio displayAspectRatio;

@end
