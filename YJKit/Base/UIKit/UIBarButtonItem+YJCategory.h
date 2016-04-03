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

- (instancetype)initWithTitle:(nullable NSString *)title
                        style:(UIBarButtonItemStyle)style
                  actionHandler:(nullable void(^)(UIBarButtonItem *barButtonItem))actionHandler;

@property (nullable, nonatomic, copy) YJBarButtonItemActionHandler actionHandler;

@end

NS_ASSUME_NONNULL_END
