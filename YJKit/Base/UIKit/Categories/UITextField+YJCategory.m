//
//  UITextField+YJCategory.m
//  YJKit
//
//  Created by huang-kun on 16/5/25.
//  Copyright © 2016年 huang-kun. All rights reserved.
//

#import "UITextField+YJCategory.h"
#import "NSObject+YJRuntimeSwizzling.h"
#import "NSArray+YJCollection.h"

@implementation UITextField (YJCategory)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self swizzleInstanceMethodForSelector:@selector(layoutSubviews) toSelector:@selector(yj_textFieldLayoutSubviews)];
        [self swizzleInstanceMethodForSelector:@selector(removeFromSuperview) toSelector:@selector(yj_textFieldRemoveFromSuperview)];
    });
}

#pragma mark - modifying life cycle

- (void)yj_textFieldLayoutSubviews {
    [self yj_textFieldLayoutSubviews];
    
    NSArray *taps = [self.superview.gestureRecognizers arrayByFilteringWithCondition:^BOOL(__kindof UIGestureRecognizer * _Nonnull obj) { return [obj isKindOfClass:[UITapGestureRecognizer class]]; }];
    
    if (!taps.count) {
        UITapGestureRecognizer *dismissTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(yj_dismissTextField)];
        [self.superview addGestureRecognizer:dismissTap];
    } else {
        UITapGestureRecognizer *tap = taps.lastObject;
        [tap removeTarget:self action:@selector(yj_dismissTextField)];
        [tap addTarget:self action:@selector(yj_dismissTextField)];
    }
}

- (void)yj_textFieldRemoveFromSuperview {
    for (UITapGestureRecognizer *tap in self.superview.gestureRecognizers) {
        [tap removeTarget:self action:@selector(yj_dismissTextField)];
    }
    [self yj_textFieldRemoveFromSuperview];
}

- (void)yj_dismissTextField {
    [self resignFirstResponder];
}

@end
