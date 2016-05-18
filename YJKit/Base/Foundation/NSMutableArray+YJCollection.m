//
//  NSMutableArray+YJCollection.m
//  YJKit
//
//  Created by huang-kun on 16/5/12.
//  Copyright © 2016年 huang-kun. All rights reserved.
//

#import "NSMutableArray+YJCollection.h"

@implementation NSMutableArray (YJCollection)

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

- (void)sort:(BOOL(^)(id, id))condition {
    [self sortUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        if (condition(obj1, obj2)) return NSOrderedAscending;
        else return NSOrderedDescending;
        return NSOrderedSame;
    }];
}

@end
