//
//  NSMutableArray+YJCollection.h
//  YJKit
//
//  Created by huang-kun on 16/5/12.
//  Copyright © 2016年 huang-kun. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSMutableArray <T> (YJCollection)


/* ----------------------------------  Sequence ----------------------------------*/

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
 
 NSMutableArray <NSNumber *> *a = @[ @3, @1, @2, @5, @4 ].mutableCopy;
 [a sort:^BOOL(NSNumber *obj1, NSNumber *obj2) { return obj1.intValue > obj2.intValue; }]; // 5, 4, 3, 2, 1
 [a sort:^BOOL(NSNumber *obj1, NSNumber *obj2) { return obj1.intValue < obj2.intValue; }]; // 1, 2, 3, 4, 5
 
 NSMutableArray <NSString *> *s = @[ @"hello", @"Jack", @"world", @"Alice", @"Tim" ].mutableCopy;
 [s sort:^BOOL(NSString *obj1, NSString *obj2) { return obj1.hash > obj2.hash; }]; // world, hello, Alice, Jack, Tim
 [s sort:^BOOL(NSString *obj1, NSString *obj2) { return obj1.hash < obj2.hash; }]; // Tim, Jack, Alice, hello, world
 
 *  @endcode
 */
- (void)sort:(BOOL(^)(T obj1, T obj2))condition;


@end

NS_ASSUME_NONNULL_END
