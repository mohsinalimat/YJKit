//
//  UIAlertView+YJCategory.m
//  YJKit
//
//  Created by huang-kun on 16/4/1.
//  Copyright © 2016年 huang-kun. All rights reserved.
//
//  Reference: http://www.cocoawithlove.com/2009/05/variable-argument-lists-in-cocoa.html

#import <objc/runtime.h>
#import "UIAlertView+YJCategory.h"
#import "_YJAlertDelegate.h"
#import "YJDebugMacros.h"

static const void *YJAlertViewAssociatedDelegateKey = &YJAlertViewAssociatedDelegateKey;

@interface UIAlertView ()
@property (nonatomic, strong) _YJAlertDelegate *yj_delegate;
@end

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"

@implementation UIAlertView (YJCategory)

- (void)setYj_delegate:(_YJAlertDelegate *)yj_delegate {
    objc_setAssociatedObject(self, YJAlertViewAssociatedDelegateKey, yj_delegate, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (_YJAlertDelegate *)yj_delegate {
    return objc_getAssociatedObject(self, YJAlertViewAssociatedDelegateKey);
}

- (instancetype)initWithTitle:(nullable NSString *)title message:(nullable NSString *)message cancelButtonTitle:(nullable NSString *)cancelButtonTitle otherButtonTitles:(nullable NSString *)otherButtonTitles, ... NS_REQUIRES_NIL_TERMINATION {
    _YJAlertDelegate *delegate = [_YJAlertDelegate alertDelegateWithType:YJAlertDelegateTypeAlertView];
    UIAlertView *alertView = [self initWithTitle:title message:message delegate:delegate cancelButtonTitle:cancelButtonTitle otherButtonTitles:otherButtonTitles, nil];
    if (otherButtonTitles) delegate.buttonIndexesWithTitles[@(alertView.firstOtherButtonIndex)] = otherButtonTitles;
    if (cancelButtonTitle) delegate.buttonIndexesWithTitles[@(alertView.cancelButtonIndex)] = cancelButtonTitle;
    NSString *otherButtonTitle = nil;
    va_list args;
    if (otherButtonTitles) {
        va_start(args, otherButtonTitles);
        while ((otherButtonTitle = va_arg(args, NSString *))) {
            NSInteger buttonIndex = [alertView addButtonWithTitle:otherButtonTitle];
            delegate.buttonIndexesWithTitles[@(buttonIndex)] = otherButtonTitle;
        }
        va_end(args);
    }
    self.yj_delegate = delegate;
    return alertView;
}

- (void)setActionHandler:(YJAlertViewActionHandler)actionHandler {
    if (actionHandler) self.yj_delegate.actionHandler = (YJAlertDelegateActionHandler)actionHandler;
}

- (NSInteger)addButtonWithTitle:(NSString *)title actionHandler:(YJAlertViewActionHandler)actionHandler {
    NSInteger buttonIndex = [self addButtonWithTitle:title];
    self.yj_delegate.buttonIndexesWithTitles[@(buttonIndex)] = title;
    self.yj_delegate.addedButtonActionHandlers[@(buttonIndex)] = [actionHandler copy];
    return buttonIndex;
}

#if YJ_DEBUG
- (void)dealloc {
    NSLog(@"%@ dealloc", self.class);
}
#endif

@end

#pragma clang diagnostic pop
