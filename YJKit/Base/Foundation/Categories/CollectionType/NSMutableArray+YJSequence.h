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
- (nullable T)poppedFirstObject;


/**
 * Removes and returns the last object of collection.
 */
- (nullable T)poppedLastObject;


/**
 *  @code
 NSMutableArray *marr = @[@1, @2, @3, @4, @5].mutableCopy;
 [marr dropFirstObject]; // [ @2, @3, @4, @5 ]
 *  @endcode
 */
- (void)dropFirstObject OBJC_SWIFT_UNAVAILABLE("use Swift dropFirst() instead");


/**
 *  @code
 NSMutableArray *marr = @[@1, @2, @3, @4, @5].mutableCopy;
 [marr dropFirstObjectsWithCount:2]; // [ @3, @4, @5 ]
 *  @endcode
 */
- (void)dropFirstObjectsWithCount:(NSUInteger)count OBJC_SWIFT_UNAVAILABLE("use Swift dropFirst() instead");


/**
 *  @code
 NSMutableArray *marr = @[@1, @2, @3, @4, @5].mutableCopy;
 [marr dropLastObject]; // [ @1, @2, @3, @4 ]
 *  @endcode
 */
- (void)dropLastObject OBJC_SWIFT_UNAVAILABLE("use Swift dropLast() instead");


/**
 *  @code
 NSMutableArray *marr = @[@1, @2, @3, @4, @5].mutableCopy;
 [marr dropLastObjectsWithCount:2]; // [ @1, @2, @3 ]
 *  @endcode
 */
- (void)dropLastObjectsWithCount:(NSUInteger)count OBJC_SWIFT_UNAVAILABLE("use Swift dropLast() instead");


/**
 *  @code
 NSMutableArray *marr = @[@1, @2, @3, @4, @5].mutableCopy;
 [marr prefixObjectsWithCount:2]; // [ @1, @2 ]
 *  @endcode
 */
- (void)prefixObjectsWithCount:(NSUInteger)count OBJC_SWIFT_UNAVAILABLE("use Swift prefix() instead");


/**
 *  @code
 NSMutableArray *marr = @[@1, @2, @3, @4, @5].mutableCopy;
 [marr suffixObjectsWithCount:2]; // [ @4, @5 ]
 *  @endcode
 */
- (void)suffixObjectsWithCount:(NSUInteger)count OBJC_SWIFT_UNAVAILABLE("use Swift suffix() instead");


/**
 *  @code
 NSMutableArray *marr = @[@1, @2, @3, @4, @5].mutableCopy;
 [marr prefixObjectsUpToIndex:2]; // [ @1, @2, @3 ]
 *  @endcode
 */
- (void)prefixObjectsUpToIndex:(NSUInteger)upToIndex OBJC_SWIFT_UNAVAILABLE("use Swift prefix(upTo:) instead");

/**
 *  @code
 NSMutableArray *marr = @[@1, @2, @3, @4, @5].mutableCopy;
 [marr suffixObjectsFromIndex:2]; // [ @3, @4, @5 ]
 *  @endcode
 */
- (void)suffixObjectsFromIndex:(NSUInteger)upToIndex OBJC_SWIFT_UNAVAILABLE("use Swift suffix(from:) instead");


/**
 *  @code
 NSMutableArray <NSNumber *> *ma = @[ @3, @1, @2, @5, @4 ].mutableCopy;
 [ma sortWithCondition:^BOOL(NSNumber *obj1, NSNumber *obj2) { return obj1.intValue > obj2.intValue; }]; // 5, 4, 3, 2, 1
 [ma sortWithCondition:^BOOL(NSNumber *obj1, NSNumber *obj2) { return obj1.intValue < obj2.intValue; }]; // 1, 2, 3, 4, 5
 
 NSMutableArray <NSString *> *ma1 = @[ @"hello", @"Jack", @"world", @"Alice", @"Tim" ].mutableCopy;
 [ma1 sortWithCondition:^BOOL(NSString *obj1, NSString *obj2) { return obj1.hash > obj2.hash; }]; // world, hello, Alice, Jack, Tim
 [ma1 sortWithCondition:^BOOL(NSString *obj1, NSString *obj2) { return obj1.hash < obj2.hash; }]; // Tim, Jack, Alice, hello, world
 *  @endcode
 */
- (void)sortWithCondition:(BOOL(^)(T obj1, T obj2))condition OBJC_SWIFT_UNAVAILABLE("use Swift sort() instead");

@end

NS_ASSUME_NONNULL_END
