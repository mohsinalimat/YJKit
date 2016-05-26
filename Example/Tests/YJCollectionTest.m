//
//  YJCollectionTest.m
//  YJKit
//
//  Created by huang-kun on 16/5/20.
//  Copyright © 2016年 huang-kun. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "NSArray+YJCollection.h"
#import "NSMutableArray+YJCollection.h"

@interface YJCollectionTest : XCTestCase

@end

@implementation YJCollectionTest

- (void)testYJCollection {
    [self testCollectionMap];
    [self testCollectionFilter];
    [self testCollectionReduce];
    [self testCollectionFlatten];
}

- (void)testCollectionMap {
    // map
    NSArray *a = @[@"hello", @"world", [NSNull null], @"and", @"you"];
    
    NSArray *a1 = [a mapped:^id(id obj) { return [obj uppercaseString]; }];
    BOOL correct1 = [a1 isEqualToArray:@[@"HELLO", @"WORLD", [NSNull null], @"AND", @"YOU"]];
    XCTAssert(correct1);
    
    NSArray *a2 = [a flatMapped:^U _Nonnull(id  _Nonnull obj) { return @[[obj uppercaseString]]; }];
    BOOL correct2 = [a2 isEqualToArray:@[@"HELLO", @"WORLD", [NSNull null], @"AND", @"YOU"]];
    XCTAssert(correct2);
    
//    NSMutableArray *ma1 = a.mutableCopy;
//    NSMutableArray *maa1 = [ma1 mapped:^id(id obj) { return [obj uppercaseString]; }];
//    XCTAssert([ma1 isEqualToArray:maa1]);
    
    NSMutableArray *ma1 = a.mutableCopy;
    [ma1 mapEachObject:^id(id obj) { return [obj uppercaseString]; }];
    XCTAssert([ma1 isEqualToArray:a1]);
}

- (void)testCollectionFilter {
    // filter
    NSArray *a1 = @[@1, @2, [NSNull null], @3, [NSNull null], @"hello"];
    NSArray *a2 = [a1 filtered:^BOOL(id obj) { return [obj isKindOfClass:[NSNumber class]]; }];
    BOOL correct1 = [a2 isEqualToArray:@[@1, @2, @3]];
    XCTAssert(correct1);
    
    NSArray *a3 = [a2 filtered:^BOOL(id obj) { return [obj intValue] < 3; }];
    BOOL correct2 = [a3 isEqualToArray:@[@1, @2]];
    XCTAssert(correct2);
}

- (void)testCollectionReduce {
    // reduce
    NSNumber *n1 = [@[ @1, @2, @3, @4 ] reduced:nil combine:^U(U result, NSNumber *obj) { return @([result intValue] + [obj intValue]); }];
    XCTAssert([n1 isEqual:@10]);
    
    NSNumber *n2 = [@[ @1, @2, @3, @4 ] reduced:@2 combine:^U(U result, NSNumber *obj) { return @([result intValue] + [obj intValue]); }]; // @9
    XCTAssert([n2 isEqual:@9]);
    
    NSString *s1 = [@[ @"hello", @"world", @"and", @"you" ] reduced:@"hello" combine:^id(id result, id obj) {
        return [result stringByAppendingFormat:@" %@", obj];
    }]; // @"hello world and you"
    XCTAssert([s1 isEqualToString:@"hello world and you"]);
    
    NSString *s2 = [@[ @"hello", @"world", @"and", @"you" ] reduced:^id(id result, id obj) {
        return [result stringByAppendingFormat:@" %@", obj];
    }]; // @"hello world and you"
    XCTAssert([s2 isEqualToString:@"hello world and you"]);
}

- (void)testCollectionFlatten {
    NSArray *a = @[@1, @[ @2, @3, ], @[ @4, @[ @[ @5, @6 ] ] ] ];
    NSArray *b = [a flattened]; // @[ @1, @2, @3, @4, @5, @6 ]
    BOOL correct = [b isEqualToArray:@[ @1, @2, @3, @4, @5, @6 ]];
    XCTAssert(correct);
}


@end
