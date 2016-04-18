//
//  UIActionSheet+YJCategory.h
//  YJKit
//
//  Created by huang-kun on 16/4/18.
//  Copyright © 2016年 huang-kun. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/**
 * Example:
 * 
 * @code
 
 // In the controller implementation file
 
 - (void)viewDidLoad {
     [super viewDidLoad];

     @weakify(self)
 
     UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"title" cancelButtonTitle:@"cancel" destructiveButtonTitle:@"destructive" otherButtonTitles:@"b1",@"b2",@"b3", nil];
     [actionSheet setActionHandler:^(UIActionSheet * _Nonnull actionSheet, NSInteger buttonIndex, NSString * _Nonnull buttonTitle) {
        NSLog(@"%d, %@", buttonIndex, buttonTitle);
     }];
     [actionSheet addButtonWithTitle:@"b4" actionHandler:^(UIActionSheet * _Nonnull actionSheet, NSInteger buttonIndex, NSString * _Nonnull buttonTitle) {
        NSLog(@"new %d, %@", buttonIndex, buttonTitle);
     }];
     [actionSheet addButtonWithTitle:@"b5" actionHandler:^(UIActionSheet * _Nonnull actionSheet, NSInteger buttonIndex, NSString * _Nonnull buttonTitle) {
        @strongify(self)
        NSLog(@"%@ %@ new %d, %@", self, actionSheet, buttonIndex, buttonTitle);
     }];
     [actionSheet showInView:self.view];
 }
 
 * @endcode
 */

typedef void(^YJActionSheetActionHandler)(UIActionSheet *actionSheet, NSInteger buttonIndex, NSString *buttonTitle);

@interface UIActionSheet (YJCategory)

/**
 *  Convenience method for initializing an action sheet.
 *
 *  @param title                    The string that appears in the receiver’s title bar.
 *  @param message                  Descriptive text that provides more details than the title.
 *  @param cancelButtonTitle        The title of the cancel button or nil if there is no cancel button. The buttonIndex can be retrieved from cancelButtonIndex property.
 *  @param destructiveButtonTitle   The title of the destructive button or nil. The buttonIndex can be retrieved from destructiveButtonIndex property.
 *  @param otherButtonTitles        The title of another button.
 *
 *  @return Newly initialized action sheet.
 */
- (instancetype)initWithTitle:(nullable NSString *)title cancelButtonTitle:(nullable NSString *)cancelButtonTitle destructiveButtonTitle:(nullable NSString *)destructiveButtonTitle otherButtonTitles:(nullable NSString *)otherButtonTitles, ... NS_REQUIRES_NIL_TERMINATION NS_EXTENSION_UNAVAILABLE_IOS("Use UIAlertController instead.");

/**
 *  Set the block of code to be executed when the user clicks a button on an action sheet.
 *
 *  @param actionHandler The block of code will be executed when the user clicks a button on an action sheet.
 */
- (void)setActionHandler:(YJActionSheetActionHandler)actionHandler;

/**
 *  Adds a custom button to the action sheet with associated action block code.
 *
 *  @param title         The title of the new button.
 *  @param actionHandler The block of code will be executed when the user clicks this button on the action sheet.
 *
 *  @return The index of the new button.
 */
- (NSInteger)addButtonWithTitle:(NSString *)title actionHandler:(YJActionSheetActionHandler)actionHandler;

@end

NS_ASSUME_NONNULL_END