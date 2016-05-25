//
//  NSObject+YJTaggedPointerChecking.m
//  YJKit
//
//  Created by huang-kun on 16/5/25.
//  Copyright © 2016年 huang-kun. All rights reserved.
//
//  Reference: https://github.com/opensource-apple/objc4/blob/master/runtime/objc-internal.h

#import "NSObject+YJTaggedPointerChecking.h"

@implementation NSObject (YJTaggedPointerChecking)

- (BOOL)isTaggedPointer {
#if TARGET_OS_IPHONE
    return (intptr_t)self < 0;
#else
    return (uintptr_t)self & 1;
#endif
}

@end
