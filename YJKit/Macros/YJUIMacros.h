//
//  YJUIMacros.h
//  YJKit
//
//  Created by Jack Huang on 16/4/16.
//  Copyright © 2016年 huang-kun. All rights reserved.
//

#ifndef YJUIMacros_h
#define YJUIMacros_h

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

#endif /* YJUIMacros_h */
