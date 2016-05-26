//
//  NSObject+YJRuntimeSwizzling.h
//  YJKit
//
//  Created by huang-kun on 16/5/13.
//  Copyright © 2016年 huang-kun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (YJRuntimeSwizzling)

+ (void)swizzleInstanceMethodForSelector:(SEL)selector toSelector:(SEL)toSelector;
+ (void)swizzleClassMethodForSelector:(SEL)selector toSelector:(SEL)toSelector;

@end
