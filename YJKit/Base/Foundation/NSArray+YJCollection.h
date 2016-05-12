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
 *  @code
 
 NSArray *a = @[@"hello", @"world", @"and", @"you"];
 
 NSArray *b = [a map:^id(id obj) {
     return [obj uppercaseString];
 }];
 
 // b = @[@"HELLO", @"WORLD", @"AND", @"YOU"]
 
 *  @endcode
 */
- (instancetype)map:(U(^)(T obj))mapping;


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
- (instancetype)filter:(BOOL(^)(T obj))condition;


/**
 *  @code
 
 NSArray <NSNumber *> *a = @[@1, @2, @3, @4 ];
 
 NSNumber *b = [a reduce:nil combine:^U(U result, NSNumber *obj) {
    return @([result intValue] + [obj intValue]);
 }];
 
 // b = @10
 
 NSNumber *c = [a reduce:@2 combine:^U(U result, NSNumber *obj) {
    return @([result intValue] + [obj intValue]);
 }];
 
 // c = @9
 
 *  @endcode
 */
- (T)reduce:(U)initial combine:(U(^)(U result, T obj))combine;


/**
 *  @code
 
 NSArray *a = @[@1, @[ @2, @3, ], @[ @4, @[ @[ @5, @6 ] ] ] ];

 NSArray *b = [a flatten]; // @[ @1, @2, @3, @4, @5, @6 ]
 
 *  @endcode
 */
- (instancetype)flatten;


/**
 * Call [array flatMap] is equal to call [[array map:...] flatten]
 */
- (instancetype)flatMap:(U(^)(T obj))mapping;


/* ----------------------------------  Sequence ----------------------------------*/

/**
 *  @code
 
 NSArray *a = [@[ @1, @2, @3, @4, @5 ] dropFirst:2]; // @[ @3, @4, @5 ];
 
 *  @endcode
 */
- (instancetype)dropFirst:(NSUInteger)count;


/**
 *  @code
 
 NSArray *a = [@[ @1, @2, @3, @4, @5 ] dropLast:2]; // @[ @1, @2, @3 ];
 
 *  @endcode
 */
- (instancetype)dropLast:(NSUInteger)count;


/**
 *  @code
 
 NSArray *a = [@[ @1, @2, @3, @4, @5 ] prefix:2]; // @[ @1, @2 ];
 
 *  @endcode
 */
- (instancetype)prefix:(NSUInteger)count;


/**
 *  @code
 
 NSArray *a = [@[ @1, @2, @3, @4, @5 ] suffix:2]; // @[ @4, @5 ];
 
 *  @endcode
 */
- (instancetype)suffix:(NSUInteger)count;


/**
 *  @code
 
 NSArray *a = [@[ @1, @2, @3, @4, @5 ] prefixUpTo:2]; // @[ @1, @2, @3 ];
 
 *  @endcode
 */
- (instancetype)prefixUpTo:(NSUInteger)upToIndex;


/**
 *  @code
 
 NSArray *a = [@[ @1, @2, @3, @4, @5 ] suffixFrom:2]; // @[ @3, @4, @5 ];
 
 *  @endcode
 */
- (instancetype)suffixFrom:(NSUInteger)fromIndex;

@end

NS_ASSUME_NONNULL_END
