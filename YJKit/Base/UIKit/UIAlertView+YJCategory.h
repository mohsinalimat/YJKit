//
//  UIAlertView+YJCategory.h
//  YJKit
//
//  Created by huang-kun on 16/4/1.
//  Copyright © 2016年 huang-kun. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIAlertView (YJCategory)

- (instancetype)initWithTitle:(nullable NSString *)title message:(nullable NSString *)message actionBlock:(nullable void(^)(NSInteger buttonIndex))actionBlock cancelButtonTitle:(nullable NSString *)cancelButtonTitle otherButtonTitles:(nullable NSString *)otherButtonTitles, ... NS_REQUIRES_NIL_TERMINATION;

- (instancetype)initWithTitle:(nullable NSString *)title message:(nullable NSString *)message cancelButtonTitle:(nullable NSString *)cancelButtonTitle otherButtonTitles:(nullable NSString *)otherButtonTitles, ... NS_REQUIRES_NIL_TERMINATION;

- (void)setActionBlock:(void(^)(NSInteger buttonIndex))actionBlock;

@end

NS_ASSUME_NONNULL_END