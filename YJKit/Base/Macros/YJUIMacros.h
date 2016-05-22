//
//  YJUIMacros.h
//  YJKit
//
//  Created by huang-kun on 16/4/16.
//  Copyright © 2016年 huang-kun. All rights reserved.
//

#ifndef YJUIMacros_h
#define YJUIMacros_h

#import "UIDevice+YJCategory.h"
#import "UIColor+YJCategory.h"
#import "UIScreen+YJCategory.h"

/* ------------------------------------------------------------------------------------------------------------ */

// UIDevice

#ifndef kSystemVersion
#define kSystemVersion [UIDevice systemVersion]
#endif

#ifndef isPhone 
#define isPhone [UIDevice isPhone]
#endif

#ifndef isPad
#define isPad [UIDevice isPad]
#endif

/* ------------------------------------------------------------------------------------------------------------ */

// UIColor

#ifndef HexColor
#define HexColor(hexValue, alphaValue) [UIColor colorWithHex:hexValue alpha:alphaValue]
#endif

/* ------------------------------------------------------------------------------------------------------------ */

// UIScreen

#ifndef kUIScreenBounds
#define kUIScreenBounds YJScreenBounds()
#endif

#ifndef kUIScreenSize
#define kUIScreenSize YJScreenSize()
#endif

#ifndef kUIScreenScale
#define kUIScreenScale YJScreenScale()
#endif

/* ------------------------------------------------------------------------------------------------------------ */

// UI Constants (Standard Height)

#ifndef kUINavigationBarHeight
#define kUINavigationBarHeight 44.0f
#endif

#ifndef kUIStatusBarHeight
#define kUIStatusBarHeight 20.0f
#endif

#ifndef kUITabBarHeight
#define kUITabBarHeight 49.0f
#endif

#ifndef kUIToolbarHeight
#define kUIToolbarHeight 44.0f
#endif

/* ------------------------------------------------------------------------------------------------------------ */

// UIWindow Snapshot

/**
 *  Take a screen snapshot to cover screen flash.
 */

#ifndef UIWindowSnapshotBegin
#define UIWindowSnapshotBegin() \
UIWindow *window = [UIApplication sharedApplication].keyWindow; \
UIView *yj_snapview_ = [window snapshotViewAfterScreenUpdates:NO]; \
[window addSubview:yj_snapview_];
#endif

#ifndef UIWindowSnapshotEnd
#define UIWindowSnapshotEnd() \
[yj_snapview_ removeFromSuperview];
#endif

/* ------------------------------------------------------------------------------------------------------------ */

// UIStatusBar

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

#endif /* YJUIMacros_h */
