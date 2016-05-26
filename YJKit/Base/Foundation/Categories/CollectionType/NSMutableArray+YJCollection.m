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

- (void)mapEachObject:(id(^)(id obj))mapping {
    NSArray *mapped = [self mapped:mapping];
    [self setArray:mapped];
}

- (void)filterWithCondition:(BOOL(^)(id obj))condition {
    NSArray *filtered = [self filtered:condition];
    [self setArray:filtered];
}

- (void)flattenRecursively {
    NSArray *flattened = [self flattened];
    [self setArray:flattened];
}

- (void)flatMapEachObject:(id(^)(id obj))mapping {
    NSArray *flatMapped = [self flatMapped:mapping];
    [self setArray:flatMapped];
}

@end
