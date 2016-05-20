//
//  NSObject+YJMutabilityChecking.m
//  YJKit
//
//  Created by huang-kun on 16/5/20.
//  Copyright © 2016年 huang-kun. All rights reserved.
//

#import "NSObject+YJMutabilityChecking.h"

@implementation NSObject (YJMutabilityChecking)

- (BOOL)isMutable {
    NSAssert([self conformsToProtocol:@protocol(NSCopying)], @"The receiver %@ for message -isMutable MUST conforms to NSCopying.", self);
    return self.copy == self ? NO : YES;
}

@end
