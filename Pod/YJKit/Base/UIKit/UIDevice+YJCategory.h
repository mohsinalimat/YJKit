//
//  UIDevice+YJCategory.h
//  YJKit
//
//  Created by Jack Huang on 16/3/21.
//  Copyright © 2016年 Jack Huang. All rights reserved.
//

@import UIKit;

@interface UIDevice (YJCategory)

+ (float)systemVersion;
+ (BOOL)isPhone;
+ (BOOL)isPad;

@property (nonatomic, readonly) BOOL isPhone;
@property (nonatomic, readonly) BOOL isPad;

@end
