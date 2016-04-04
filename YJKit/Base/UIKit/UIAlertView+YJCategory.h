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

/**
 *  Convenience method for initializing an alert view.
 *  @remark The method only support maximum of 5 otherButtonTitles.
 *
 *  @param title             The string that appears in the receiver’s title bar.
 *  @param message           Descriptive text that provides more details than the title.
 *  @param actionHandler     The block of code will be executed when the user clicks a button on an alert view.
 *  @param cancelButtonTitle The title of the cancel button or nil if there is no cancel button.
 *  @param otherButtonTitles The title of another button.
 *
 *  @return Newly initialized alert view.
 */
- (instancetype)initWithTitle:(nullable NSString *)title message:(nullable NSString *)message actionHandler:(nullable void(^)(NSInteger buttonIndex))actionHandler cancelButtonTitle:(nullable NSString *)cancelButtonTitle otherButtonTitles:(nullable NSString *)otherButtonTitles, ... NS_REQUIRES_NIL_TERMINATION;

/**
 *  Convenience method for initializing an alert view.
 *  @remark The method only support maximum of 5 otherButtonTitles.
 *
 *  @param title             The string that appears in the receiver’s title bar.
 *  @param message           Descriptive text that provides more details than the title.
 *  @param cancelButtonTitle The title of the cancel button or nil if there is no cancel button.
 *  @param otherButtonTitles The title of another button.
 *
 *  @return Newly initialized alert view.
 */
- (instancetype)initWithTitle:(nullable NSString *)title message:(nullable NSString *)message cancelButtonTitle:(nullable NSString *)cancelButtonTitle otherButtonTitles:(nullable NSString *)otherButtonTitles, ... NS_REQUIRES_NIL_TERMINATION;

/**
 *  Set the block of code to be executed when the user clicks a button on an alert view.
 *  @param actionHandler     The block of code will be executed when the user clicks a button on an alert view.
 */
- (void)setActionHandler:(void(^)(NSInteger buttonIndex))actionHandler;

@end

NS_ASSUME_NONNULL_END