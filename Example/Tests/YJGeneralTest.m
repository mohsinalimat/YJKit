//
//  YJGeneralTest.m
//  YJKit
//
//  Created by huang-kun on 16/5/20.
//  Copyright © 2016年 huang-kun. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <objc/runtime.h>
#import "YJCircularImageView.h"

@interface YJGeneralTest : XCTestCase

@end

@implementation YJGeneralTest

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
    
    YJCircularImageView *imageView = [[YJCircularImageView alloc] initWithFrame:CGRectMake(0,0,100,100)];
    imageView.circleColor = [UIColor redColor];
    imageView.circleWidth = 5.0;
    [imageView setValue:@YES forKey:@"_didFirstLayout"];
    [imageView setValue:@NO forKey:@"_forceMaskColor"];
    [imageView setValue:[NSValue valueWithCGRect:(CGRect){1,2,3,4}] forKey:@"_transparentFrame"];
    
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:imageView];
    id newView = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    
    NSLog(@"");
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
