//
//  NSCoder+YJCategory.m
//  YJKit
//
//  Created by huang-kun on 16/5/22.
//  Copyright © 2016年 huang-kun. All rights reserved.
//

#import "NSCoder+YJCategory.h"

@implementation NSCoder (YJGeometryExtension)

- (void)encodeCGFloat:(CGFloat)aFloat forKey:(NSString *)key {
#if CGFLOAT_IS_DOUBLE
    [self encodeDouble:aFloat forKey:key];
#else
    [self encodeFloat:aFloat forKey:key];
#endif
}

- (CGFloat)decodeCGFloatForKey:(NSString *)key {
#if CGFLOAT_IS_DOUBLE
    return (CGFloat)[self decodeDoubleForKey:key];
#else
    return (CGFloat)[self decodeFloatForKey:key];
#endif
}

@end
