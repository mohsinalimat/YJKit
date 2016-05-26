//
//  NSSet+YJCollection.h
//  YJKit
//
//  Created by huang-kun on 16/5/5.
//  Copyright © 2016年 huang-kun. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef id U;

@interface NSSet <T> (YJCollection)

/**
 *  @remark The implementation of -setByMappingEachObject: will prevent crashing from sending message to NSNull object.
 *  @code
 NSSet *a = [NSSet setWithArray:@[@1, @2, @3, @4, @5]];
 NSSet *b = [a setByMappingEachObject:^id(id obj) { return [obj stringValue]; }]; // [ @"1", @"2", @"3", @"4", @"5" ]
 *  @endcode
 */
- (NSSet *)setByMappingEachObject:(U(^)(T obj))mapping;

- (NSSet *)mapped:(U(^)(T obj))mapping OBJC_SWIFT_UNAVAILABLE("use Swift map() instead");


/**
 *  @code
 NSSet *a = [NSSet setWithArray:@[@1, @2, @"hello", @5]];
 NSSet *b = [a setByFilteringWithCondition:^BOOL(id obj) { return [obj isKindOfClass:[NSNumber class]]; }]; // [ @1, @2, @5 ]
 NSSet *c = [b setByFilteringWithCondition:^BOOL(id obj) { return [obj intValue] < 5; }]; // [ @1, @2 ]
 *  @endcode
 */
- (NSSet *)setByFilteringWithCondition:(BOOL(^)(T obj))condition;

- (NSSet *)filtered:(BOOL(^)(T obj))condition OBJC_SWIFT_UNAVAILABLE("use Swift filter() instead");


/**
 *  @code
 NSSet <NSNumber *> *set = [NSSet setWithArray:@[ @1, @2, @3, @4 ]];
 NSNumber *sum = [set objectByReducingSetCombinedWithObject:^U(U result, NSNumber *obj) {
    return @([result intValue] + [obj intValue]);
 }]; // @10
 
 NSSet <NSString *> *set1 = [NSSet setWithArray:@[ @"hello", @"world", @"and", @"you" ]];
 NSString *combined = [set1 objectByReducingSetCombinedWithObject:^U(U result, NSString *obj) {
    return [result stringByAppendingFormat:@" %@", obj];
 }]; // @"hello you and world"
 *  @endcode
 */
- (nullable T)objectByReducingSetCombinedWithObject:(U(^)(U result, T obj))combine;

- (nullable T)reduced:(U(^)(U result, T obj))combine OBJC_SWIFT_UNAVAILABLE("use Swift reduce() instead");


/**
 *  @code
 NSSet *set = [NSSet setWithArray:@[@1, @[ @2 , @3 ], @[ @4, @[ @[ @5, @6 ] ] ] ]];
 NSSet *set1 = [set setByFlatteningRecursively]; // 3, 6, 2, 5, 1, 4
 *  @endcode
 */
- (NSSet *)setByFlatteningRecursively;

- (NSSet *)flattened OBJC_SWIFT_UNAVAILABLE("use Swift flatten() instead");


/**
 * Call [set setByFlatMappingEachObject] is equal to call [[set setByMappingEachObject:...] setByFlatteningRecursively]
 */
- (NSSet *)setByFlatMappingEachObject:(U(^)(T obj))mapping;

- (NSSet *)flatMapped:(U(^)(T obj))mapping OBJC_SWIFT_UNAVAILABLE("use Swift flatMap() instead");

@end

NS_ASSUME_NONNULL_END
