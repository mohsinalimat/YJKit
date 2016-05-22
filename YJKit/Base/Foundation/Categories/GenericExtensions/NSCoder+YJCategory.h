//
//  NSCoder+YJCategory.h
//  YJKit
//
//  Created by huang-kun on 16/5/22.
//  Copyright © 2016年 huang-kun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CGGeometry.h>

@interface NSCoder (YJGeometryExtension)

- (void)encodeCGFloat:(CGFloat)aFloat forKey:(NSString *)key;

- (CGFloat)decodeCGFloatForKey:(NSString *)key;

@end
