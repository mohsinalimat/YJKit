//
//  UITextField+YJCategory.m
//  YJKit
//
//  Created by huang-kun on 16/5/25.
//  Copyright © 2016年 huang-kun. All rights reserved.
//

#import <objc/runtime.h>
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

#pragma mark - accessor

- (void)setAutoResignFirstResponder:(BOOL)autoResignFirstResponder {
    objc_setAssociatedObject(self, @selector(autoResignFirstResponder), @(autoResignFirstResponder), OBJC_ASSOCIATION_COPY_NONATOMIC);
    
    if (!autoResignFirstResponder) {
        [self yj_removeResignFirstResponderTapActionFromSuperview];
    }
}

- (BOOL)autoResignFirstResponder {
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}

#pragma mark - life cycle

- (void)yj_textFieldLayoutSubviews {
    [self yj_textFieldLayoutSubviews];
    
    if (self.autoResignFirstResponder) {
        NSArray *taps = [self.superview.gestureRecognizers arrayByFilteringWithCondition:^BOOL(__kindof UIGestureRecognizer * _Nonnull obj) {
            return [obj isKindOfClass:[UITapGestureRecognizer class]];
        }];
        
        if (!taps.count) {
            UITapGestureRecognizer *resignFirstResponderTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(yj_handleResignFirstResponderTap)];
            [self.superview addGestureRecognizer:resignFirstResponderTap];
        } else {
            UITapGestureRecognizer *tap = taps.lastObject;
            [tap removeTarget:self action:@selector(yj_handleResignFirstResponderTap)];
            [tap addTarget:self action:@selector(yj_handleResignFirstResponderTap)];
        }
    }
}

- (void)yj_textFieldRemoveFromSuperview {
    if (self.autoResignFirstResponder) {
        [self yj_removeResignFirstResponderTapActionFromSuperview];
    }
    [self yj_textFieldRemoveFromSuperview];
}

- (void)yj_removeResignFirstResponderTapActionFromSuperview {
    for (UIGestureRecognizer *gesture in self.superview.gestureRecognizers) {
        if ([gesture isKindOfClass:[UITapGestureRecognizer class]]) {
            [gesture removeTarget:self action:@selector(yj_handleResignFirstResponderTap)];
        }
    }
}

- (void)yj_handleResignFirstResponderTap {
    [self resignFirstResponder];
}

@end
