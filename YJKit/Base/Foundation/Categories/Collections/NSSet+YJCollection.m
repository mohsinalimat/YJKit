//
//  NSSet+YJCollection.m
//  YJKit
//
//  Created by huang-kun on 16/5/5.
//  Copyright © 2016年 huang-kun. All rights reserved.
//

#import "NSSet+YJCollection.h"

@implementation NSSet (YJCollection)

- (NSSet *)map:(id(^)(id obj))mapping {
    if (!mapping) return [NSSet set];
    NSMutableSet *collector = [NSMutableSet setWithCapacity:self.count];
    for (id elem in self) {
        id value = mapping(elem);
        if (value) [collector addObject:value];
    }
    return [collector copy];
}

- (NSSet *)filter:(BOOL(^)(id obj))condition {
    if (!condition) return [NSSet set];
    NSMutableSet *collector = [NSMutableSet setWithCapacity:self.count];
    for (id elem in self) {
        if (condition(elem)) {
            [collector addObject:elem];
        }
    }
    return [collector copy];
}

- (nullable id)reduce:(id(^)(id result, id obj))combine {
    id result = [self anyObject];
    for (id obj in self) {
        if (combine && ![obj isEqual:result]) {
            id temp = combine(result, obj);
            if (temp) result = temp;
        }
    }
    return result;
}

- (NSSet *)flatten {
    return [self deepFlatten];
}

- (NSSet *)deepFlatten {
    NSMutableSet *collector = [NSMutableSet setWithCapacity:self.count];
    for (id elem in self) {
        if ([elem conformsToProtocol:@protocol(NSFastEnumeration)]) {
            if ([elem isKindOfClass:[NSArray class]]) {
                [collector addObjectsFromArray:(id)[elem deepFlatten]];
            } else if ([elem isKindOfClass:[NSSet class]]) {
                [collector unionSet:[elem deepFlatten]];
            } else {
                NSAssert([elem isKindOfClass:[NSArray class]] || [elem isKindOfClass:[NSSet class]], @"The nested collection type %@ is not much unified for using -[%@ %@].", [elem class], self.class, NSStringFromSelector(_cmd));
            }
        } else {
            [collector addObject:elem];
        }
    }
    return [collector copy];
}

- (NSSet *)flatMap:(id(^)(id obj))mapping {
    return [[self map:mapping] flatten];
}

@end
