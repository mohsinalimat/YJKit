//
//  NSArray+YJSequence.m
//  YJKit
//
//  Created by huang-kun on 16/5/16.
//  Copyright © 2016年 huang-kun. All rights reserved.
//

#import "NSArray+YJSequence.h"
#import "NSObject+YJMutabilityChecking.h"

@implementation NSArray (YJSequence)

id _yj_arrayKeep(NSArray *self, NSInteger fromIndex, NSInteger toIndex) {
    
    if (toIndex == NSUIntegerMax) {
        toIndex = -1;
    } else {
        NSCAssert(toIndex < self.count, @"The end index %@ for trimming %@ is out of bounds %@: %@",
                  @(toIndex), self.class, @(self.count), self);
    }
    
    if (self.isMutable) {
        NSMutableArray *_self = (NSMutableArray *)self;
        NSRange backRange = NSMakeRange(toIndex + 1, _self.count - toIndex - 1);
        if (backRange.length > 0 && backRange.location < _self.count && NSMaxRange(backRange) <= _self.count) {
            [_self removeObjectsInRange:backRange];
        }
        NSRange frontRange = NSMakeRange(0, fromIndex);
        if (frontRange.length > 0) [_self removeObjectsInRange:frontRange];
        return _self;
    } else {
        if (fromIndex >= self.count || toIndex < 0) return @[];
        NSMutableArray *collector = [NSMutableArray arrayWithCapacity:self.count];
        for (NSUInteger i = fromIndex; i <= toIndex; ++i) {
            id object = [self objectAtIndex:i];
            [collector addObject:object];
        }
        return [collector copy];
    }
}

- (id)dropFirst {
    return [self dropFirst:1];
}

- (id)dropFirst:(NSUInteger)count {
    NSAssert(count <= self.count, @"The count %@ is out of %@ count %@.", @(count), self.class, @(self.count));
    return _yj_arrayKeep(self, count, self.count - 1);
//    if (count == self.count) return @[];
//    NSMutableArray *collector = [NSMutableArray arrayWithCapacity:self.count];
//    for (NSUInteger i = count; i < self.count; ++i) {
//        [collector addObject:self[i]];
//    }
//    return [self.class arrayWithArray:collector];
}

- (id)dropLast {
    return [self dropLast:1];
}

- (id)dropLast:(NSUInteger)count {
    NSAssert(count <= self.count, @"The count %@ is out of %@ count %@.", @(count), self.class, @(self.count));
    return _yj_arrayKeep(self, 0, self.count - count - 1);
//    if (count == self.count) return @[];
//    NSMutableArray *collector = [NSMutableArray arrayWithCapacity:self.count];
//    for (NSUInteger i = 0; i < self.count - count; ++i) {
//        [collector addObject:self[i]];
//    }
//    return [self.class arrayWithArray:collector];
}

- (id)prefix:(NSUInteger)count {
    NSAssert(count <= self.count, @"The count %@ is out of %@ count %@.", @(count), self.class, @(self.count));
    return _yj_arrayKeep(self, 0, count - 1);
//    if (!self.count) return @[];
//    NSMutableArray *collector = [NSMutableArray arrayWithCapacity:self.count];
//    for (NSUInteger i = 0; i < count; ++i) {
//        [collector addObject:self[i]];
//    }
//    return [self.class arrayWithArray:collector];
}

- (id)suffix:(NSUInteger)count {
    NSAssert(count <= self.count, @"The count %@ is out of %@ count %@.", @(count), self.class, @(self.count));
    return _yj_arrayKeep(self, self.count - count, self.count - 1);
//    if (!self.count) return @[];
//    NSMutableArray *collector = [NSMutableArray arrayWithCapacity:self.count];
//    for (NSUInteger i = self.count - count; i < self.count; ++i) {
//        [collector addObject:self[i]];
//    }
//    return [self.class arrayWithArray:collector];
}

- (id)prefixUpTo:(NSUInteger)upToIndex {
//    if (!self.count) return @[];
    NSAssert(upToIndex < self.count, @"The index %@ of end prefix is beyond of %@ [0...%@].", @(upToIndex), self.class, @(self.count - 1));
    return _yj_arrayKeep(self, 0, upToIndex);
//    NSMutableArray *collector = [NSMutableArray arrayWithCapacity:self.count];
//    for (NSUInteger i = 0; i <= upToIndex; ++i) {
//        [collector addObject:self[i]];
//    }
//    return [self.class arrayWithArray:collector];
}

- (id)suffixFrom:(NSUInteger)fromIndex {
//    if (!self.count) return @[];
    NSAssert(fromIndex < self.count, @"The index %@ of start suffix is beyond of %@ [0...%@].", @(fromIndex), self.class, @(self.count - 1));
    return _yj_arrayKeep(self, fromIndex, self.count - 1);
//    NSMutableArray *collector = [NSMutableArray arrayWithCapacity:self.count];
//    for (NSUInteger i = fromIndex; i < self.count; ++i) {
//        [collector addObject:self[i]];
//    }
//    return [self.class arrayWithArray:collector];
}

- (NSArray *)sorted:(BOOL(^)(id, id))condition {
    return [self sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        if (condition(obj1, obj2)) return NSOrderedAscending;
        else return NSOrderedDescending;
        return NSOrderedSame;
    }];
}

@end
