//
//  NSMutableArray+YJSequence.m
//  YJKit
//
//  Created by huang-kun on 16/5/12.
//  Copyright © 2016年 huang-kun. All rights reserved.
//

#import "NSMutableArray+YJSequence.h"

@implementation NSMutableArray (YJSequence)

- (nullable id)removeFirst {
    id first = self.firstObject;
    if (first) [self removeObjectAtIndex:0];
    return first;
}

- (nullable id)removeLast {
    id last = self.lastObject;
    if (last) [self removeLastObject];
    return last;
}

static void _yj_mArrayKeep(NSMutableArray *self, NSInteger fromIndex, NSInteger toIndex) {
    
    if (toIndex == NSUIntegerMax) {
        toIndex = -1;
    } else {
        NSCAssert(toIndex < self.count, @"The end index %@ for trimming %@ is out of bounds %@: %@",
                  @(toIndex), self.class, @(self.count), self);
    }
    
    NSRange backRange = NSMakeRange(toIndex + 1, self.count - toIndex - 1);
    if (backRange.length > 0 && backRange.location < self.count && NSMaxRange(backRange) <= self.count) {
        [self removeObjectsInRange:backRange];
    }
    NSRange frontRange = NSMakeRange(0, fromIndex);
    if (frontRange.length > 0) [self removeObjectsInRange:frontRange];
}

- (void)droppingFirst {
    [self droppingFirst:1];
}

- (void)droppingFirst:(NSUInteger)count {
    NSAssert(count <= self.count, @"The count %@ is out of %@ count %@.", @(count), self.class, @(self.count));
    _yj_mArrayKeep(self, count, self.count - 1);
}

- (void)droppingLast {
    [self droppingLast:1];
}

- (void)droppingLast:(NSUInteger)count {
    NSAssert(count <= self.count, @"The count %@ is out of %@ count %@.", @(count), self.class, @(self.count));
    _yj_mArrayKeep(self, 0, self.count - count - 1);
}

- (void)prefixing:(NSUInteger)count {
    NSAssert(count <= self.count, @"The count %@ is out of %@ count %@.", @(count), self.class, @(self.count));
    _yj_mArrayKeep(self, 0, count - 1);
}

- (void)suffixing:(NSUInteger)count {
    NSAssert(count <= self.count, @"The count %@ is out of %@ count %@.", @(count), self.class, @(self.count));
    _yj_mArrayKeep(self, self.count - count, self.count - 1);
}

- (void)prefixingUpTo:(NSUInteger)upToIndex {
    NSAssert(upToIndex < self.count, @"The index %@ of end prefixing is beyond of %@ [0...%@].", @(upToIndex), self.class, @(self.count - 1));
    _yj_mArrayKeep(self, 0, upToIndex);
}

- (void)suffixingFrom:(NSUInteger)fromIndex {
    NSAssert(fromIndex < self.count, @"The index %@ of start suffixing is beyond of %@ [0...%@].", @(fromIndex), self.class, @(self.count - 1));
    _yj_mArrayKeep(self, fromIndex, self.count - 1);
}

- (void)sorting:(BOOL(^)(id, id))condition {
    [self sortUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        if (condition(obj1, obj2)) return NSOrderedAscending;
        else return NSOrderedDescending;
        return NSOrderedSame;
    }];
}

@end
