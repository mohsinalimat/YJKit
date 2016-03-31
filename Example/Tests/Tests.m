//
//  YJKitTests.m
//  YJKitTests
//
//  Created by huang-kun on 03/27/2016.
//  Copyright (c) 2016 huang-kun. All rights reserved.
//

@import XCTest;
#import "YJKit.h"

@interface Tests : XCTestCase

@end

@implementation Tests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample
{
//    XCTFail(@"No implementation for \"%s\"", __PRETTY_FUNCTION__);
}

#pragma mark - Bundle Image Test

- (void)testBundleImage {
    // NSBundle
    NSBundle *camBundle = [NSBundle bundleWithName:@"AFTCameraUI"];
    NSString *camBundlePath = [[NSBundle mainBundle] pathForResource:@"AFTCameraUI" ofType:@"bundle"];
    
    // Image Path
    NSString *imagePath1 = [camBundle pathForScaledResource:@"ic_camera" ofType:@"png"];
    XCTAssert(imagePath1 != nil, @"");
    NSString *imagePath2 = [camBundle pathForScaledResource:@"ic_finish" ofType:@"png" inDirectory:@"finish_icons"];
    XCTAssert(imagePath2 != nil, @"");
    NSString *imagePath3 = [NSBundle pathForScaledResource:@"ic_finish" ofType:@"png" inDirectory:(id)[UIImage imageNamed:@"hello"]];
    XCTAssert(imagePath3 == nil, @"");
    NSString *imagePath4 = [NSBundle pathForScaledResource:@"ic_camera" ofType:@"png" inDirectory:camBundlePath];
    XCTAssert(imagePath4 != nil, @"");
    
    // Image
    UIImage *image1 = [UIImage imageNamed:@"ic_camera" scaledInBundle:camBundle];
    XCTAssert(image1 != nil, @"");
    UIImage *image2 = [UIImage imageNamed:@"ic_camera.png" scaledInBundle:camBundle];
    XCTAssert(image2 == nil, @"");
    UIImage *image3 = [UIImage imageNamed:@"ic_camera@2x.png" scaledInBundle:camBundle];
    XCTAssert(image3 != nil, @"");
}

- (void)testYJMacros {
    CGFloat r = RadiansInDegrees(30);
    XCTAssert(sinf(r)==0.5, @"");
    CGFloat d = DegreesInRadians(r);
    XCTAssert(d==30, @"");
}

@end

