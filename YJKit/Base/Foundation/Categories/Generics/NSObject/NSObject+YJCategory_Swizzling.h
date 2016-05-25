//
//  NSObject+YJCategory_Swizzling.h
//  YJKit
//
//  Created by huang-kun on 16/5/13.
//  Copyright © 2016年 huang-kun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (YJCategory_Swizzling)

+ (void)swizzleInstanceMethodForSelector:(SEL)fromSelector toSelector:(SEL)toSelector;

@end
