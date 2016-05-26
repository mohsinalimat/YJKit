//
//  NSMutableArray+YJCollection.h
//  YJKit
//
//  Created by huang-kun on 16/5/20.
//  Copyright © 2016年 huang-kun. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef id U;

@interface NSMutableArray <T> (YJCollection)

/**
 *  @remark The implementation of -mapEachObject: will prevent crashing from sending message to NSNull object.
 *  @code
 NSMutableArray *marr = @[@"hello", @"world", [NSNull null], @"and", @"you"].mutableCopy;
 [marr arrayByMappingEachObject:^id(id obj) { return [obj uppercaseString]; }]; // [ @"HELLO", @"WORLD", [NSNull null], @"AND", @"YOU" ]
 *  @endcode
 */
- (void)mapEachObject:(U(^)(T obj))mapping;


/**
 *  @code
 NSMutableArray *marr = @[@1, @2, [NSNull null], @3, [NSNull null], @"hello"].mutableCopy;
 [marr filterWithCondition:^BOOL(id obj) { return [obj isKindOfClass:[NSNumber class]]; }]; // [ @1, @2, @3 ];
 *  @endcode
 */
- (void)filterWithCondition:(BOOL(^)(T obj))condition;


/**
 *  @code
 NSMutableArray *marr = @[@1, @[ @2, @3, ], @[ @4, @[ @[ @5, @6 ] ] ] ].mutableCopy;
 [marr flattenRecursively]; // [ @1, @2, @3, @4, @5, @6 ]
 *  @endcode
 */
- (void)flattenRecursively;


/**
 * Call [mutableArray flatMapEachObject:] is equal to call [[mutableArray mapEachObject:...] flattenRecursively]
 */
- (void)flatMapEachObject:(U(^)(T obj))mapping;

@end

NS_ASSUME_NONNULL_END
