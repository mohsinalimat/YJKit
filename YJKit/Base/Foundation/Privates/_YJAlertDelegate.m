//
//  _YJAlertDelegate.m
//  YJKit
//
//  Created by huang-kun on 16/4/18.
//  Copyright © 2016年 huang-kun. All rights reserved.
//

#import "_YJAlertDelegate.h"
#import "YJDebugMacros.h"

/* ------------------------------------------------------------------------------------------------------------ */

@interface _YJAlertViewDelegate : _YJAlertDelegate @end
@implementation _YJAlertViewDelegate @end

/* ------------------------------------------------------------------------------------------------------------ */

@interface _YJActionSheetDelegate : _YJAlertDelegate @end
@implementation _YJActionSheetDelegate @end

/* ------------------------------------------------------------------------------------------------------------ */

@implementation _YJAlertDelegate

+ (instancetype)alertDelegateWithType:(YJAlertDelegateType)type {
    _YJAlertDelegate *delegate = nil;
    switch (type) {
        case YJAlertDelegateTypeAlertView: delegate = [[_YJAlertViewDelegate alloc] init]; break;
        case YJAlertDelegateTypeActionSheet: delegate = [[_YJActionSheetDelegate alloc] init]; break;
    }
    return delegate;
}

- (instancetype)init {
    self = [super init];
    if (self) _buttonIndexesWithTitles = [NSMutableDictionary new];
    return self;
}

- (NSMutableDictionary *)addedButtonActionHandlers {
    if (!_addedButtonActionHandlers) _addedButtonActionHandlers = [NSMutableDictionary new];
    return _addedButtonActionHandlers;
}

#pragma mark - delegate implementations

void _yj_performActionHandlerForAlertDelegate(_YJAlertDelegate *alertDelegate, UIView *alertObject, NSInteger buttonIndex) {
    NSString *otherButtonTitle = alertDelegate.buttonIndexesWithTitles[@(buttonIndex)];
    YJAlertDelegateActionHandler actionHandler = alertDelegate.addedButtonActionHandlers[@(buttonIndex)] ?: alertDelegate.actionHandler;
    if (actionHandler) actionHandler(alertObject, buttonIndex, otherButtonTitle);
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    _yj_performActionHandlerForAlertDelegate(self, alertView, buttonIndex);
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    _yj_performActionHandlerForAlertDelegate(self, actionSheet, buttonIndex);
}

#if YJ_DEBUG
- (void)dealloc {
    NSLog(@"%@ dealloc", self.class);
}
#endif

@end