//
//  YJMacros.h
//  YJKit
//
//  Created by huang-kun on 16/3/25.
//  Copyright © 2016年 huang-kun. All rights reserved.
//

#ifndef YJMacros_h
#define YJMacros_h

/* ------------------------------------------------------------------------------------------------------------ */

// UIKit

/* ------------------------------------------------------------------------------------------------------------ */

// UIScreen

#ifndef kScreenBounds
#define kScreenBounds YJScreenBounds()
#endif

#ifndef kScreenSize
#define kScreenSize YJScreenSize()
#endif

#ifndef kScreenScale
#define kScreenScale YJScreenScale()
#endif

/* ------------------------------------------------------------------------------------------------------------ */

// UIColor

#ifndef RGBColor
#define RGBColor(hexValue, alphaValue) [UIColor colorWithHex:hexValue alpha:alphaValue];
#endif

/* ------------------------------------------------------------------------------------------------------------ */

// UIWindow Snapshot

/**
 *  Take a screen snapshot to cover screen flash.
 */

#ifndef UIWindowSnapshotBegin
#define UIWindowSnapshotBegin() \
    UIWindow *window = [UIApplication sharedApplication].keyWindow; \
    UIView *snapview = [window snapshotViewAfterScreenUpdates:NO]; \
    [window addSubview:snapview];
#endif

#ifndef UIWindowSnapshotEnd
#define UIWindowSnapshotEnd() \
    [snapview removeFromSuperview];
#endif

/* ------------------------------------------------------------------------------------------------------------ */

// StatusBar

#ifndef UIStatusBarHide
#define UIStatusBarHide() [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationNone];
#endif

#ifndef UIStatusBarShow
#define UIStatusBarShow() [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationNone];
#endif

#ifndef UIStatusBarHideSlided
#define UIStatusBarHideSlided() [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationSlide];
#endif

#ifndef UIStatusBarShowSlided
#define UIStatusBarShowSlided() [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationSlide];
#endif

/* ------------------------------------------------------------------------------------------------------------ */

// Foundation & C

/* ------------------------------------------------------------------------------------------------------------ */

// Radians & Degrees

#ifndef RadiansInDegrees
#define RadiansInDegrees(degrees) (degrees) * M_PI / 180
#endif

#ifndef DegreesInRadians
#define DegreesInRadians(radians) (radians) * 180 / M_PI
#endif

/* ------------------------------------------------------------------------------------------------------------ */

// @ keyword

#if __OPTIMIZE__
#define _yj_keywordify try {} @finally {}
#else
#define _yj_keywordify autoreleasepool {}
#endif

/* ------------------------------------------------------------------------------------------------------------ */

// weakify & strongify

#define _weak_cast(x) x##_weak_

#ifndef weakify
#if __has_feature(objc_arc)
#define weakify(object) _yj_keywordify __weak __typeof__(object) _weak_cast(object) = object;
#endif
#endif

#ifndef strongify
#if __has_feature(objc_arc)
#define strongify(object) _yj_keywordify __strong __typeof__(_weak_cast(object)) object = _weak_cast(object);
#endif
#endif

/* ------------------------------------------------------------------------------------------------------------ */

// onExit

static inline void YJBlockCleanUp(__strong void(^*block)(void)) { (*block)(); }

#ifndef onExit
#define onExit _yj_keywordify __strong void(^yj_block_)(void) __attribute__((cleanup(YJBlockCleanUp), unused)) = ^
#endif

/* ------------------------------------------------------------------------------------------------------------ */

#endif /* YJMacros_h */
