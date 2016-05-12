//
//  NSSet+YJCollection.m
//  YJKit
//
//  Created by huang-kun on 16/5/5.
//  Copyright © 2016年 huang-kun. All rights reserved.
//

#import "NSSet+YJCollection.h"

@implementation NSSet (YJCollection)

- (instancetype)map:(id(^)(id obj))mapping {
    if (!mapping) return [NSSet set];
    NSMutableSet *collector = [NSMutableSet setWithCapacity:self.count];
    for (id elem in self) {
        id value = mapping(elem);
        if (value) [collector addObject:value];
    }
    return [self.class setWithSet:collector];
}

- (instancetype)filter:(BOOL(^)(id obj))condition {
    if (!condition) return [NSSet set];
    NSMutableSet *collector = [NSMutableSet setWithCapacity:self.count];
    for (id elem in self) {
        if (condition(elem)) {
            [collector addObject:elem];
        }
    }
    return [self.class setWithSet:collector];
}

- (id)reduce:(id(^)(id result, id obj))combine {
    id result = [self anyObject];
    for (id obj in self) {
        if (combine && ![obj isEqual:result]) {
            id temp = combine(result, obj);
            if (temp) result = temp;
        }
    }
    return result;
}

- (instancetype)flatten {
    return [self deepFlatten];
}

- (instancetype)deepFlatten {
    NSMutableSet *collector = [NSMutableSet setWithCapacity:self.count];
    for (id elem in self) {
        if ([elem conformsToProtocol:@protocol(NSFastEnumeration)]) {
            [collector unionSet:[elem deepFlatten]];
        } else {
            [collector addObject:elem];
        }
    }
    return [self.class setWithSet:collector];
}

- (instancetype)flatMap:(id(^)(id obj))mapping {
    return [[self map:mapping] flatten];
}

@end
