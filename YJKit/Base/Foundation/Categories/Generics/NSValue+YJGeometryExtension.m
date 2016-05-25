//
//  NSValue+YJGeometryExtension.m
//  YJKit
//
//  Created by huang-kun on 16/5/25.
//  Copyright © 2016年 huang-kun. All rights reserved.
//

#import "NSValue+YJGeometryExtension.h"

@implementation NSNumber (YJGeometryExtension)

- (CGFloat)CGFloatValue {
#if CGFLOAT_IS_DOUBLE
    return (CGFloat)[self doubleValue];
#else
    return (CGFloat)[self floatValue];
#endif
}

@end


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