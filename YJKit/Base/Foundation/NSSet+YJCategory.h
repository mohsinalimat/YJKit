//
//  NSSet+YJCategory.h
//  YJKit
//
//  Created by huang-kun on 16/5/5.
//  Copyright © 2016年 huang-kun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSSet (YJCategory)

/**
 *  @code
 
 NSSet *a = [NSSet setWithArray:@[@1, @2, @3, @4, @5]];
 
 NSSet *b = [a map:^id(id obj) {
     return [obj stringValue];
 }];
 
 // b = [ @"1", @"2", @"3", @"4", @"5" ]
 
 *  @endcode
 */
- (NSSet *)map:(id(^)(id obj))mapping;


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
- (NSSet *)filter:(BOOL(^)(id obj))condition;

@end
