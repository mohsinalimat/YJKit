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

- (NSArray *)dropFirst {
    return [self dropFirst:1];
}

- (NSArray *)dropFirst:(NSUInteger)count {
    NSAssert(count <= self.count, @"The count %@ is out of %@ count %@.", @(count), self.class, @(self.count));
    return _yj_arrayKeep(self, count, self.count - 1);
}

- (NSArray *)dropLast {
    return [self dropLast:1];
}

- (NSArray *)dropLast:(NSUInteger)count {
    NSAssert(count <= self.count, @"The count %@ is out of %@ count %@.", @(count), self.class, @(self.count));
    return _yj_arrayKeep(self, 0, self.count - count - 1);
}

- (NSArray *)prefix:(NSUInteger)count {
    NSAssert(count <= self.count, @"The count %@ is out of %@ count %@.", @(count), self.class, @(self.count));
    return _yj_arrayKeep(self, 0, count - 1);
}

- (NSArray *)suffix:(NSUInteger)count {
    NSAssert(count <= self.count, @"The count %@ is out of %@ count %@.", @(count), self.class, @(self.count));
    return _yj_arrayKeep(self, self.count - count, self.count - 1);
}

- (NSArray *)prefixUpTo:(NSUInteger)upToIndex {
    NSAssert(upToIndex < self.count, @"The index %@ of end prefix is beyond of %@ [0...%@].", @(upToIndex), self.class, @(self.count - 1));
    return _yj_arrayKeep(self, 0, upToIndex);
}

- (NSArray *)suffixFrom:(NSUInteger)fromIndex {
    NSAssert(fromIndex < self.count, @"The index %@ of start suffix is beyond of %@ [0...%@].", @(fromIndex), self.class, @(self.count - 1));
    return _yj_arrayKeep(self, fromIndex, self.count - 1);
}

- (NSArray *)sort:(BOOL(^)(id, id))condition {
    return [self sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        if (condition(obj1, obj2)) return NSOrderedAscending;
        else return NSOrderedDescending;
        return NSOrderedSame;
    }];
}

@end
