//
//  NSArray+YJSequence.h
//  YJKit
//
//  Created by huang-kun on 16/5/16.
//  Copyright © 2016年 huang-kun. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSArray <T> (YJSequence)

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


/**
 *  @code
 
 NSArray <NSNumber *> *a = @[ @3, @1, @2, @5, @4 ];
 NSArray *a1 = [a sorted:^BOOL(NSNumber *obj1, NSNumber *obj2) { return obj1.intValue > obj2.intValue; }]; // 5, 4, 3, 2, 1
 NSArray *a2 = [a sorted:^BOOL(NSNumber *obj1, NSNumber *obj2) { return obj1.intValue < obj2.intValue; }]; // 1, 2, 3, 4, 5
 
 NSArray <NSString *> *s = @[ @"hello", @"Jack", @"world", @"Alice", @"Tim" ];
 NSArray *s1 = [s sorted:^BOOL(NSString *obj1, NSString *obj2) { return obj1.hash > obj2.hash; }]; // world, hello, Alice, Jack, Tim
 NSArray *s2 = [s sorted:^BOOL(NSString *obj1, NSString *obj2) { return obj1.hash < obj2.hash; }]; // Tim, Jack, Alice, hello, world
 
 *  @endcode
 */
- (NSArray <T> *)sorted:(BOOL(^)(T obj1, T obj2))condition;

@end

NS_ASSUME_NONNULL_END

