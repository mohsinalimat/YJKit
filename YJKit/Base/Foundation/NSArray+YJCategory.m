//
//  NSArray+YJCategory.m
//  YJKit
//
//  Created by huang-kun on 16/5/4.
//  Copyright © 2016年 huang-kun. All rights reserved.
//

#import "NSArray+YJCategory.h"

@implementation NSArray (YJCategory)

- (NSArray *)map:(id(^)(id obj))messaging {
    if (!messaging) return [self copy];
    NSMutableArray *collector = [NSMutableArray arrayWithCapacity:self.count];
    for (id elem in self) {
        id value = messaging(elem);
        if (value) [collector addObject:value];
    }
    return [collector copy];
}

- (NSArray *)filter:(BOOL(^)(id obj))condition {
    if (!condition) return [self copy];
    NSMutableArray *collector = [NSMutableArray arrayWithCapacity:self.count];
    for (id elem in self) {
        if (condition(elem)) {
            [collector addObject:elem];
        }
    }
    return [collector copy];
}

@end
