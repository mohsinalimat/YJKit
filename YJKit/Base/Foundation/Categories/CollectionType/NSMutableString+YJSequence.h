//
//  NSMutableString+YJSequence.h
//  YJKit
//
//  Created by huang-kun on 16/5/20.
//  Copyright © 2016年 huang-kun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableString (YJSequence)

/**
 *  @code
 NSMutableString *mstr = [@"hello" mutableCopy];
 [mstr dropFirstCharacter]; // @"ello"
 *  @endcode
 */
- (void)dropFirstCharacter OBJC_SWIFT_UNAVAILABLE("use Swift dropFirst() instead");

/**
 *  @code
 NSMutableString *mstr = [@"hello" mutableCopy];
 [mstr dropFirstCharactersWithCount:3]; // @"lo"
 *  @endcode
 */
- (void)dropFirstCharactersWithCount:(NSUInteger)count OBJC_SWIFT_UNAVAILABLE("use Swift dropFirst() instead");

/**
 *  @code
 NSMutableString *mstr = [@"hello" mutableCopy];
 [mstr dropLastCharacter]; // @"hell"
 *  @endcode
 */
- (void)dropLastCharacter OBJC_SWIFT_UNAVAILABLE("use Swift dropLast() instead");


/**
 *  @code
 NSMutableString *mstr = [@"hello" mutableCopy];
 [mstr dropLastCharactersWithCount:3]; // @"he"
 *  @endcode
 */
- (void)dropLastCharactersWithCount:(NSUInteger)count OBJC_SWIFT_UNAVAILABLE("use Swift dropLast() instead");


/**
 *  @code
 NSMutableString *mstr = [@"hello" mutableCopy];
 [mstr prefixCharactersWithCount:2]; // @"he"
 *  @endcode
 */
- (void)prefixCharactersWithCount:(NSUInteger)count OBJC_SWIFT_UNAVAILABLE("use Swift prefix() instead");


/**
 *  @code
 NSMutableString *mstr = [@"hello" mutableCopy];
 [mstr prefixCharactersUpToIndex:2]; // @"hel"
 *  @endcode
 */
- (void)prefixCharactersUpToIndex:(NSUInteger)upToIndex OBJC_SWIFT_UNAVAILABLE("use Swift prefix(upTo:) instead");


/**
 *  @code
 NSMutableString *mstr = [@"hello" mutableCopy];
 [mstr suffixCharactersWithCount:2]; // @"lo"
 *  @endcode
 */
- (void)suffixCharactersWithCount:(NSUInteger)count OBJC_SWIFT_UNAVAILABLE("use Swift suffix() instead");


/**
 *  @code
 NSMutableString *mstr = [@"hello" mutableCopy];
 [mstr suffixCharactersFromIndex:2]; // @"llo"
 *  @endcode
 */
- (void)suffixCharactersFromIndex:(NSUInteger)fromIndex OBJC_SWIFT_UNAVAILABLE("use Swift suffix(from:) instead");

@end
