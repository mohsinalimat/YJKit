//
//  YJArraySequence.m
//  YJKit
//
//  Created by huang-kun on 16/5/20.
//  Copyright © 2016年 huang-kun. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "NSArray+YJSequence.h"
#import "NSMutableArray+YJSequence.h"

@interface YJArraySequence : XCTestCase

@end

@implementation YJArraySequence

- (void)testArraySequence {
    [self testArraydroppingFirst];
    [self testArraydroppingLast];
    [self testArrayPrefix];
    [self testArraySuffix];
}

- (void)testArraydroppingFirst {
    NSArray *a = @[@1, @2, @3, @4, @5];
    
    NSArray *a1 = [a dropFirst];
    NSArray *aa1 = @[@2, @3, @4, @5];
    XCTAssert([a1 isEqualToArray:aa1]);
    
    NSArray *a2 = [a dropFirst:3];
    NSArray *aa2 = @[@4, @5];
    XCTAssert([a2 isEqualToArray:aa2]);
    
    NSArray *a3 = [a dropFirst:a.count];
    XCTAssert(a3.count == 0);
    
    NSMutableArray *ma = a.mutableCopy;
    [ma droppingFirst];
    XCTAssert([ma isEqualToArray:aa1]);
    
    [ma droppingFirst:2];
    XCTAssert([ma isEqualToArray:aa2]);
    
    [ma droppingFirst:2];
    XCTAssert(ma.count == 0);
}

- (void)testArraydroppingLast {
    NSArray *a = @[@1, @2, @3, @4, @5];
    
    NSArray *a1 = [a dropLast];
    NSArray *aa1 = @[@1, @2, @3, @4];
    XCTAssert([a1 isEqualToArray:aa1]);
    
    NSArray *a2 = [a dropLast:3];
    NSArray *aa2 = @[@1, @2];
    XCTAssert([a2 isEqualToArray:aa2]);
    
    NSArray *a3 = [a dropLast:a.count];
    XCTAssert(a3.count == 0);
    
    NSMutableArray *ma = a.mutableCopy;
    [ma droppingLast];
    XCTAssert([ma isEqualToArray:aa1]);
    
    [ma droppingLast:2];
    XCTAssert([ma isEqualToArray:aa2]);
    
    [ma droppingLast:2];
    XCTAssert(ma.count == 0);
}

- (void)testArrayPrefix {
    NSArray *a = @[@1, @2, @3, @4, @5];
    
    NSArray *a1 = [a prefix:1];
    NSArray *aa1 = @[@1];
    XCTAssert([a1 isEqualToArray:aa1]);
    
    NSArray *a2 = [a prefix:3];
    NSArray *aa2 = @[@1, @2, @3];
    XCTAssert([a2 isEqualToArray:aa2]);
    
    NSArray *a3 = [a prefix:a.count];
    XCTAssert([a3 isEqualToArray:a]);
    
    NSArray *a4 = [a prefix:0];
    XCTAssert(a4.count == 0);
    
    NSMutableArray *ma = a.mutableCopy;
    [ma prefixing:1];
    XCTAssert([ma isEqualToArray:aa1]);
    
    ma = a.mutableCopy;
    [ma prefixing:3];
    XCTAssert([ma isEqualToArray:aa2]);
    
    ma = a.mutableCopy;
    [ma prefixing:0];
    XCTAssert(ma.count == 0);
    
    ma = a.mutableCopy;
    [ma prefixing:a.count];
    XCTAssert([ma isEqualToArray:a]);
}

- (void)testArraySuffix {
    NSArray *a = @[@1, @2, @3, @4, @5];
    
    NSArray *a1 = [a suffix:1];
    NSArray *aa1 = @[@5];
    XCTAssert([a1 isEqualToArray:aa1]);
    
    NSArray *a2 = [a suffix:3];
    NSArray *aa2 = @[@3, @4, @5];
    XCTAssert([a2 isEqualToArray:aa2]);
    
    NSArray *a3 = [a suffix:a.count];
    XCTAssert([a3 isEqualToArray:a]);
    
    NSArray *a4 = [a suffix:0];
    XCTAssert(a4.count == 0);
    
    NSMutableArray *ma = a.mutableCopy;
    [ma suffixing:1];
    XCTAssert([ma isEqualToArray:aa1]);
    
    ma = a.mutableCopy;
    [ma suffixing:3];
    XCTAssert([ma isEqualToArray:aa2]);
    
    ma = a.mutableCopy;
    [ma suffixing:0];
    XCTAssert(ma.count == 0);
    
    ma = a.mutableCopy;
    [ma suffixing:a.count];
    XCTAssert([ma isEqualToArray:a]);
}

@end
