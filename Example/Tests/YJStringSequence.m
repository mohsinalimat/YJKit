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
    [self testdropFirst];
    [self testdropLast];
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

- (void)testdropFirst {
    NSString *s = @"hello";
    NSMutableString *ms = s.mutableCopy;
    
    NSString *s1 = [s droppingFirst];
    XCTAssert([s1 isEqualToString:@"ello"]);
    
    [ms dropFirstCharacter];
    XCTAssert([ms isEqualToString:@"ello"]);
    
    NSString *s2 = [s droppingFirst:3];
    XCTAssert([s2 isEqualToString:@"lo"]);
    
    [ms dropFirstCharactersWithCount:2];
    XCTAssert([ms isEqualToString:@"lo"]);
    
    NSString *s3 = [s droppingFirst:5];
    XCTAssert(s3.length == 0);
    
    [ms dropFirstCharactersWithCount:2];
    XCTAssert(ms.length == 0);
}

- (void)testdropLast {
    NSString *s = @"hello";
    NSMutableString *ms = s.mutableCopy;
    
    NSString *s1 = [s droppingLast];
    XCTAssert([s1 isEqualToString:@"hell"]);
    
    [ms dropLastCharacter];
    XCTAssert([ms isEqualToString:@"hell"]);
    
    NSString *s2 = [s droppingLast:3];
    XCTAssert([s2 isEqualToString:@"he"]);
    
    [ms dropLastCharactersWithCount:2];
    XCTAssert([ms isEqualToString:@"he"]);
    
    NSString *s3 = [s droppingLast:5];
    XCTAssert(s3.length == 0);
    
    [ms dropLastCharactersWithCount:2];
    XCTAssert(ms.length == 0);
}

- (void)testPrefix {
    NSString *s = @"hello";
    NSMutableString *ms = s.mutableCopy;
    
    NSString *s1 = [s prefixed:2];
    XCTAssert([s1 isEqualToString:@"he"]);
    
    [ms prefixCharactersWithCount:2];
    XCTAssert([ms isEqualToString:@"he"]);
    
    NSString *s2 = [s prefixingUpToIndex:2];
    XCTAssert([s2 isEqualToString:@"hel"]);
    
    ms = s.mutableCopy;
    [ms prefixCharactersUpToIndex:2];
    XCTAssert([ms isEqualToString:@"hel"]);
    
    NSString *s3 = [s prefixed:5];
    XCTAssert([s3 isEqualToString:@"hello"]);
    
    ms = s.mutableCopy;
    [ms prefixCharactersWithCount:5];
    XCTAssert([ms isEqualToString:@"hello"]);
    
    NSString *s4 = [s prefixingUpToIndex:s.length-1];
    XCTAssert([s4 isEqualToString:@"hello"]);
    
    ms = s.mutableCopy;
    [ms prefixCharactersUpToIndex:s.length-1];
    XCTAssert([ms isEqualToString:@"hello"]);
    
    NSString *s5 = [s prefixed:0];
    XCTAssert(s5.length == 0);
    
    ms = s.mutableCopy;
    [ms prefixCharactersWithCount:0];
    XCTAssert(ms.length == 0);
}

- (void)testSuffix {
    NSString *s = @"hello";
    NSMutableString *ms = s.mutableCopy;
    
    NSString *s1 = [s suffixed:2];
    XCTAssert([s1 isEqualToString:@"lo"]);
    
    [ms suffixCharactersWithCount:2];
    XCTAssert([ms isEqualToString:@"lo"]);
    
    NSString *s2 = [s suffixingFromIndex:2];
    XCTAssert([s2 isEqualToString:@"llo"]);
    
    ms = s.mutableCopy;
    [ms suffixCharactersFromIndex:2];
    XCTAssert([ms isEqualToString:@"llo"]);
    
    NSString *s3 = [s suffixed:5];
    XCTAssert([s3 isEqualToString:@"hello"]);
    
    ms = s.mutableCopy;
    [ms suffixCharactersWithCount:5];
    XCTAssert([ms isEqualToString:@"hello"]);
    
    NSString *s4 = [s suffixingFromIndex:0];
    XCTAssert([s4 isEqualToString:@"hello"]);
    
    ms = s.mutableCopy;
    [ms suffixCharactersFromIndex:0];
    XCTAssert([ms isEqualToString:@"hello"]);
    
    NSString *s5 = [s suffixingFromIndex:s.length-1];
    XCTAssert([s5 isEqualToString:@"o"]);
    
    ms = s.mutableCopy;
    [ms suffixCharactersFromIndex:s.length-1];
    XCTAssert([ms isEqualToString:@"o"]);
}

@end
