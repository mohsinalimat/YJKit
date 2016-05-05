//
//  NSSet+YJCategory.m
//  YJKit
//
//  Created by huang-kun on 16/5/5.
//  Copyright © 2016年 huang-kun. All rights reserved.
//

#import "NSSet+YJCategory.h"

@implementation NSSet (YJCategory)

- (NSSet *)map:(id (^)(id))mapping {
    if (!mapping) return [self copy];
    NSMutableSet *collector = [NSMutableSet setWithCapacity:self.count];
    for (id elem in self) {
        id value = mapping(elem);
        if (value) [collector addObject:value];
    }
    return [collector copy];
}

- (NSSet *)filter:(BOOL (^)(id))condition {
    if (!condition) return [self copy];
    NSMutableSet *collector = [NSMutableSet setWithCapacity:self.count];
    for (id elem in self) {
        if (condition(elem)) {
            [collector addObject:elem];
        }
    }
    return [collector copy];
}

@end
