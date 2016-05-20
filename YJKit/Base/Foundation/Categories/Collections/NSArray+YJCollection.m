//
//  NSArray+YJCollection.m
//  YJKit
//
//  Created by huang-kun on 16/5/4.
//  Copyright © 2016年 huang-kun. All rights reserved.
//

#import "NSArray+YJCollection.h"

@implementation NSArray (YJCollection)

// Using [self.class arrayWithArray:] to achieve returning an instancetype.

- (id)map:(id(^)(id obj))mapping {
    if (!mapping) return @[];
    NSMutableArray *collector = [NSMutableArray arrayWithCapacity:self.count];
    for (id elem in self) {
        id value = [NSNull null];
        if (elem != [NSNull null]) {
            value = mapping(elem);
        }
        [collector addObject:value];
    }
    return [self.class arrayWithArray:collector];
}

- (instancetype)filter:(BOOL(^)(id obj))condition {
    if (!condition) return @[];
    NSMutableArray *collector = [NSMutableArray arrayWithCapacity:self.count];
    for (id elem in self) {
        if (condition(elem)) {
            [collector addObject:elem];
        }
    }
    return [self.class arrayWithArray:collector];
}

- (nullable id)reduce:(nullable id)initial combine:(id(^)(id result, id obj))combine {
    if (self.count < 2) return self.firstObject;
    NSUInteger startIndex = initial ? [self indexOfObject:initial] : 0;
    NSAssert(startIndex != NSNotFound, @"The initial object %@ for reducing is not in the %@: %@.", initial, self.class, self);
    id result = self[startIndex];
    for (NSUInteger i = startIndex + 1; i < self.count; ++i) {
        if (combine) {
            id temp = combine(result, self[i]);
            if (temp) result = temp;
        }
    }
    return result;
}

- (nullable id)reduce:(id(^)(id result, id obj))combine {
    return [self reduce:nil combine:combine];
}

- (id)flatten {
    return [self deepFlatten];
}

// Recursively flatten each level of collections with light-weight type compatible
- (id)deepFlatten {
    NSMutableArray *collector = [NSMutableArray arrayWithCapacity:self.count];
    for (id elem in self) {
        if ([elem conformsToProtocol:@protocol(NSFastEnumeration)]) {
            if ([elem isKindOfClass:[NSArray class]]) {
                [collector addObjectsFromArray:[elem deepFlatten]];
            } else if ([elem isKindOfClass:[NSSet class]]) {
                [collector addObjectsFromArray:[[elem allObjects] deepFlatten]];
            } else {
                NSAssert([elem isKindOfClass:[NSArray class]] || [elem isKindOfClass:[NSSet class]], @"The nested collection type %@ is not much unified for using -[%@ %@].", [elem class], self.class, NSStringFromSelector(_cmd));
            }
        } else {
            [collector addObject:elem];
        }
    }
    return [self.class arrayWithArray:collector];
}

- (id)flatMap:(id(^)(id obj))mapping {
    return [[self map:mapping] flatten];
}

@end
