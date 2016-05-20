//
//  NSMutableArray+YJSequence.h
//  YJKit
//
//  Created by huang-kun on 16/5/12.
//  Copyright © 2016年 huang-kun. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSMutableArray <T> (YJSequence)

/**
 * Removes and returns the first object of collection.
 */
- (nullable T)removeFirst;

/**
 * Removes and returns the last object of collection.
 */
- (nullable T)removeLast;


/**
 *  @code
 NSArray *arr = @[@1, @2, @3, @4, @5];
 NSMutableArray *arr1 = arr.mutableCopy;
 [arr1 droppingFirst]; // [ @2, @3, @4, @5 ]
 *  @endcode
 */
- (void)droppingFirst;


/**
 *  @code
 NSArray *arr = @[@1, @2, @3, @4, @5];
 NSMutableArray *arr1 = arr.mutableCopy;
 [arr1 droppingFirst:2]; // [ @3, @4, @5 ]
 *  @endcode
 */
- (void)droppingFirst:(NSUInteger)count;


/**
 *  @code
 NSArray *arr = @[@1, @2, @3, @4, @5];
 NSMutableArray *arr1 = arr.mutableCopy;
 [arr1 droppingLast]; // [ @1, @2, @3, @4 ]
 *  @endcode
 */
- (void)droppingLast;


/**
 *  @code
 NSArray *arr = @[@1, @2, @3, @4, @5];
 NSMutableArray *arr1 = arr.mutableCopy;
 [arr1 droppingLast:2]; // [ @1, @2, @3 ]
 *  @endcode
 */
- (void)droppingLast:(NSUInteger)count;


/**
 *  @code
 NSArray *arr = @[@1, @2, @3, @4, @5];
 NSMutableArray *arr1 = arr.mutableCopy;
 [arr1 prefixing:2]; // [ @1, @2 ]
 *  @endcode
 */
- (void)prefixing:(NSUInteger)count;


/**
 *  @code
 NSArray *arr = @[@1, @2, @3, @4, @5];
 NSMutableArray *arr1 = arr.mutableCopy;
 [arr1 suffixing:2]; // [ @4, @5 ]
 *  @endcode
 */
- (void)suffixing:(NSUInteger)count;


/**
 *  @code
 NSArray *arr = @[@1, @2, @3, @4, @5];
 NSMutableArray *arr1 = arr.mutableCopy;
 [arr1 prefixingUpTo:2]; // [ @1, @2, @3 ]
 *  @endcode
 */
- (void)prefixingUpTo:(NSUInteger)upToIndex;


/**
 *  @code
 NSArray *arr = @[@1, @2, @3, @4, @5];
 NSMutableArray *arr1 = arr.mutableCopy;
 [arr1 suffixingFrom:2]; // [ @3, @4, @5 ]
 *  @endcode
 */
- (void)suffixingFrom:(NSUInteger)fromIndex;


/**
 *  @code
 
 NSMutableArray <NSNumber *> *a = @[ @3, @1, @2, @5, @4 ].mutableCopy;
 [a sorting:^BOOL(NSNumber *obj1, NSNumber *obj2) { return obj1.intValue > obj2.intValue; }]; // 5, 4, 3, 2, 1
 [a sorting:^BOOL(NSNumber *obj1, NSNumber *obj2) { return obj1.intValue < obj2.intValue; }]; // 1, 2, 3, 4, 5
 
 NSMutableArray <NSString *> *s = @[ @"hello", @"Jack", @"world", @"Alice", @"Tim" ].mutableCopy;
 [s sorting:^BOOL(NSString *obj1, NSString *obj2) { return obj1.hash > obj2.hash; }]; // world, hello, Alice, Jack, Tim
 [s sorting:^BOOL(NSString *obj1, NSString *obj2) { return obj1.hash < obj2.hash; }]; // Tim, Jack, Alice, hello, world
 
 *  @endcode
 */
- (void)sorting:(BOOL(^)(T obj1, T obj2))condition;


@end

NS_ASSUME_NONNULL_END
