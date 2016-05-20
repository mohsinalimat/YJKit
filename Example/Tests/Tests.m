//
//  YJKitTests.m
//  YJKitTests
//
//  Created by huang-kun on 03/27/2016.
//  Copyright (c) 2016 huang-kun. All rights reserved.
//

/*
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

- (void)testRGBColor {
    UIColor *whiteColor = RGBColor(0xffffff, 1);
    UIColor *blackColor = [UIColor colorWithHex:0x0 alpha:1.0];
    UIColor *randomColor = [UIColor colorWithHexString:@"0xffffff"];
    XCTAssert([whiteColor isEqualToRGBColor:[UIColor whiteColor]]);
    XCTAssert([blackColor isEqualToRGBColor:[UIColor blackColor]]);
    XCTAssert(randomColor);
}

- (void)testYJCollection {
    [self testCollectionMap];
    [self testCollectionFilter];
    [self testCollectionReduce];
    [self testCollectionFlatten];
}

- (void)testCollectionMap {
    // map
    NSArray *a = @[@"hello", @"world", [NSNull null], @"and", @"you"];
    
    NSArray *a1 = [a map:^id(id obj) { return [obj uppercaseString]; }];
    BOOL correct1 = [a1 isEqualToArray:@[@"HELLO", @"WORLD", [NSNull null], @"AND", @"YOU"]];
    XCTAssert(correct1);
    
    NSArray *a2 = [a flatMap:^U _Nonnull(id  _Nonnull obj) { return @[[obj uppercaseString]]; }];
    BOOL correct2 = [a2 isEqualToArray:@[@"HELLO", @"WORLD", [NSNull null], @"AND", @"YOU"]];
    XCTAssert(correct2);
}

- (void)testCollectionFilter {
    // filter
    NSArray *a1 = @[@1, @2, [NSNull null], @3, [NSNull null], @"hello"];
    NSArray *a2 = [a1 filter:^BOOL(id obj) { return [obj isKindOfClass:[NSNumber class]]; }];
    BOOL correct1 = [a2 isEqualToArray:@[@1, @2, @3]];
    XCTAssert(correct1);
    
    NSArray *a3 = [a2 filter:^BOOL(id obj) { return [obj intValue] < 3; }];
    BOOL correct2 = [a3 isEqualToArray:@[@1, @2]];
    XCTAssert(correct2);
}

- (void)testCollectionReduce {
    // reduce
    NSNumber *n1 = [@[ @1, @2, @3, @4 ] reduce:nil combine:^U(U result, NSNumber *obj) { return @([result intValue] + [obj intValue]); }];
    XCTAssert([n1 isEqual:@10]);
    
    NSNumber *n2 = [@[ @1, @2, @3, @4 ] reduce:@2 combine:^U(U result, NSNumber *obj) { return @([result intValue] + [obj intValue]); }]; // @9
    XCTAssert([n2 isEqual:@9]);
    
    NSString *s1 = [@[ @"hello", @"world", @"and", @"you" ] reduce:@"hello" combine:^id(id result, id obj) {
        return [result stringByAppendingFormat:@" %@", obj];
    }]; // @"hello world and you"
    XCTAssert([s1 isEqualToString:@"hello world and you"]);
    
    NSString *s2 = [@[ @"hello", @"world", @"and", @"you" ] reduce:^id(id result, id obj) {
        return [result stringByAppendingFormat:@" %@", obj];
    }]; // @"hello world and you"
    XCTAssert([s2 isEqualToString:@"hello world and you"]);
}

- (void)testCollectionFlatten {
    NSArray *a = @[@1, @[ @2, @3, ], @[ @4, @[ @[ @5, @6 ] ] ] ];
    NSArray *b = [a flatten]; // @[ @1, @2, @3, @4, @5, @6 ]
    BOOL correct = [b isEqualToArray:@[ @1, @2, @3, @4, @5, @6 ]];
    XCTAssert(correct);
}

- (void)testStringSequence {
    NSString *s = @"hello world and you.";
    NSMutableString *ms = s.mutableCopy;
    NSArray *characters = s.characters;
    
    NSArray *a = @[@1];
    NSMutableArray *b = a.mutableCopy;
    
    
    NSString *s1 = [s dropFirst];
    XCTAssert([s1 isEqualToString:@"ello world and you."]);
    
    [ms dropFirst];
    XCTAssert([ms isEqualToString:@"ello world and you."]);
    ms = s.mutableCopy;
    
    NSString *s2 = [s dropFirst:5];
    XCTAssert([s2 isEqualToString:@" world and you."]);
    
    NSString *s3 = [s dropLast];
    XCTAssert([s3 isEqualToString:@"hello world and you"]);
    
    NSString *s4 = [s dropLast:5];
    XCTAssert([s4 isEqualToString:@"hello world and"]);
    
    NSString *s5 = s.firstCharacter;
    XCTAssert([s5 isEqualToString:@"h"]);
    
    NSString *s6 = s.lastCharacter;
    XCTAssert([s6 isEqualToString:@"."]);
    
    NSString *s7 = [s prefix:5];
    XCTAssert([s7 isEqualToString:@"hello"]);
    
    NSString *s8 = [s prefixUpTo:5];
    XCTAssert([s8 isEqualToString:@"hello "]);
    
    NSString *s9 = [s suffix:5];
    XCTAssert([s9 isEqualToString:@" you."]);
    
    NSString *s10 = [s suffixFrom:15];
    XCTAssert([s10 isEqualToString:@"d you."]);
    
    
}

@end
*/
