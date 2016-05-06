//
//  UIBarButtonItem+YJCategory.h
//  YJKit
//
//  Created by huang-kun on 16/4/1.
//  Copyright © 2016年 huang-kun. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^YJBarButtonItemActionHandler)(UIBarButtonItem *barButtonItem);

@interface UIBarButtonItem (YJCategory)

/**
 *  Initializes a new item using the specified title and other properties.
 *
 *  @param title         The item’s title. If nil a title is not displayed.
 *  @param style         The style of the item. One of the constants defined in UIBarButtonItemStyle.
 *  @param actionHandler The action block will be performed when this item is selected.
 *
 *  @return Newly initialized item with the specified properties.
 */
- (instancetype)initWithTitle:(nullable NSString *)title
                        style:(UIBarButtonItemStyle)style
                actionHandler:(nullable void(^)(UIBarButtonItem *sender))actionHandler;

/**
 *  The action block defining a block of code will be executed when the user taps this bar button item.
 */
@property (nullable, nonatomic, copy) YJBarButtonItemActionHandler actionHandler;

@end

NS_ASSUME_NONNULL_END
