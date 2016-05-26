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
 NSString *str = [@"hello" stringByDroppingFirstCharacter]; // @"ello"
 *  @endcode
 */
- (NSString *)stringByDroppingFirstCharacter;

- (NSString *)droppingFirst OBJC_SWIFT_UNAVAILABLE("use Swift dropFirst() instead");


/**
 *  @code
 NSString *str = [@"hello" stringByDroppingFirstCharactersWithCount:3]; // @"lo"
 *  @endcode
 */
- (NSString *)stringByDroppingFirstCharactersWithCount:(NSUInteger)count;

- (NSString *)droppingFirst:(NSUInteger)count OBJC_SWIFT_UNAVAILABLE("use Swift dropFirst() instead");


/**
 *  @code
 NSString *str = [@"hello" stringByDroppingLastCharacter]; // @"hell"
 *  @endcode
 */
- (NSString *)stringByDroppingLastCharacter;

- (NSString *)droppingLast OBJC_SWIFT_UNAVAILABLE("use Swift dropLast() instead");


/**
 *  @code
 NSString *str = [@"hello" stringByDroppingLastCharactersWithCount:3]; // @"he"
 *  @endcode
 */
- (NSString *)stringByDroppingLastCharactersWithCount:(NSUInteger)count;

- (NSString *)droppingLast:(NSUInteger)count OBJC_SWIFT_UNAVAILABLE("use Swift dropLast() instead");


/**
 *  @code
 NSString *str = [@"hello" stringByPrefixingCharactersWithCount:2]; // @"he"
 *  @endcode
 */
- (NSString *)stringByPrefixingCharactersWithCount:(NSUInteger)count;

- (NSString *)prefixed:(NSUInteger)count OBJC_SWIFT_UNAVAILABLE("use Swift prefix() instead");


/**
 *  @code
 NSString *str = [@"hello" stringByPrefixingCharactersUpToIndex:2]; // @"hel"
 *  @endcode
 */
- (NSString *)stringByPrefixingCharactersUpToIndex:(NSUInteger)upToIndex;

- (NSString *)prefixingUpToIndex:(NSUInteger)upToIndex OBJC_SWIFT_UNAVAILABLE("use Swift prefix(upTo:) instead");


/**
 *  @code
 NSString *str = [@"hello" stringBySuffixingCharactersWithCount:2]; // @"lo"
 *  @endcode
 */
- (NSString *)stringBySuffixingCharactersWithCount:(NSUInteger)count;

- (NSString *)suffixed:(NSUInteger)count OBJC_SWIFT_UNAVAILABLE("use Swift suffix() instead");


/**
 *  @code
 NSString *str = [@"hello" stringBySuffixingCharactersFromIndex:2]; // @"llo"
 *  @endcode
 */
- (NSString *)stringBySuffixingCharactersFromIndex:(NSUInteger)fromIndex;

- (NSString *)suffixingFromIndex:(NSUInteger)fromIndex OBJC_SWIFT_UNAVAILABLE("use Swift suffix(from:) instead");

@end

NS_ASSUME_NONNULL_END
