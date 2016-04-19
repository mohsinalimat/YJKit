//
//  UIAlertView+YJCategory.h
//  YJKit
//
//  Created by huang-kun on 16/4/1.
//  Copyright © 2016年 huang-kun. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/**
 *  Example:
 *
 *  @code
 
 - (void)showAlertView {
     UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"title" message:@"message" cancelButtonTitle:@"cancel" otherButtonTitles:@"button1", @"button2", nil];
     [alertView setActionHandler:^(UIAlertView * _Nonnull alertView, NSInteger buttonIndex, NSString * _Nonnull buttonTitle) {
        NSLog(@"Button %@ at index %@", buttonTitle, @(buttonIndex));
     }];
     [alertView addButtonWithTitle:@"button3" actionHandler:^(UIAlertView * _Nonnull alertView, NSInteger buttonIndex, NSString * _Nonnull buttonTitle) {
        NSLog(@"New Button %@ at index %@", buttonTitle, @(buttonIndex));
     }];
     [alertView show];
 }
 
 *  @endcode
 */
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
typedef void(^YJAlertViewActionHandler)(UIAlertView *alertView, NSInteger buttonIndex, NSString *buttonTitle);
#pragma clang diagnostic pop

@interface UIAlertView (YJCategory) // First deprecated in iOS 9.0

/**
 *  Convenience method for initializing an alert view.
 *
 *  @param title             The string that appears in the receiver’s title bar.
 *  @param message           Descriptive text that provides more details than the title.
 *  @param cancelButtonTitle The title of the cancel button or nil if there is no cancel button.
 *  @param otherButtonTitles The title of another button.
 *
 *  @return Newly initialized alert view.
 */
- (instancetype)initWithTitle:(nullable NSString *)title message:(nullable NSString *)message cancelButtonTitle:(nullable NSString *)cancelButtonTitle otherButtonTitles:(nullable NSString *)otherButtonTitles, ... NS_REQUIRES_NIL_TERMINATION NS_EXTENSION_UNAVAILABLE_IOS("Use UIAlertController instead.");

/**
 *  Set the block of code to be executed when the user clicks a button on an alert view.
 *  @param actionHandler     The block of code will be executed when the user clicks a button on an alert view.
 */
- (void)setActionHandler:(YJAlertViewActionHandler)actionHandler;

/**
 *  Adds a custom button to the alert view with associated action block code.
 *
 *  @param title         The title of the new button.
 *  @param actionHandler The block of code will be executed when the user clicks this button on the alert view.
 *
 *  @return The index of the new button.
 */
- (NSInteger)addButtonWithTitle:(NSString *)title actionHandler:(YJAlertViewActionHandler)actionHandler;

@end

NS_ASSUME_NONNULL_END