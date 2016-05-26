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
#import "NSMutableSet+YJCollection.h"

@interface YJArraySequence : XCTestCase

@end

@implementation YJArraySequence

- (void)testArraySequence {
    [self testArraydropFirst];
    [self testArraydropLast];
    [self testArrayPrefix];
    [self testArraySuffix];
}

- (void)testArraydropFirst {
    NSArray *a = @[@1, @2, @3, @4, @5];
    
    NSArray *a1 = [a droppingFirst];
    NSArray *aa1 = @[@2, @3, @4, @5];
    XCTAssert([a1 isEqualToArray:aa1]);
    
    NSArray *a2 = [a droppingFirst:3];
    NSArray *aa2 = @[@4, @5];
    XCTAssert([a2 isEqualToArray:aa2]);
    
    NSArray *a3 = [a droppingFirst:a.count];
    XCTAssert(a3.count == 0);
    
    NSMutableArray *ma = a.mutableCopy;
    [ma dropFirstObject];

    XCTAssert([ma isEqualToArray:aa1]);
    
    [ma dropFirstObjectsWithCount:2];
    XCTAssert([ma isEqualToArray:aa2]);
    
    [ma dropFirstObjectsWithCount:2];
    XCTAssert(ma.count == 0);
}

- (void)testArraydropLast {
    NSArray *a = @[@1, @2, @3, @4, @5];
    
    NSArray *a1 = [a droppingLast];
    NSArray *aa1 = @[@1, @2, @3, @4];
    XCTAssert([a1 isEqualToArray:aa1]);
    
    NSArray *a2 = [a droppingLast:3];
    NSArray *aa2 = @[@1, @2];
    XCTAssert([a2 isEqualToArray:aa2]);
    
    NSArray *a3 = [a droppingLast:a.count];
    XCTAssert(a3.count == 0);
    
    NSMutableArray *ma = a.mutableCopy;
    [ma dropLastObject];
    XCTAssert([ma isEqualToArray:aa1]);
    
    [ma dropLastObjectsWithCount:2];
    XCTAssert([ma isEqualToArray:aa2]);
    
    [ma dropLastObjectsWithCount:2];
    XCTAssert(ma.count == 0);
}

- (void)testArrayPrefix {
    NSArray *a = @[@1, @2, @3, @4, @5];
    
    NSArray *a1 = [a prefixed:1];
    NSArray *aa1 = @[@1];
    XCTAssert([a1 isEqualToArray:aa1]);
    
    NSArray *a2 = [a prefixed:3];
    NSArray *aa2 = @[@1, @2, @3];
    XCTAssert([a2 isEqualToArray:aa2]);
    
    NSArray *a3 = [a prefixed:a.count];
    XCTAssert([a3 isEqualToArray:a]);
    
    NSArray *a4 = [a prefixed:0];
    XCTAssert(a4.count == 0);
    
    NSMutableArray *ma = a.mutableCopy;
    [ma prefixObjectsWithCount:1];
    XCTAssert([ma isEqualToArray:aa1]);
    
    ma = a.mutableCopy;
    [ma prefixObjectsWithCount:3];
    XCTAssert([ma isEqualToArray:aa2]);
    
    ma = a.mutableCopy;
    [ma prefixObjectsWithCount:0];
    XCTAssert(ma.count == 0);
    
    ma = a.mutableCopy;
    [ma prefixObjectsWithCount:a.count];
    XCTAssert([ma isEqualToArray:a]);
}

- (void)testArraySuffix {
    NSArray *a = @[@1, @2, @3, @4, @5];
    
    NSArray *a1 = [a suffixed:1];
    NSArray *aa1 = @[@5];
    XCTAssert([a1 isEqualToArray:aa1]);
    
    NSArray *a2 = [a suffixed:3];
    NSArray *aa2 = @[@3, @4, @5];
    XCTAssert([a2 isEqualToArray:aa2]);
    
    NSArray *a3 = [a suffixed:a.count];
    XCTAssert([a3 isEqualToArray:a]);
    
    NSArray *a4 = [a suffixed:0];
    XCTAssert(a4.count == 0);
    
    NSMutableArray *ma = a.mutableCopy;
    [ma suffixObjectsWithCount:1];
    XCTAssert([ma isEqualToArray:aa1]);
    
    ma = a.mutableCopy;
    [ma suffixObjectsWithCount:3];
    XCTAssert([ma isEqualToArray:aa2]);
    
    ma = a.mutableCopy;
    [ma suffixObjectsWithCount:0];
    XCTAssert(ma.count == 0);
    
    ma = a.mutableCopy;
    [ma suffixObjectsWithCount:a.count];
    XCTAssert([ma isEqualToArray:a]);
}

@end
