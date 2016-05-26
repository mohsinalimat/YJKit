//
//  NSMutableArray+YJSequence.m
//  YJKit
//
//  Created by huang-kun on 16/5/12.
//  Copyright © 2016年 huang-kun. All rights reserved.
//

#import "NSMutableArray+YJSequence.h"

@implementation NSMutableArray (YJSequence)

- (nullable id)poppedFirstObject {
    id first = self.firstObject;
    if (first) [self removeObjectAtIndex:0];
    return first;
}

- (nullable id)poppedLastObject {
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

- (void)dropFirstObject {
    [self dropFirstObjectsWithCount:1];
}

- (void)dropFirstObjectsWithCount:(NSUInteger)count {
    NSAssert(count <= self.count, @"The count %@ is out of %@ count %@.", @(count), self.class, @(self.count));
    _yj_mArrayKeep(self, count, self.count - 1);
}

- (void)dropLastObject {
    [self dropLastObjectsWithCount:1];
}

- (void)dropLastObjectsWithCount:(NSUInteger)count {
    NSAssert(count <= self.count, @"The count %@ is out of %@ count %@.", @(count), self.class, @(self.count));
    _yj_mArrayKeep(self, 0, self.count - count - 1);
}

- (void)prefixObjectsWithCount:(NSUInteger)count {
    NSAssert(count <= self.count, @"The count %@ is out of %@ count %@.", @(count), self.class, @(self.count));
    _yj_mArrayKeep(self, 0, count - 1);
}

- (void)suffixObjectsWithCount:(NSUInteger)count {
    NSAssert(count <= self.count, @"The count %@ is out of %@ count %@.", @(count), self.class, @(self.count));
    _yj_mArrayKeep(self, self.count - count, self.count - 1);
}

- (void)prefixObjectsUpToIndex:(NSUInteger)upToIndex {
    NSAssert(upToIndex < self.count, @"The index %@ of end prefixing is beyond of %@ [0...%@].", @(upToIndex), self.class, @(self.count - 1));
    _yj_mArrayKeep(self, 0, upToIndex);
}

- (void)suffixObjectsFromIndex:(NSUInteger)fromIndex {
    NSAssert(fromIndex < self.count, @"The index %@ of start suffixing is beyond of %@ [0...%@].", @(fromIndex), self.class, @(self.count - 1));
    _yj_mArrayKeep(self, fromIndex, self.count - 1);
}

- (void)sortWithCondition:(BOOL(^)(id obj1, id obj2))condition {
    [self sortUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        if (condition(obj1, obj2)) return NSOrderedAscending;
        else return NSOrderedDescending;
        return NSOrderedSame;
    }];
}

@end
