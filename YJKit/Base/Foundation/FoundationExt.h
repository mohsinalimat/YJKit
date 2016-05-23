//
//  FoundationExt.h
//  YJKit
//
//  Created by huang-kun on 16/5/22.
//  Copyright © 2016年 huang-kun. All rights reserved.
//

#if __has_include(<YJKit/FoundationExt.h>)

#import <YJKit/NSObject+YJMutabilityChecking.h>
#import <YJKit/NSObject+YJCategory_Swizzling.h>
#import <YJKit/NSObject+YJBlockBasedKVO.h>

#import <YJKit/NSCoder+YJCategory.h>
#import <YJKit/NSNumber+YJCategory.h>

#import <YJKit/NSString+YJCollection.h>
#import <YJKit/NSString+YJSequence.h>
#import <YJKit/NSMutableString+YJSequence.h>
#import <YJKit/NSArray+YJCollection.h>
#import <YJKit/NSArray+YJSequence.h>
#import <YJKit/NSMutableArray+YJCollection.h>
#import <YJKit/NSMutableArray+YJSequence.h>
#import <YJKit/NSSet+YJCollection.h>
#import <YJKit/NSMutableSet+YJCollection.h>

#import <YJKit/NSBundle+YJCategory.h>
#import <YJKit/NSTimer+YJBlockBased.h>

#else

#import "NSObject+YJMutabilityChecking.h"
#import "NSObject+YJCategory_Swizzling.h"
#import "NSObject+YJBlockBasedKVO.h"

#import "NSCoder+YJCategory.h"
#import "NSNumber+YJCategory.h"

#import "NSString+YJCollection.h"
#import "NSString+YJSequence.h"
#import "NSMutableString+YJSequence.h"
#import "NSArray+YJCollection.h"
#import "NSArray+YJSequence.h"
#import "NSMutableArray+YJCollection.h"
#import "NSMutableArray+YJSequence.h"
#import "NSSet+YJCollection.h"
#import "NSMutableSet+YJCollection.h"

#import "NSBundle+YJCategory.h"
#import "NSTimer+YJBlockBased.h"

#endif
