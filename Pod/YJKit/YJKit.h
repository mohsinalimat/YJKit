//
//  YJKit.h
//  YJKit
//
//  Created by Jack Huang on 16/3/20.
//  Copyright © 2016年 Jack Huang. All rights reserved.
//

@import Foundation;
@import UIKit;

#if __has_include(<YJKit/YJKit.h>)
#import <YJKit/YJMacros.h>
#import <YJKit/NSBundle+YJCategory.h>
#import <YJKit/YJMemoryCache.h>
#import <YJKit/UIView+YJCategory.h>
#import <YJKit/UIImage+YJCategory.h>
#import <YJKit/UIDevice+YJCategory.h>
#import <YJKit/UIScreen+YJCategory.h>
#import <YJKit/CGGeometry_YJExtension.h>
#else
#import "YJMacros.h"
#import "NSBundle+YJCategory.h"
#import "YJMemoryCache.h"
#import "UIView+YJCategory.h"
#import "UIImage+YJCategory.h"
#import "UIDevice+YJCategory.h"
#import "UIScreen+YJCategory.h"
#import "CGGeometry_YJExtension.h"
#endif