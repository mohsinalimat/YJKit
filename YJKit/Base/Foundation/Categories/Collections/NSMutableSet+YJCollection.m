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

- (void)mapping:(U  _Nonnull (^)(id _Nonnull))mapping {
    NSSet *mapped = [self map:mapping];
    [self setSet:mapped];
}

- (void)filtering:(BOOL (^)(id _Nonnull))condition {
    NSSet *filtered = [self filter:condition];
    [self setSet:filtered];
}

- (void)flattening {
    NSSet *flattened = [self flatten];
    [self setSet:flattened];
}

- (void)flatMapping:(U  _Nonnull (^)(id _Nonnull))mapping {
    NSSet *flatMapped = [self flatMap:mapping];
    [self setSet:flatMapped];
}

@end
