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

@end
