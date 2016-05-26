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
 *  @remark The implementation of -arrayByMappingEachObject: will prevent crashing from sending message to NSNull object.
 *  @code
 NSArray *a = @[@"hello", @"world", [NSNull null], @"and", @"you"];
 NSArray *b = [a arrayByMappingEachObject:^id(id obj) { return [obj uppercaseString]; }]; // @[@"HELLO", @"WORLD", [NSNull null], @"AND", @"YOU"]
 *  @endcode
 */
- (NSArray *)arrayByMappingEachObject:(U(^)(T obj))mapping;

- (NSArray *)mapped:(U(^)(T obj))mapping OBJC_SWIFT_UNAVAILABLE("use Swift map() instead");


/**
 *  @code
 NSArray *a = @[@1, @2, [NSNull null], @3, [NSNull null], @"hello"];
 NSArray *b = [a arrayByFilteringWithCondition:^BOOL(id obj) { return [obj isKindOfClass:[NSNumber class]]; }]; // @[@1, @2, @3];
 NSArray *c = [b arrayByFilteringWithCondition:^BOOL(id obj) { return [obj intValue] < 3; }]; // @[@1, @2];
 *  @endcode
 */
- (NSArray *)arrayByFilteringWithCondition:(BOOL(^)(T obj))condition;

- (NSArray *)filtered:(BOOL(^)(T obj))condition OBJC_SWIFT_UNAVAILABLE("use Swift filter() instead");


/**
 *  @code
 NSNumber *a = [@[ @1, @2, @3, @4 ] objectByReducingArrayFromInitialObject:nil combinedWithObject:^U(U result, NSNumber *obj) {
     return @([result intValue] + [obj intValue]);
 }]; // @10
 NSNumber *b = [@[ @1, @2, @3, @4 ] objectByReducingArrayFromInitialObject:@2 combinedWithObject:^U(U result, NSNumber *obj) {
     return @([result intValue] + [obj intValue]);
 }]; // @9
 NSString *c = [@[ @"hello", @"world", @"and", @"you" ] objectByReducingArrayFromInitialObject:@"hello" combinedWithObject:^id(id result, id obj) {
     return [result stringByAppendingFormat:@" %@", obj];
 }]; // @"hello world and you"
 *  @endcode
 */
- (nullable T)objectByReducingArrayFromInitialObject:(nullable U)initial combinedWithObject:(U(^)(U result, T obj))combine;

- (nullable T)reduced:(nullable U)initial combine:(U(^)(U result, T obj))combine OBJC_SWIFT_UNAVAILABLE("use Swift reduce() instead");


/**
 * Same for calling [array objectByReducingArrayFromInitialObject:firstObject combinedWithObject:...] or [array objectByReducingArrayFromInitialObject:nil combinedWithObject:...]
 */
- (nullable T)objectByReducingArrayCombinedWithObject:(U(^)(U result, T obj))combine;

- (nullable T)reduced:(U(^)(U result, T obj))combine OBJC_SWIFT_UNAVAILABLE("use Swift reduce() instead");


/**
 *  @code
 NSArray *a = @[@1, @[ @2, @3, ], @[ @4, @[ @[ @5, @6 ] ] ] ];
 NSArray *b = [a arrayByFlatteningRecursively]; // @[ @1, @2, @3, @4, @5, @6 ]
 *  @endcode
 */
- (NSArray *)arrayByFlatteningRecursively;

- (NSArray *)flattened OBJC_SWIFT_UNAVAILABLE("use Swift flat() instead");


/**
 * Call [array arrayByFlatMappingEachObject:] is equal to call [[array arrayByMappingEachObject:...] arrayByFlatteningRecursively]
 */
- (NSArray *)arrayByFlatMappingEachObject:(U(^)(T obj))mapping;

- (NSArray *)flatMapped:(U(^)(T obj))mapping OBJC_SWIFT_UNAVAILABLE("use Swift flatMap() instead");

@end

NS_ASSUME_NONNULL_END
