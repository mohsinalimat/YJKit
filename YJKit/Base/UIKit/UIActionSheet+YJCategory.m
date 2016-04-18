//
//  UIActionSheet+YJCategory.m
//  YJKit
//
//  Created by huang-kun on 16/4/18.
//  Copyright © 2016年 huang-kun. All rights reserved.
//

#import <objc/runtime.h>
#import "UIActionSheet+YJCategory.h"
#import "_YJAlertDelegate.h"
#import "YJDebugMacros.h"

static const void *YJActionSheetAssociatedDelegateKey = &YJActionSheetAssociatedDelegateKey;

@interface UIActionSheet ()
@property (nonatomic, strong) _YJAlertDelegate *yj_delegate;
@end

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"

@implementation UIActionSheet (YJCategory)

- (void)setYj_delegate:(_YJAlertDelegate *)yj_delegate {
    objc_setAssociatedObject(self, YJActionSheetAssociatedDelegateKey, yj_delegate, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (_YJAlertDelegate *)yj_delegate {
    return objc_getAssociatedObject(self, YJActionSheetAssociatedDelegateKey);
}

- (instancetype)initWithTitle:(nullable NSString *)title cancelButtonTitle:(nullable NSString *)cancelButtonTitle destructiveButtonTitle:(nullable NSString *)destructiveButtonTitle otherButtonTitles:(nullable NSString *)otherButtonTitles, ... NS_REQUIRES_NIL_TERMINATION {
    _YJAlertDelegate *delegate = [_YJAlertDelegate alertDelegateWithType:YJAlertDelegateTypeActionSheet];
    UIActionSheet *actionSheet = [self initWithTitle:title delegate:delegate cancelButtonTitle:cancelButtonTitle destructiveButtonTitle:destructiveButtonTitle otherButtonTitles:otherButtonTitles, nil];
    if (otherButtonTitles) delegate.buttonIndexesWithTitles[@(actionSheet.firstOtherButtonIndex)] = otherButtonTitles;
    if (cancelButtonTitle) delegate.buttonIndexesWithTitles[@(actionSheet.cancelButtonIndex)] = cancelButtonTitle;
    if (destructiveButtonTitle) delegate.buttonIndexesWithTitles[@(actionSheet.destructiveButtonIndex)] = destructiveButtonTitle;
    NSString *otherButtonTitle = nil;
    va_list args;
    if (otherButtonTitles) {
        va_start(args, otherButtonTitles);
        while ((otherButtonTitle = va_arg(args, NSString *))) {
            NSInteger buttonIndex = [actionSheet addButtonWithTitle:otherButtonTitle];
            delegate.buttonIndexesWithTitles[@(buttonIndex)] = otherButtonTitle;
        }
        va_end(args);
    }
    self.yj_delegate = delegate;
    return actionSheet;
}

- (void)setActionHandler:(YJActionSheetActionHandler)actionHandler {
    if (actionHandler) self.yj_delegate.actionHandler = (YJAlertDelegateActionHandler)actionHandler;
}

- (NSInteger)addButtonWithTitle:(NSString *)title actionHandler:(YJActionSheetActionHandler)actionHandler {
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

#pragma clang diagnostic pop

@end
