//
//  NSMutableSet+YJCollection.h
//  YJKit
//
//  Created by huang-kun on 16/5/20.
//  Copyright © 2016年 huang-kun. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef id U;

@interface NSMutableSet <T> (YJCollection)

/**
 *  @remark The implementation of -mapEachObject: will prevent crashing from sending message to NSNull object.
 *  @code
 NSMutableSet *mset = [NSSet setWithArray:@[@"hello", @"world", [NSNull null], @"and", @"you"]].mutableCopy;
 [mset mapEachObject:^id(id obj) { return [obj uppercaseString]; }]; // [ @"HELLO", @"WORLD", [NSNull null], @"AND", @"YOU" ]
 *  @endcode
 */
- (void)mapEachObject:(U(^)(T obj))mapping;


/**
 *  @code
 NSMutableSet *mset = [NSSet setWithArray:@[@1, @2, [NSNull null], @3, [NSNull null], @"hello"]].mutableCopy;
 [mset filterWithCondition:^BOOL(id obj) { return [obj isKindOfClass:[NSNumber class]]; }]; // [ @3, @2, @1 ]; (no order)
 *  @endcode
 */
- (void)filterWithCondition:(BOOL(^)(T obj))condition;


/**
 *  @code
 NSMutableSet *mset = [NSSet setWithArray:@[@1, @[ @2, @3, ], @[ @4, @[ @[ @5, @6 ] ] ] ]].mutableCopy;
 [mset flattenRecursively]; // [ @3, @6, @2, @5, @1, @4 ] (no order)
 *  @endcode
 */
- (void)flattenRecursively;


/**
 * Call [mset flatMapEachObject:] is equal to call [[mset mapEachObject:...] flattenRecursively]
 */
- (void)flatMapEachObject:(U(^)(T obj))mapping;

@end

NS_ASSUME_NONNULL_END
