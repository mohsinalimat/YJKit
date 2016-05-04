//
//  NSArray+YJCategory.h
//  YJKit
//
//  Created by huang-kun on 16/5/4.
//  Copyright © 2016年 huang-kun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (YJCategory)

/**
 *  @code
 
 NSArray *a = @[@"hello", @"world", @"and", @"you"];
 
 NSArray *b = [a map:^id(id obj) {
     return [obj uppercaseString];
 }];
 
 // b = @[@"HELLO", @"WORLD", @"AND", @"YOU"]
 
 *  @endcode
 */
- (NSArray *)map:(id(^)(id obj))messaging;


/**
 *  @code
 
 NSArray *a = @[@1, @2, [NSNull null], @3, [NSNull null], @"hello"];
 
 NSArray *b = [a filter:^BOOL(id obj) {
     return [obj isKindOfClass:[NSNumber class]];
 }];
 
 // b = @[@1, @2, @3];
 
 NSArray *c = [b filter:^BOOL(id obj) {
     return [obj intValue] < 3;
 }];
 
 // c = @[@1, @2];
 
 *  @endcode
 */
- (NSArray *)filter:(BOOL(^)(id obj))condition;

@end
