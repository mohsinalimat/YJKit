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
 NSArray *arr = @[@1, @2, @3, @4, @5];
 NSMutableArray *arr1 = [arr dropFirst]; // @[@2, @3, @4, @5]
 
 NSMutableArray *arr2 = arr.mutableCopy;
 [arr2 dropFirst];
 *  @endcode
 */
- (id)dropFirst;


/**
 *  @code
 NSArray *arr = @[@1, @2, @3, @4, @5];
 NSMutableArray *arr1 = [arr dropFirst:2]; // @[@3, @4, @5]
 
 NSMutableArray *arr2 = arr.mutableCopy;
 [arr2 dropFirst:2];
 *  @endcode
 */
- (id)dropFirst:(NSUInteger)count;


/**
 *  @code
 NSArray *arr = @[@1, @2, @3, @4, @5];
 NSMutableArray *arr1 = [arr dropLast]; // @[@1, @2, @3, @4]
 
 NSMutableArray *arr2 = arr.mutableCopy;
 [arr2 dropLast];
 *  @endcode
 */
- (id)dropLast;


/**
 *  @code
 NSArray *arr = @[@1, @2, @3, @4, @5];
 NSMutableArray *arr1 = [arr dropLast:2]; // @[@1, @2, @3]
 
 NSMutableArray *arr2 = arr.mutableCopy;
 [arr2 dropLast:2];
 *  @endcode
 */
- (id)dropLast:(NSUInteger)count;


/**
 *  @code
 NSArray *arr = @[@1, @2, @3, @4, @5];
 NSMutableArray *arr1 = [arr prefix:2]; // @[@1, @2]
 
 NSMutableArray *arr2 = arr.mutableCopy;
 [arr2 prefix:2];
 *  @endcode
 */
- (id)prefix:(NSUInteger)count;


/**
 *  @code
 NSArray *arr = @[@1, @2, @3, @4, @5];
 NSMutableArray *arr1 = [arr suffix:2]; // @[@4, @5]
 
 NSMutableArray *arr2 = arr.mutableCopy;
 [arr2 suffix:2];
 *  @endcode
 */
- (id)suffix:(NSUInteger)count;


/**
 *  @code
 NSArray *arr = @[@1, @2, @3, @4, @5];
 NSMutableArray *arr1 = [arr prefixUpTo:2]; // @[@1, @2, @3]
 
 NSMutableArray *arr2 = arr.mutableCopy;
 [arr2 prefixUpTo:2];
 *  @endcode
 */
- (id)prefixUpTo:(NSUInteger)upToIndex;


/**
 *  @code
 NSArray *arr = @[@1, @2, @3, @4, @5];
 NSMutableArray *arr1 = [arr suffixFrom:2]; // @[@3, @4, @5]
 
 NSMutableArray *arr2 = arr.mutableCopy;
 [arr2 suffixFrom:2];
 *  @endcode
 */
- (id)suffixFrom:(NSUInteger)fromIndex;


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

