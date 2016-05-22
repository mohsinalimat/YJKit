//
//  YJContentExtension.h
//  YJKit
//
//  Created by huang-kun on 16/5/22.
//  Copyright © 2016年 huang-kun. All rights reserved.
//

#import "YJContentIndents.h"

@interface NSValue (YJContentExtension)

+ (NSValue *)valueWithContentIndents:(YJContentIndents)indents;

- (YJContentIndents)YJContentIndentsValue;

@end


@interface NSCoder (YJContentExtension)

- (void)encodeContentIndents:(YJContentIndents)indents forKey:(NSString *)key;

- (YJContentIndents)decodeContentIndentsForKey:(NSString *)key;

@end