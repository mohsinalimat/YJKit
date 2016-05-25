//
//  NSMutableArray+YJCollection.m
//  YJKit
//
//  Created by huang-kun on 16/5/20.
//  Copyright © 2016年 huang-kun. All rights reserved.
//

#import "NSMutableArray+YJCollection.h"
#import "NSArray+YJCollection.h"

@implementation NSMutableArray (YJCollection)

- (void)mapping:(U  _Nonnull (^)(id _Nonnull))mapping {
    NSArray *mapped = [self map:mapping];
    [self setArray:mapped];
}

- (void)filtering:(BOOL (^)(id _Nonnull))condition {
    NSArray *filtered = [self filter:condition];
    [self setArray:filtered];
}

- (void)flattening {
    NSArray *flattened = [self flatten];
    [self setArray:flattened];
}

- (void)flatMapping:(U  _Nonnull (^)(id _Nonnull))mapping {
    NSArray *flatMapped = [self flatMap:mapping];
    [self setArray:flatMapped];
}

@end
