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

- (instancetype)map:(id(^)(id obj))mapping {
    if (!mapping) return @[];
    NSMutableArray *collector = [NSMutableArray arrayWithCapacity:self.count];
    for (id elem in self) {
        id value = mapping(elem);
        if (value) [collector addObject:value];
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

- (id)reduce:(id)initial combine:(id(^)(id result, id obj))combine {
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

- (instancetype)flatten {
    return [self deepFlatten];
}

// Recursively flatten each level of collections
- (instancetype)deepFlatten {
    NSMutableArray *collector = [NSMutableArray arrayWithCapacity:self.count];
    for (id elem in self) {
        if ([elem conformsToProtocol:@protocol(NSFastEnumeration)]) {
            [collector addObjectsFromArray:[elem deepFlatten]];
        } else {
            [collector addObject:elem];
        }
    }
    return [self.class arrayWithArray:collector];
}

- (instancetype)flatMap:(id(^)(id obj))mapping {
    return [[self map:mapping] flatten];
}

- (instancetype)dropFirst:(NSUInteger)count {
    NSAssert(count <= self.count, @"The count %@ is out of %@ count %@.", @(count), self.class, @(self.count));
    if (count == self.count) return @[];
    NSMutableArray *collector = [NSMutableArray arrayWithCapacity:self.count];
    for (NSUInteger i = count; i < self.count; ++i) {
        [collector addObject:self[i]];
    }
    return [self.class arrayWithArray:collector];
}

- (instancetype)dropLast:(NSUInteger)count {
    NSAssert(count <= self.count, @"The count %@ is out of %@ count %@.", @(count), self.class, @(self.count));
    if (count == self.count) return @[];
    NSMutableArray *collector = [NSMutableArray arrayWithCapacity:self.count];
    for (NSUInteger i = 0; i < self.count - count; ++i) {
        [collector addObject:self[i]];
    }
    return [self.class arrayWithArray:collector];
}

- (instancetype)prefix:(NSUInteger)count {
    NSAssert(count <= self.count, @"The count %@ is out of %@ count %@.", @(count), self.class, @(self.count));
    if (!self.count) return @[];
    NSMutableArray *collector = [NSMutableArray arrayWithCapacity:self.count];
    for (NSUInteger i = 0; i < count; ++i) {
        [collector addObject:self[i]];
    }
    return [self.class arrayWithArray:collector];
}

- (instancetype)suffix:(NSUInteger)count {
    NSAssert(count <= self.count, @"The count %@ is out of %@ count %@.", @(count), self.class, @(self.count));
    if (!self.count) return @[];
    NSMutableArray *collector = [NSMutableArray arrayWithCapacity:self.count];
    for (NSUInteger i = self.count - count; i < self.count; ++i) {
        [collector addObject:self[i]];
    }
    return [self.class arrayWithArray:collector];
}

- (instancetype)prefixUpTo:(NSUInteger)upToIndex {
    if (!self.count) return @[];
    NSAssert(upToIndex < self.count, @"The index %@ of end prefix is beyond of %@ [0...%@].", @(upToIndex), self.class, @(self.count - 1));
    NSMutableArray *collector = [NSMutableArray arrayWithCapacity:self.count];
    for (NSUInteger i = 0; i <= upToIndex; ++i) {
        [collector addObject:self[i]];
    }
    return [self.class arrayWithArray:collector];
}

- (instancetype)suffixFrom:(NSUInteger)fromIndex {
    if (!self.count) return @[];
    NSAssert(fromIndex < self.count, @"The index %@ of start suffix is beyond of %@ [0...%@].", @(fromIndex), self.class, @(self.count - 1));
    NSMutableArray *collector = [NSMutableArray arrayWithCapacity:self.count];
    for (NSUInteger i = fromIndex; i < self.count; ++i) {
        [collector addObject:self[i]];
    }
    return [self.class arrayWithArray:collector];
}

@end
