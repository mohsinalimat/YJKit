//
//  NSArray+YJSequence.m
//  YJKit
//
//  Created by huang-kun on 16/5/16.
//  Copyright © 2016年 huang-kun. All rights reserved.
//

#import "NSArray+YJSequence.h"

@implementation NSArray (YJSequence)

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

- (NSArray *)sorted:(BOOL(^)(id, id))condition {
    return [self sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        if (condition(obj1, obj2)) return NSOrderedAscending;
        else return NSOrderedDescending;
        return NSOrderedSame;
    }];
}

@end
