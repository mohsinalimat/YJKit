//
//  NSObject+YJCategory_Swizzling.m
//  YJKit
//
//  Created by huang-kun on 16/5/13.
//  Copyright © 2016年 huang-kun. All rights reserved.
//

#import <objc/runtime.h>
#import "NSObject+YJCategory_Swizzling.h"

@implementation NSObject (YJCategory_Swizzling)

- (void)swizzleInstanceMethodForSelector:(SEL)fromSelector toSelector:(SEL)toSelector {
    Class class = [self class];
    Method fromMethod = class_getInstanceMethod(class, fromSelector);
    Method toMethod = class_getInstanceMethod(class, toSelector);
    BOOL added = class_addMethod(class, fromSelector, method_getImplementation(toMethod), method_getTypeEncoding(toMethod));
    if (added) class_replaceMethod(class, toSelector, method_getImplementation(fromMethod), method_getTypeEncoding(fromMethod));
    else method_exchangeImplementations(fromMethod, toMethod);
}

@end
