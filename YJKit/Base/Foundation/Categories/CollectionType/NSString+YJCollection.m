//
//  NSString+YJCollection.m
//  YJKit
//
//  Created by huang-kun on 16/5/21.
//  Copyright © 2016年 huang-kun. All rights reserved.
//

#import "NSString+YJCollection.h"

@implementation NSString (YJCollection)

- (NSArray <NSString *> *)characters {
    NSMutableArray *collector = [NSMutableArray arrayWithCapacity:self.length];
    for (NSUInteger i = 0; i < self.length; ++i) {
        unichar character = [self characterAtIndex:i];
        NSString *charString = [NSString stringWithCharacters:&character length:1];
        [collector addObject:charString];
    }
    return [collector copy];
}

- (nullable NSString *)firstCharacter {
    return self.characters.firstObject;
}

- (nullable NSString *)lastCharacter {
    return self.characters.lastObject;
}

- (NSString *)objectAtIndexedSubscript:(NSUInteger)idx {
    unichar character = [self characterAtIndex:idx];
    return [NSString stringWithCharacters:&character length:1];
}

@end
