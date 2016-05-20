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
 *  @endcode
 */
- (NSString *)dropFirst;


/**
 *  @code
 NSString *s1 = [@"hello" dropFirst:3]; // @"lo"
 *  @endcode
 */
- (NSString *)dropFirst:(NSUInteger)count;


/**
 *  @code
 NSString *s1 = [@"hello" dropLast]; // @"hell"
 *  @endcode
 */
- (NSString *)dropLast;


/**
 *  @code
 NSString *s1 = [@"hello" dropLast:3]; // @"he"
 *  @endcode
 */
- (NSString *)dropLast:(NSUInteger)count;


/**
 *  @code
 NSString *s1 = [@"hello" prefix:2]; // @"he"
 *  @endcode
 */
- (NSString *)prefix:(NSUInteger)count;


/**
 *  @code
 NSString *s1 = [@"hello" prefixUpTo:2]; // @"hel"
 *  @endcode
 */
- (NSString *)prefixUpTo:(NSUInteger)upToIndex;


/**
 *  @code
 NSString *s1 = [@"hello" suffix:2]; // @"lo"
 *  @endcode
 */
- (NSString *)suffix:(NSUInteger)count;


/**
 *  @code
 NSString *s1 = [@"hello" suffixFrom:2]; // @"llo"
 *  @endcode
 */
- (NSString *)suffixFrom:(NSUInteger)fromIndex;

@end

NS_ASSUME_NONNULL_END
