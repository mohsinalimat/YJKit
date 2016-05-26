//
//  NSMutableSet+YJCollection.m
//  YJKit
//
//  Created by huang-kun on 16/5/20.
//  Copyright © 2016年 huang-kun. All rights reserved.
//

#import "NSMutableSet+YJCollection.h"
#import "NSSet+YJCollection.h"

@implementation NSMutableSet (YJCollection)

- (void)mapEachObject:(U  _Nonnull (^)(id _Nonnull))mapping {
    NSSet *mapped = [self mapped:mapping];
    [self setSet:mapped];
}

- (void)filterWithCondition:(BOOL (^)(id _Nonnull))condition {
    NSSet *filtered = [self filtered:condition];
    [self setSet:filtered];
}

- (void)flattenRecursively {
    NSSet *flattened = [self flattened];
    [self setSet:flattened];
}

- (void)flatMapEachObject:(U  _Nonnull (^)(id _Nonnull))mapping {
    NSSet *flatMapped = [self flatMapped:mapping];
    [self setSet:flatMapped];
}

@end
