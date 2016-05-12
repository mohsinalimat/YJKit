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
 
 NSSet *b = [a map:^id(id obj) {
     return [obj stringValue];
 }];
 
 // b = [ @"1", @"2", @"3", @"4", @"5" ]
 
 *  @endcode
 */
- (instancetype)map:(U(^)(T obj))mapping;

/**
 *  @code
 
 NSSet *a = [NSSet setWithArray:@[@1, @2, @"hello", @5]];
 
 NSSet *b = [a filter:^BOOL(id obj) {
     return [obj isKindOfClass:[NSNumber class]];
 }];
 
 // b = [ @1, @2, @5 ]
 
 NSSet *c = [b filter:^BOOL(id obj) {
     return [obj intValue] < 5;
 }];
 
 // c = [ @1, @2 ]
 
 *  @endcode
 */
- (instancetype)filter:(BOOL(^)(T obj))condition;

- (T)reduce:(U(^)(U result, T obj))combine;

- (instancetype)flatten;

- (instancetype)flatMap:(U(^)(T obj))mapping;

@end

NS_ASSUME_NONNULL_END
