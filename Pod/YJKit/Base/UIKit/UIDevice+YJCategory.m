//
//  UIDevice+YJCategory.m
//  YJKit
//
//  Created by Jack Huang on 16/3/21.
//  Copyright © 2016年 Jack Huang. All rights reserved.
//

#import "UIDevice+YJCategory.h"

@implementation UIDevice (YJCategory)

- (BOOL)isPhone {
    static BOOL isPhone;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        isPhone = UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone ? YES : NO;
    });
    return isPhone;
}

- (BOOL)isPad {
    static BOOL isPad;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        isPad = UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad ? YES : NO;
    });
    return isPad;
}

+ (float)systemVersion {
    static float version;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        version = [[[self currentDevice] systemVersion] floatValue];
    });
    return version;
}

+ (BOOL)isPhone {
    return [[self currentDevice] isPhone];
}

+ (BOOL)isPad {
    return [[self currentDevice] isPad];
}

@end
