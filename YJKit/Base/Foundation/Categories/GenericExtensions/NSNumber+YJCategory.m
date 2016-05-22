//
//  NSNumber+YJCategory.m
//  YJKit
//
//  Created by huang-kun on 16/5/22.
//  Copyright © 2016年 huang-kun. All rights reserved.
//

#import "NSNumber+YJCategory.h"

@implementation NSNumber (YJGeometryExtension)

- (CGFloat)CGFloatValue {
#if CGFLOAT_IS_DOUBLE
    return (CGFloat)[self doubleValue];
#else
    return (CGFloat)[self floatValue];
#endif
}

@end
