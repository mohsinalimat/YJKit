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

// kScreenBounds, kScreenSize, kScreenScale

/* ------------------------------------------------------------------------------------------------------------ */

// UIColor

// RGBColor(value, alpha)

/* ------------------------------------------------------------------------------------------------------------ */

// UIWindow Snapshot

/**
 *  Take a screen snapshot to cover screen flash.
 */

#ifndef UIWindowSnapshotBegin
#define UIWindowSnapshotBegin() \
    UIWindow *window = [UIApplication sharedApplication].keyWindow; \
    UIView *yj_snapview_ = [window snapshotViewAfterScreenUpdates:NO]; \
    [window addSubview:snapview];
#endif

#ifndef UIWindowSnapshotEnd
#define UIWindowSnapshotEnd() \
    [yj_snapview_ removeFromSuperview];
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

// execute once

/**
 *  Execute function or method only once. Call execute_once() at first line inside of a function or method.
 */
#ifndef execute_once
#define execute_once() static bool yj_once_flag_ = false; \
    if (yj_once_flag_) return; \
    yj_once_flag_ = true;
#endif

/**
 * Execute function or method only condition is true. Call execute_condition(...) at first line inside of a function or method.
 *
 *  @code
 void printNumber(int n) {
    execute_condition(n % 2 == 0)
    printf("%d ", n);
 };
 
 for (int i = 0; i < 10; i++) {
    printNumber(i);
 }
 *  @endcode
 */
#ifndef execute_condition
#define execute_condition(...) static bool yj_once_flag_ = false; \
    if (__VA_ARGS__) yj_once_flag_ = false; \
    else yj_once_flag_ = true; \
    if (yj_once_flag_) return;
#endif

// Another approach: (by Sunnyxx)
// 1. #import <objc/runtime.h>
// 2. Write the code inside of a method at very first line:
// - (void)method {
//     if (objc_getAssociatedObject(self, _cmd)) return;
//     else objc_setAssociatedObject(self, _cmd, NSStringFromSelector(_cmd), OBJC_ASSOCIATION_RETAIN);
//     ...
// }
// if the object is released, and new object is created, perform_once() can be used again.

/**
 *  Perform a method only once. Import <objc/runtime.h> and call perform_once() at first line inside of a method.
 */
#ifndef perform_once
#define perform_once() if (objc_getAssociatedObject(self, _cmd)) return; \
    else objc_setAssociatedObject(self, _cmd, @(YES), OBJC_ASSOCIATION_RETAIN);
#endif

/**
 *  Perform a method only condition is true. Import <objc/runtime.h> and call perform_condition(...) at first line inside of a or method.
 *
 *  @code
 - (void)logNumber:(int)n {
    perform_condition(n % 2 == 0)
    NSLog(@"%@", @(n));
 }
 
 for (int i = 0; i < 10; i++) {
    [self logNumber:i];
 }
 *  @endcode
 */
#ifndef perform_condition
#define perform_condition(...) if (__VA_ARGS__) objc_setAssociatedObject(self, _cmd, nil, OBJC_ASSOCIATION_RETAIN); \
    else objc_setAssociatedObject(self, _cmd, @(YES), OBJC_ASSOCIATION_RETAIN); \
    if (objc_getAssociatedObject(self, _cmd)) return;
#endif

/* ------------------------------------------------------------------------------------------------------------ */

#endif /* YJMacros_h */
