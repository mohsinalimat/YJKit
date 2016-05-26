//
//  NSArray+YJCollection.m
//  YJKit
//
//  Created by huang-kun on 16/5/4.
//  Copyright © 2016年 huang-kun. All rights reserved.
//

#import "NSArray+YJCollection.h"

@implementation NSArray (YJCollection)

- (NSArray *)mapped:(id(^)(id obj))mapping {
    if (!mapping) return @[];
    NSMutableArray *collector = [NSMutableArray arrayWithCapacity:self.count];
    for (id elem in self) {
        id value = [NSNull null];
        if (elem != [NSNull null]) {
            value = mapping(elem);
        }
        [collector addObject:value];
    }
    return [collector copy];
}

- (NSArray *)arrayByMappingEachObject:(U(^)(id obj))mapping {
    return [self mapped:mapping];
}

- (NSArray *)filtered:(BOOL(^)(id obj))condition {
    if (!condition) return @[];
    NSMutableArray *collector = [NSMutableArray arrayWithCapacity:self.count];
    for (id elem in self) {
        if (condition(elem)) {
            [collector addObject:elem];
        }
    }
    return [collector copy];
}

- (NSArray *)arrayByFilteringWithCondition:(BOOL(^)(id obj))condition {
    return [self filtered:condition];
}

- (nullable id)reduced:(nullable id)initial combine:(id(^)(id result, id obj))combine {
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

- (nullable id)objectByReducingArrayFromInitialObject:(nullable id)initial combinedWithObject:(id(^)(id result, id obj))combine {
    return [self reduced:initial combine:combine];
}

- (nullable id)reduced:(id(^)(id result, id obj))combine {
    return [self reduced:nil combine:combine];
}

- (nullable id)objectByReducingArrayCombinedWithObject:(id(^)(id result, id obj))combine {
    return [self reduced:combine];
}

- (NSArray *)flattened {
    return [self deepFlattened];
}

- (NSArray *)arrayByFlatteningRecursively {
    return [self deepFlattened];
}

// Recursively flattened each level of collections with light-weight type compatible
- (NSArray *)deepFlattened {
    NSMutableArray *collector = [NSMutableArray arrayWithCapacity:self.count];
    for (id elem in self) {
        if ([elem conformsToProtocol:@protocol(NSFastEnumeration)]) {
            if ([elem isKindOfClass:[NSArray class]]) {
                [collector addObjectsFromArray:[elem deepFlattened]];
            } else if ([elem isKindOfClass:[NSSet class]]) {
                [collector addObjectsFromArray:[[elem allObjects] deepFlattened]];
            } else {
                NSAssert([elem isKindOfClass:[NSArray class]] || [elem isKindOfClass:[NSSet class]], @"The nested collection type %@ is not much unified for using -[%@ %@].", [elem class], self.class, NSStringFromSelector(_cmd));
            }
        } else {
            [collector addObject:elem];
        }
    }
    return [collector copy];
}

- (NSArray *)flatMapped:(id(^)(id obj))mapping {
    return [[self mapped:mapping] flattened];
}

- (NSArray *)arrayByFlatMappingEachObject:(id(^)(id obj))mapping {
    return [self flatMapped:mapping];
}

@end
