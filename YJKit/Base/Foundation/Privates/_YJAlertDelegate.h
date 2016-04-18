//
//  _YJAlertDelegate.h
//  YJKit
//
//  Created by huang-kun on 16/4/18.
//  Copyright © 2016年 huang-kun. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, YJAlertDelegateType) {
    YJAlertDelegateTypeAlertView,
    YJAlertDelegateTypeActionSheet,
};

typedef void(^YJAlertDelegateActionHandler)(UIView *alertObject, NSInteger buttonIndex, NSString *buttonTitle);


@interface _YJAlertDelegate : NSObject <UIAlertViewDelegate, UIActionSheetDelegate>

@property (nonatomic, copy) YJAlertDelegateActionHandler actionHandler; // initialized action block code
@property (nonatomic, strong) NSMutableDictionary <NSNumber *, YJAlertDelegateActionHandler> *addedButtonActionHandlers; // new added action blocks
@property (nonatomic, strong) NSMutableDictionary <NSNumber *, NSString *> *buttonIndexesWithTitles; // { buttonIndex : buttonTitle }

+ (instancetype)alertDelegateWithType:(YJAlertDelegateType)type;

@end