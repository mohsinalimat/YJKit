//
//  NSString+YJSequence.h
//  YJKit
//
//  Created by huang-kun on 16/5/16.
//  Copyright © 2016年 huang-kun. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (YJSequence)

/**
 *  @code
 NSArray *chars = @"hello".characters; // @"h", @"e", @"l", @"l", @"o"
 *  @endcode
 */
@property (nonatomic, readonly) NSArray <NSString *> *characters;

@property (nonatomic, readonly, nullable) NSString *firstCharacter;
@property (nonatomic, readonly, nullable) NSString *lastCharacter;


/**
 *  @code 
 NSString *s1 = [@"hello" dropFirst]; // @"ello"
 
 NSMutableString *s2 = [@"hello" mutableCopy];
 [s2 dropFirst];
 *  @endcode
 */
- (id)dropFirst;


/**
 *  @code
 NSString *s1 = [@"hello" dropFirst:3]; // @"lo"
 
 NSMutableString *s2 = [@"hello" mutableCopy];
 [s2 dropFirst:3];
 *  @endcode
 */
- (id)dropFirst:(NSUInteger)count;


/**
 *  @code
 NSString *s1 = [@"hello" dropLast]; // @"hell"
 
 NSMutableString *s2 = [@"hello" mutableCopy];
 [s2 dropLast];
 *  @endcode
 */
- (id)dropLast;


/**
 *  @code
 NSString *s1 = [@"hello" dropLast:3]; // @"he"
 
 NSMutableString *s2 = [@"hello" mutableCopy];
 [s2 dropLast:3];
 *  @endcode
 */
- (id)dropLast:(NSUInteger)count;


/**
 *  @code
 NSString *s1 = [@"hello" prefix:2]; // @"he"
 
 NSMutableString *s2 = [@"hello" mutableCopy];
 [s2 prefix:2];
 *  @endcode
 */
- (id)prefix:(NSUInteger)count;


/**
 *  @code
 NSString *s1 = [@"hello" prefixUpTo:2]; // @"hel"
 
 NSMutableString *s2 = [@"hello" mutableCopy];
 [s2 prefixUpTo:2];
 *  @endcode
 */
- (id)prefixUpTo:(NSUInteger)upToIndex;


/**
 *  @code
 NSString *s1 = [@"hello" suffix:2]; // @"lo"
 
 NSMutableString *s2 = [@"hello" mutableCopy];
 [s2 suffix:2];
 *  @endcode
 */
- (id)suffix:(NSUInteger)count;


/**
 *  @code
 NSString *s1 = [@"hello" suffixFrom:2]; // @"llo"
 
 NSMutableString *s2 = [@"hello" mutableCopy];
 [s2 suffixFrom:2];
 *  @endcode
 */
- (id)suffixFrom:(NSUInteger)fromIndex;

@end

NS_ASSUME_NONNULL_END
