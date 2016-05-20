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
 *  @code
 
 NSSet *a = [NSSet setWithArray:@[@1, @2, @3, @4, @5]];
 
 NSSet *b = [a map:^id(id obj) { return [obj stringValue]; }]; // [ @"1", @"2", @"3", @"4", @"5" ]
 
 *  @endcode
 */
- (id)map:(U(^)(T obj))mapping;


/**
 *  @code
 
 NSSet *a = [NSSet setWithArray:@[@1, @2, @"hello", @5]];
 
 NSSet *b = [a filter:^BOOL(id obj) { return [obj isKindOfClass:[NSNumber class]]; }]; // [ @1, @2, @5 ]
 
 NSSet *c = [b filter:^BOOL(id obj) { return [obj intValue] < 5; }]; // [ @1, @2 ]
 
 *  @endcode
 */
- (instancetype)filter:(BOOL(^)(T obj))condition;


/**
 *  @code
 
 NSSet <NSNumber *> *set = [NSSet setWithArray:@[ @1, @2, @3, @4 ]];
 
 NSNumber *sum = [set reduce:^U(U result, NSNumber *obj) {
    return @([result intValue] + [obj intValue]);
 }]; // @10
 
 NSSet <NSString *> *set1 = [NSSet setWithArray:@[ @"hello", @"world", @"and", @"you" ]];
 
 NSString *combined = [set1 reduce:^U(U result, NSString *obj) {
    return [result stringByAppendingFormat:@" %@", obj];
 }]; // @"hello you and world"
 
 *  @endcode
 */
- (nullable T)reduce:(U(^)(U result, T obj))combine;


/**
 *  @code
 
 NSSet *set = [NSSet setWithArray:@[@1, @[ @2 , @3 ], @[ @4, @[ @[ @5, @6 ] ] ] ]];
 
 NSSet *set1 = [set flatten]; // 3, 6, 2, 5, 1, 4
 
 *  @endcode
 */
- (id)flatten;


/**
 * Call [set flatMap] is equal to call [[set map:...] flatten]
 */
- (id)flatMap:(U(^)(T obj))mapping;

@end

NS_ASSUME_NONNULL_END
