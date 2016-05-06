//
//  UIDevice+YJCategory.h
//  YJKit
//
//  Created by huang-kun on 16/3/21.
//  Copyright © 2016年 huang-kun. All rights reserved.
//

#import <UIKit/UIDevice.h>

@interface UIDevice (YJCategory)

+ (float)systemVersion;
+ (BOOL)isPhone;
+ (BOOL)isPad;

@property (nonatomic, readonly) BOOL isPhone;
@property (nonatomic, readonly) BOOL isPad;

@end
