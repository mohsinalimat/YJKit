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
 NSArray *arr1 = [arr arrayByDroppingFirstObject]; // @[@2, @3, @4, @5]
 *  @endcode
 */
- (NSArray *)arrayByDroppingFirstObject;

- (NSArray *)droppingFirst OBJC_SWIFT_UNAVAILABLE("use Swift dropFirst() instead");


/**
 *  @code
 NSArray *arr = @[@1, @2, @3, @4, @5];
 NSArray *arr1 = [arr arrayByDroppingFirstObjectsWithCount:2]; // @[@3, @4, @5]
 *  @endcode
 */
- (NSArray *)arrayByDroppingFirstObjectsWithCount:(NSUInteger)count;

- (NSArray *)droppingFirst:(NSUInteger)count OBJC_SWIFT_UNAVAILABLE("use Swift dropFirst() instead");


/**
 *  @code
 NSArray *arr = @[@1, @2, @3, @4, @5];
 NSArray *arr1 = [arr arrayByDroppingLastObject]; // @[@1, @2, @3, @4]
 *  @endcode
 */
- (NSArray *)arrayByDroppingLastObject;

- (NSArray *)droppingLast OBJC_SWIFT_UNAVAILABLE("use Swift dropLast() instead");


/**
 *  @code
 NSArray *arr = @[@1, @2, @3, @4, @5];
 NSArray *arr1 = [arr arrayByDroppingLastObjectsWithCount:2]; // @[@1, @2, @3]
 *  @endcode
 */
- (NSArray *)arrayByDroppingLastObjectsWithCount:(NSUInteger)count;

- (NSArray *)droppingLast:(NSUInteger)count OBJC_SWIFT_UNAVAILABLE("use Swift dropLast() instead");


/**
 *  @code
 NSArray *arr = @[@1, @2, @3, @4, @5];
 NSArray *arr1 = [arr arrayByPrefixingObjectsWithCount:2]; // @[@1, @2]
 *  @endcode
 */
- (NSArray *)arrayByPrefixingObjectsWithCount:(NSUInteger)count;

- (NSArray *)prefixed:(NSUInteger)count OBJC_SWIFT_UNAVAILABLE("use Swift prefix() instead");


/**
 *  @code
 NSArray *arr = @[@1, @2, @3, @4, @5];
 NSArray *arr1 = [arr arrayBySuffixingObjectsWithCount:2]; // @[@4, @5]
 *  @endcode
 */
- (NSArray *)arrayBySuffixingObjectsWithCount:(NSUInteger)count;

- (NSArray *)suffixed:(NSUInteger)count OBJC_SWIFT_UNAVAILABLE("use Swift suffix() instead");


/**
 *  @code
 NSArray *arr = @[@1, @2, @3, @4, @5];
 NSArray *arr1 = [arr arrayByPrefixingObjectsUpToIndex:2]; // @[@1, @2, @3]
 *  @endcode
 */
- (NSArray *)arrayByPrefixingObjectsUpToIndex:(NSUInteger)upToIndex;

- (NSArray *)prefixingUpToIndex:(NSUInteger)upToIndex OBJC_SWIFT_UNAVAILABLE("use Swift prefix(upTo:) instead");

/**
 *  @code
 NSArray *arr = @[@1, @2, @3, @4, @5];
 NSArray *arr1 = [arr arrayBySuffixingObjectsFromIndex:2]; // @[@3, @4, @5]
 *  @endcode
 */
- (NSArray *)arrayBySuffixingObjectsFromIndex:(NSUInteger)fromIndex;

- (NSArray *)suffixingFromIndex:(NSUInteger)fromIndex OBJC_SWIFT_UNAVAILABLE("use Swift suffix(from:) instead");


/**
 *  @code
 NSArray <NSNumber *> *a = @[ @3, @1, @2, @5, @4 ];
 NSArray *a1 = [a arrayBySortingWithCondition:^BOOL(NSNumber *obj1, NSNumber *obj2) { return obj1.intValue > obj2.intValue; }]; // 5, 4, 3, 2, 1
 NSArray *a2 = [a arrayBySortingWithCondition:^BOOL(NSNumber *obj1, NSNumber *obj2) { return obj1.intValue < obj2.intValue; }]; // 1, 2, 3, 4, 5
 
 NSArray <NSString *> *s = @[ @"hello", @"Jack", @"world", @"Alice", @"Tim" ];
 NSArray *s1 = [s arrayBySortingWithCondition:^BOOL(NSString *obj1, NSString *obj2) { return obj1.hash > obj2.hash; }]; // world, hello, Alice, Jack, Tim
 NSArray *s2 = [s arrayBySortingWithCondition:^BOOL(NSString *obj1, NSString *obj2) { return obj1.hash < obj2.hash; }]; // Tim, Jack, Alice, hello, world
 *  @endcode
 */
- (NSArray <T> *)arrayBySortingWithCondition:(BOOL(^)(T obj1, T obj2))condition;

- (NSArray <T> *)sorted:(BOOL(^)(T obj1, T obj2))condition OBJC_SWIFT_UNAVAILABLE("use Swift sort() instead");

@end

NS_ASSUME_NONNULL_END

