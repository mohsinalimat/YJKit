//
//  YJGeneralTest.m
//  YJKit
//
//  Created by huang-kun on 16/5/20.
//  Copyright © 2016年 huang-kun. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "UIColor+YJCategory.h"
#import "NSString+YJCollection.h"

@interface YJGeneralTest : XCTestCase

@end

@implementation YJGeneralTest

- (void)testColor {
    __unused UIColor *c1 = [UIColor randomColor];
    __unused UIColor *c2 = [UIColor randomColor];
    __unused UIColor *c3 = [UIColor randomColor];
    
    NSLog(@"%@", @"HELLO"[2]);
    
//    BOOL equal = [[UIColor whiteColor] isEqualToColor:nil];
    
    NSLog(@"");
}

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    __unused NSString *hello = @"hello";
    __unused NSArray *arr = @[@1];
    NSLog(@"");
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
