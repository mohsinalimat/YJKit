//
//  NSString+YJCollection.h
//  YJKit
//
//  Created by huang-kun on 16/5/21.
//  Copyright © 2016年 huang-kun. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (YJCollection)

/**
 *  @code
 NSArray *chars = @"hello".characters; // @"h", @"e", @"l", @"l", @"o"
 *  @endcode
 */
@property (nonatomic, readonly) NSArray <NSString *> *characters;


@property (nonatomic, readonly, nullable) NSString *firstCharacter;
@property (nonatomic, readonly, nullable) NSString *lastCharacter;


/**
 * e.g. @"hello"[1] // @"e"
 */
- (NSString *)objectAtIndexedSubscript:(NSUInteger)idx;

@end

NS_ASSUME_NONNULL_END
