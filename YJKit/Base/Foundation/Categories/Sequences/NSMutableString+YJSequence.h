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
 NSMutableString *s1 = [@"hello" mutableCopy];
 [s1 droppingFirst]; // @"ello"
 *  @endcode
 */
- (void)droppingFirst;


/**
 *  @code
 NSMutableString *s1 = [@"hello" mutableCopy];
 [s1 droppingFirst:3]; // @"lo"
 *  @endcode
 */
- (void)droppingFirst:(NSUInteger)count;


/**
 *  @code
 NSMutableString *s1 = [@"hello" mutableCopy];
 [s1 droppingLast]; // @"hell"
 *  @endcode
 */
- (void)droppingLast;


/**
 *  @code
 NSMutableString *s1 = [@"hello" mutableCopy];
 [s1 droppingLast:3]; // @"he"
 *  @endcode
 */
- (void)droppingLast:(NSUInteger)count;


/**
 *  @code
 NSMutableString *s1 = [@"hello" mutableCopy];
 [s1 prefixing:2]; // @"he"
 *  @endcode
 */
- (void)prefixing:(NSUInteger)count;


/**
 *  @code
 NSMutableString *s1 = [@"hello" mutableCopy];
 [s1 prefixingUpTo:2]; // @"hel"
 *  @endcode
 */
- (void)prefixingUpTo:(NSUInteger)upToIndex;


/**
 *  @code
 NSMutableString *s1 = [@"hello" mutableCopy];
 [s1 suffixing:2]; // @"lo"
 *  @endcode
 */
- (void)suffixing:(NSUInteger)count;


/**
 *  @code
 NSMutableString *s1 = [@"hello" mutableCopy];
 [s1 suffixingFrom:2]; // @"llo"
 *  @endcode
 */
- (void)suffixingFrom:(NSUInteger)fromIndex;

@end
