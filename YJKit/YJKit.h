//
//  YJKit.h
//  YJKit
//
//  Created by huang-kun on 16/3/20.
//  Copyright © 2016年 huang-kun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#if __has_include(<YJKit/YJKit.h>)
#import <YJKit/YJMacros.h>
#import <YJKit/CGGeometry_YJExtension.h>
#import <YJKit/NSObject+YJCategory_KVO.h>
#import <YJKit/NSBundle+YJCategory.h>
#import <YJKit/YJMemoryCache.h>
#import <YJKit/UIView+YJCategory.h>
#import <YJKit/UIImage+YJCategory.h>
#import <YJKit/UIDevice+YJCategory.h>
#import <YJKit/UIScreen+YJCategory.h>
#import <YJKit/UIImageView+YJCategory.h>
#import <YJKit/UIColor+YJCategory.h>
#import <YJKit/UIControl+YJCategory.h>
#import <YJKit/UIGestureRecognizer+YJCategory.h>
#import <YJKit/UIBarButtonItem+YJCategory.h>
#import <YJKit/UIAlertView+YJCategory.h>
#else
#import "YJMacros.h"
#import "CGGeometry_YJExtension.h"
#import "NSObject+YJCategory_KVO.h"
#import "NSBundle+YJCategory.h"
#import "YJMemoryCache.h"
#import "UIView+YJCategory.h"
#import "UIImage+YJCategory.h"
#import "UIDevice+YJCategory.h"
#import "UIScreen+YJCategory.h"
#import "UIImageView+YJCategory.h"
#import "UIColor+YJCategory.h"
#import "UIControl+YJCategory.h"
#import "UIGestureRecognizer+YJCategory.h"
#import "UIBarButtonItem+YJCategory.h"
#import "UIAlertView+YJCategory.h"
#endif