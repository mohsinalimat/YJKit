//
//  NSSet+YJCollection.m
//  YJKit
//
//  Created by huang-kun on 16/5/5.
//  Copyright © 2016年 huang-kun. All rights reserved.
//

#import "NSSet+YJCollection.h"

@implementation NSSet (YJCollection)

- (NSSet *)mapped:(id(^)(id obj))mapping {
    if (!mapping) return [NSSet set];
    NSMutableSet *collector = [NSMutableSet setWithCapacity:self.count];
    for (id elem in self) {
        id value = mapping(elem);
        if (value) [collector addObject:value];
    }
    return [collector copy];
}

- (NSSet *)setByMappingEachObject:(id(^)(id obj))mapping {
    return [self mapped:mapping];
}

- (NSSet *)filtered:(BOOL(^)(id obj))condition {
    if (!condition) return [NSSet set];
    NSMutableSet *collector = [NSMutableSet setWithCapacity:self.count];
    for (id elem in self) {
        if (condition(elem)) {
            [collector addObject:elem];
        }
    }
    return [collector copy];
}

- (NSSet *)setByFilteringWithCondition:(BOOL(^)(id obj))condition {
    return [self filtered:condition];
}

- (nullable id)reduced:(id(^)(id result, id obj))combine {
    id result = [self anyObject];
    for (id obj in self) {
        if (combine && ![obj isEqual:result]) {
            id temp = combine(result, obj);
            if (temp) result = temp;
        }
    }
    return result;
}

- (nullable id)objectByReducingSetCombinedWithObject:(id(^)(id result, id obj))combine {
    return [self reduced:combine];
}

- (NSSet *)flattened {
    return [self deepFlattened];
}

- (NSSet *)setByFlatteningRecursively {
    return [self deepFlattened];
}

- (NSSet *)deepFlattened {
    NSMutableSet *collector = [NSMutableSet setWithCapacity:self.count];
    for (id elem in self) {
        if ([elem conformsToProtocol:@protocol(NSFastEnumeration)]) {
            if ([elem isKindOfClass:[NSArray class]]) {
                [collector addObjectsFromArray:(id)[elem deepFlattened]];
            } else if ([elem isKindOfClass:[NSSet class]]) {
                [collector unionSet:[elem deepFlattened]];
            } else {
                NSAssert([elem isKindOfClass:[NSArray class]] || [elem isKindOfClass:[NSSet class]], @"The nested collection type %@ is not much unified for using -[%@ %@].", [elem class], self.class, NSStringFromSelector(_cmd));
            }
        } else {
            [collector addObject:elem];
        }
    }
    return [collector copy];
}

- (NSSet *)flatMapped:(id(^)(id obj))mapping {
    return [[self mapped:mapping] flattened];
}

- (NSSet *)setByFlatMappingEachObject:(id(^)(id obj))mapping {
    return [self flatMapped:mapping];
}

@end
