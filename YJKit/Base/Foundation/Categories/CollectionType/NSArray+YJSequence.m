//
//  NSArray+YJSequence.m
//  YJKit
//
//  Created by huang-kun on 16/5/16.
//  Copyright © 2016年 huang-kun. All rights reserved.
//

#import "NSArray+YJSequence.h"

@implementation NSArray (YJSequence)

static NSArray * _yj_arrayKeep(NSArray *self, NSInteger fromIndex, NSInteger toIndex) {
    
    if (toIndex == NSUIntegerMax) {
        toIndex = -1;
    } else {
        NSCAssert(toIndex < self.count, @"The end index %@ for trimming %@ is out of bounds %@: %@",
                  @(toIndex), self.class, @(self.count), self);
    }
    
    if (fromIndex >= self.count || toIndex < 0) return @[];
    NSMutableArray *collector = [NSMutableArray arrayWithCapacity:self.count];
    for (NSUInteger i = fromIndex; i <= toIndex; ++i) {
        id object = [self objectAtIndex:i];
        [collector addObject:object];
    }
    return [collector copy];
}

- (NSArray *)droppingFirst {
    return [self droppingFirst:1];
}

- (NSArray *)arrayByDroppingFirstObject {
    return [self droppingFirst:1];
}

- (NSArray *)droppingFirst:(NSUInteger)count {
    NSAssert(count <= self.count, @"The count %@ is out of %@ count %@.", @(count), self.class, @(self.count));
    return _yj_arrayKeep(self, count, self.count - 1);
}

- (NSArray *)arrayByDroppingFirstObjectsWithCount:(NSUInteger)count {
    return [self droppingFirst:count];
}

- (NSArray *)droppingLast {
    return [self droppingLast:1];
}

- (NSArray *)arrayByDroppingLastObject {
    return [self droppingLast:1];
}

- (NSArray *)droppingLast:(NSUInteger)count {
    NSAssert(count <= self.count, @"The count %@ is out of %@ count %@.", @(count), self.class, @(self.count));
    return _yj_arrayKeep(self, 0, self.count - count - 1);
}

- (NSArray *)arrayByDroppingLastObjectsWithCount:(NSUInteger)count {
    return [self droppingLast:count];
}

- (NSArray *)prefixed:(NSUInteger)count {
    NSAssert(count <= self.count, @"The count %@ is out of %@ count %@.", @(count), self.class, @(self.count));
    return _yj_arrayKeep(self, 0, count - 1);
}

- (NSArray *)arrayByPrefixingObjectsWithCount:(NSUInteger)count {
    return [self prefixed:count];
}

- (NSArray *)suffixed:(NSUInteger)count {
    NSAssert(count <= self.count, @"The count %@ is out of %@ count %@.", @(count), self.class, @(self.count));
    return _yj_arrayKeep(self, self.count - count, self.count - 1);
}

- (NSArray *)arrayBySuffixingObjectsWithCount:(NSUInteger)count {
    return [self suffixed:count];
}

- (NSArray *)prefixingUpToIndex:(NSUInteger)upToIndex {
    NSAssert(upToIndex < self.count, @"The index %@ of end prefix is beyond of %@ [0...%@].", @(upToIndex), self.class, @(self.count - 1));
    return _yj_arrayKeep(self, 0, upToIndex);
}

- (NSArray *)arrayByPrefixingObjectsUpToIndex:(NSUInteger)upToIndex {
    return [self prefixingUpToIndex:upToIndex];
}

- (NSArray *)suffixingFromIndex:(NSUInteger)fromIndex {
    NSAssert(fromIndex < self.count, @"The index %@ of start suffix is beyond of %@ [0...%@].", @(fromIndex), self.class, @(self.count - 1));
    return _yj_arrayKeep(self, fromIndex, self.count - 1);
}

- (NSArray *)arrayBySuffixingObjectsFromIndex:(NSUInteger)fromIndex {
    return [self suffixingFromIndex:fromIndex];
}

- (NSArray *)sorted:(BOOL(^)(id, id))condition {
    return [self sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        if (condition(obj1, obj2)) return NSOrderedAscending;
        else return NSOrderedDescending;
        return NSOrderedSame;
    }];
}

- (NSArray *)arrayBySortingWithCondition:(BOOL(^)(id obj1, id obj2))condition {
    return [self sorted:condition];
}

@end
