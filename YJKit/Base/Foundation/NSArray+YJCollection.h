//
//  NSArray+YJCollection.h
//  YJKit
//
//  Created by huang-kun on 16/5/4.
//  Copyright © 2016年 huang-kun. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef id U;

@interface NSArray <T> (YJCollection)

/**
 *  @remark The implementation of -map will prevent crashing from sending message to NSNull object.
 *  @code
 
 NSArray *a = @[@"hello", @"world", [NSNull null], @"and", @"you"];
 
 NSArray *b = [a map:^id(id obj) { return [obj uppercaseString]; }]; // @[@"HELLO", @"WORLD", [NSNull null], @"AND", @"YOU"]
 
 *  @endcode
 */
- (id)map:(U(^)(T obj))mapping;


/**
 *  @code
 
 NSArray *a = @[@1, @2, [NSNull null], @3, [NSNull null], @"hello"];
 
 NSArray *b = [a filter:^BOOL(id obj) { return [obj isKindOfClass:[NSNumber class]]; }]; // @[@1, @2, @3];
 
 NSArray *c = [b filter:^BOOL(id obj) { return [obj intValue] < 3; }]; // @[@1, @2];
 
 *  @endcode
 */
- (instancetype)filter:(BOOL(^)(T obj))condition;


/**
 *  @code
 
 NSNumber *a = [@[ @1, @2, @3, @4 ] reduce:nil combine:^U(U result, NSNumber *obj) {
     return @([result intValue] + [obj intValue]);
 }]; // @10
 
 NSNumber *b = [@[ @1, @2, @3, @4 ] reduce:@2 combine:^U(U result, NSNumber *obj) {
     return @([result intValue] + [obj intValue]);
 }]; // @9
 
 NSString *c = [@[ @"hello", @"world", @"and", @"you" ] reduce:@"hello" combine:^id(id result, id obj) {
     return [result stringByAppendingFormat:@" %@", obj];
 }]; // @"hello world and you"
 
 *  @endcode
 */
- (nullable T)reduce:(nullable U)initial combine:(U(^)(U result, T obj))combine;


/**
 * Same for calling [array reduce:firstObject combine:...] or [array reduce:nil combine:...]
 */
- (nullable T)reduce:(U(^)(U result, T obj))combine;

/**
 *  @code
 
 NSArray *a = @[@1, @[ @2, @3, ], @[ @4, @[ @[ @5, @6 ] ] ] ];

 NSArray *b = [a flatten]; // @[ @1, @2, @3, @4, @5, @6 ]
 
 *  @endcode
 */
- (id)flatten;


/**
 * Call [array flatMap] is equal to call [[array map:...] flatten]
 */
- (id)flatMap:(U(^)(T obj))mapping;

@end

NS_ASSUME_NONNULL_END
