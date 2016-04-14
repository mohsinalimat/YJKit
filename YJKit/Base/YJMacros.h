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

// UIScreen+YJCategory.h

// kScreenBounds, kScreenSize, kScreenScale

/* ------------------------------------------------------------------------------------------------------------ */

// UIColor+YJCategory.h

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
#ifndef _yj_keywordify
#define _yj_keywordify try {} @finally {}
#endif
#else
#ifndef _yj_keywordify
#define _yj_keywordify autoreleasepool {}
#endif
#endif

/* ------------------------------------------------------------------------------------------------------------ */

// weakify & strongify

#ifndef _weak_cast
#define _weak_cast(x) x##_weak_
#endif

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

// execute_once()

/**
 *  Execute function or method only once. Call execute_once() at first line inside of a non-returned function or method.
 *  execute_once() also can be used for executing code once after the execute_once() line, even if not use it at first line.
 *  @code
 
 Usage:
 
 void greet() {
    execute_once();
    printf("hello. ")
 };
 
 for (int i = 0; i < 10; i++) {
    greet();
 }
 
 Another usage:
 
 void doSomething() {
    // some code
    // ...
    execute_once()
    // execute code below once.
    // ...
 }
 
 *  @endcode
 */
#ifndef execute_once
#define execute_once() \
    static bool yj_execute_once_flag = false; \
    if (yj_execute_once_flag) return; \
    yj_execute_once_flag = true;
#endif


/**
 *  Execute part of code inside of a function or method only once. Use execute_once_begin() and execute_once_end() as a pair.
 *
 *  @code
 
 Usage: 
 
 void doSomething {
    // execute some code
    // ...
    execute_once_begin()
    // excute code once
    // ...
    execute_once_end()
    // execute other code
    // ...
 }
 
 *  @endcode
 */
#ifndef execute_once_begin
#define execute_once_begin() \
    static bool yj_execute_once_flag = false; \
    if (yj_execute_once_flag) goto YOU_MUST_CALL_ONCE_END; \
    yj_execute_once_flag = true;
#endif

#ifndef execute_once_end
#define execute_once_end() \
    YOU_MUST_CALL_ONCE_END: {}
#endif

/* ------------------------------------------------------------------------------------------------------------ */

// perform_once()

// Another approach: (by Sunnyxx)
// 1. #import <objc/runtime.h>
// 2. Write the code inside of a method at very first line:
// - (void)method {
//     if (objc_getAssociatedObject(self, _cmd)) return;
//     else objc_setAssociatedObject(self, _cmd, NSStringFromSelector(_cmd), OBJC_ASSOCIATION_RETAIN);
//     ...
// }


// -- Difference bewteen execute_once() and perform_once() --
// * execute_once() can be used for both inside of function and method, and perform_once() can be used for only inside of method.
// * The code below execute_once() only can be executed once. If the receiver object (self) is released, and new receiver object (self) is created, the code below perform_once() can be performed again.


// Usage: Same as execute_once(), execute_once_begin(), execute_once_end()
// Remark: If you use perform_once() inside of a method, then the _cmd as associated key is taken. Better use another key for other associated objects.

/**
 *  Perform a method only once. Import <objc/runtime.h> and call perform_once() at first line inside of a non-returned method.
 *  perform_once() also can be used for executing code once after the perform_once() line, even if not use it at first line.
 */
#ifndef perform_once
#define perform_once() \
    if (objc_getAssociatedObject(self, _cmd)) return; \
    else objc_setAssociatedObject(self, _cmd, @(YES), OBJC_ASSOCIATION_RETAIN);
#endif

#ifndef perform_once_begin
#define perform_once_begin() \
    if (objc_getAssociatedObject(self, _cmd)) goto YOU_MUST_CALL_ONCE_END; \
    else objc_setAssociatedObject(self, _cmd, @(YES), OBJC_ASSOCIATION_RETAIN);
#endif

#ifndef perform_once_end
#define perform_once_end() \
    YOU_MUST_CALL_ONCE_END: {}
#endif

/* ------------------------------------------------------------------------------------------------------------ */

#endif /* YJMacros_h */
