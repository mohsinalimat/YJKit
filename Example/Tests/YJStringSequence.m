//
//  YJStringSequence.m
//  YJKit
//
//  Created by huang-kun on 16/5/19.
//  Copyright © 2016年 huang-kun. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "NSString+YJSequence.h"
#import "NSString+YJCollection.h"
#import "NSMutableString+YJSequence.h"

@interface YJStringSequence : XCTestCase

@end

@implementation YJStringSequence

- (void)testSequence {
    [self testCharacters];
    [self testdroppingFirst];
    [self testdroppingLast];
    [self testPrefix];
    [self testSuffix];
}

- (void)testCharacters {
    NSString *s = @"hello";
    NSArray *chars = s.characters;
    XCTAssert(chars.count == 5);
    
    NSString *s1 = s.firstCharacter;
    XCTAssert([s1 isEqualToString:@"h"]);
    
    NSString *s2 = s.lastCharacter;
    XCTAssert([s2 isEqualToString:@"o"]);
    
    NSString *s3 = @"".firstCharacter;
    XCTAssert(s3 == nil);
    
    NSString *s4 = @"".lastCharacter;
    XCTAssert(s4 == nil);
}

- (void)testdroppingFirst {
    NSString *s = @"hello";
    NSMutableString *ms = s.mutableCopy;
    
    NSString *s1 = [s dropFirst];
    XCTAssert([s1 isEqualToString:@"ello"]);
    
    [ms droppingFirst];
    XCTAssert([ms isEqualToString:@"ello"]);
    
    NSString *s2 = [s dropFirst:3];
    XCTAssert([s2 isEqualToString:@"lo"]);
    
    [ms droppingFirst:2];
    XCTAssert([ms isEqualToString:@"lo"]);
    
    NSString *s3 = [s dropFirst:5];
    XCTAssert(s3.length == 0);
    
    [ms droppingFirst:2];
    XCTAssert(ms.length == 0);
}

- (void)testdroppingLast {
    NSString *s = @"hello";
    NSMutableString *ms = s.mutableCopy;
    
    NSString *s1 = [s dropLast];
    XCTAssert([s1 isEqualToString:@"hell"]);
    
    [ms droppingLast];
    XCTAssert([ms isEqualToString:@"hell"]);
    
    NSString *s2 = [s dropLast:3];
    XCTAssert([s2 isEqualToString:@"he"]);
    
    [ms droppingLast:2];
    XCTAssert([ms isEqualToString:@"he"]);
    
    NSString *s3 = [s dropLast:5];
    XCTAssert(s3.length == 0);
    
    [ms droppingLast:2];
    XCTAssert(ms.length == 0);
}

- (void)testPrefix {
    NSString *s = @"hello";
    NSMutableString *ms = s.mutableCopy;
    
    NSString *s1 = [s prefix:2];
    XCTAssert([s1 isEqualToString:@"he"]);
    
    [ms prefixing:2];
    XCTAssert([ms isEqualToString:@"he"]);
    
    NSString *s2 = [s prefixUpTo:2];
    XCTAssert([s2 isEqualToString:@"hel"]);
    
    ms = s.mutableCopy;
    [ms prefixingUpTo:2];
    XCTAssert([ms isEqualToString:@"hel"]);
    
    NSString *s3 = [s prefix:5];
    XCTAssert([s3 isEqualToString:@"hello"]);
    
    ms = s.mutableCopy;
    [ms prefixing:5];
    XCTAssert([ms isEqualToString:@"hello"]);
    
    NSString *s4 = [s prefixUpTo:s.length-1];
    XCTAssert([s4 isEqualToString:@"hello"]);
    
    ms = s.mutableCopy;
    [ms prefixingUpTo:s.length-1];
    XCTAssert([ms isEqualToString:@"hello"]);
    
    NSString *s5 = [s prefix:0];
    XCTAssert(s5.length == 0);
    
    ms = s.mutableCopy;
    [ms prefixing:0];
    XCTAssert(ms.length == 0);
}

- (void)testSuffix {
    NSString *s = @"hello";
    NSMutableString *ms = s.mutableCopy;
    
    NSString *s1 = [s suffix:2];
    XCTAssert([s1 isEqualToString:@"lo"]);
    
    [ms suffixing:2];
    XCTAssert([ms isEqualToString:@"lo"]);
    
    NSString *s2 = [s suffixFrom:2];
    XCTAssert([s2 isEqualToString:@"llo"]);
    
    ms = s.mutableCopy;
    [ms suffixingFrom:2];
    XCTAssert([ms isEqualToString:@"llo"]);
    
    NSString *s3 = [s suffix:5];
    XCTAssert([s3 isEqualToString:@"hello"]);
    
    ms = s.mutableCopy;
    [ms suffixing:5];
    XCTAssert([ms isEqualToString:@"hello"]);
    
    NSString *s4 = [s suffixFrom:0];
    XCTAssert([s4 isEqualToString:@"hello"]);
    
    ms = s.mutableCopy;
    [ms suffixingFrom:0];
    XCTAssert([ms isEqualToString:@"hello"]);
    
    NSString *s5 = [s suffixFrom:s.length-1];
    XCTAssert([s5 isEqualToString:@"o"]);
    
    ms = s.mutableCopy;
    [ms suffixingFrom:s.length-1];
    XCTAssert([ms isEqualToString:@"o"]);
}

@end
