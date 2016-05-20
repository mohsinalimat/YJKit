//
//  YJKit.h
//  YJKit
//
//  Created by huang-kun on 16/3/20.
//  Copyright © 2016年 huang-kun. All rights reserved.
//

#ifndef YJKit_h
#define YJKit_h

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#if __has_include(<YJKit/YJKit.h>)

#import <YJKit/YJMacros.h>

#import <YJKit/YJContentIndents.h>

#import <YJKit/CGGeometry_YJExtension.h>
#import <YJKit/CAShapeLayer+YJCategory.h>

#import <YJKit/NSObject+YJMutabilityChecking.h>
#import <YJKit/NSObject+YJCategory_KVO.h>
#import <YJKit/NSObject+YJCategory_Swizzling.h>

#import <YJKit/NSString+YJSequence.h>
#import <YJKit/NSArray+YJSequence.h>
#import <YJKit/NSMutableArray+YJSequence.h>
#import <YJKit/NSArray+YJCollection.h>
#import <YJKit/NSSet+YJCollection.h>

#import <YJKit/NSBundle+YJCategory.h>
#import <YJKit/NSTimer+YJCategory.h>
#import <YJKit/YJMemoryCache.h>

#import <YJKit/UIBezierPath+YJCategory.h>
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
#import <YJKit/UIActionSheet+YJCategory.h>

#import <YJKit/YJLayerBasedMasking.h>
#import <YJKit/YJRoundedCornerView.h>
#import <YJKit/YJCircularImageView.h>
#import <YJKit/YJRoundedCornerImageView.h>
#import <YJKit/YJRoundedCornerButton.h>
#import <YJKit/YJRoundedCornerLabel.h>
#import <YJKit/YJSemicircularCornerButton.h>
#import <YJKit/YJSemicircularCornerLabel.h>
#import <YJKit/YJRoundedCornerTextView.h>

#import <YJKit/YJPhotoLibrary.h>
#import <YJKit/YJGroupedStyleTableViewController.h>

#else

#import "YJMacros.h"

#import "YJContentIndents.h"

#import "CGGeometry_YJExtension.h"
#import "CAShapeLayer+YJCategory.h"

#import "NSObject+YJMutabilityChecking.h"
#import "NSObject+YJCategory_KVO.h"
#import "NSObject+YJCategory_Swizzling.h"

#import "NSString+YJSequence.h"
#import "NSArray+YJSequence.h"
#import "NSMutableArray+YJSequence.h"
#import "NSArray+YJCollection.h"
#import "NSSet+YJCollection.h"

#import "NSBundle+YJCategory.h"
#import "NSTimer+YJCategory.h"
#import "YJMemoryCache.h"

#import "UIBezierPath+YJCategory.h"
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
#import "UIActionSheet+YJCategory.h"

#import "YJLayerBasedMasking.h"
#import "YJRoundedCornerView.h"
#import "YJCircularImageView.h"
#import "YJRoundedCornerImageView.h"
#import "YJRoundedCornerButton.h"
#import "YJRoundedCornerLabel.h"
#import "YJSemicircularCornerButton.h"
#import "YJSemicircularCornerLabel.h"
#import "YJRoundedCornerTextView.h"

#import "YJPhotoLibrary.h"
#import "YJGroupedStyleTableViewController.h"

#endif

#endif /* YJKit_h */
