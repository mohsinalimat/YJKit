//
//  UIBarButtonItem+YJCategory.h
//  YJKit
//
//  Created by Jack Huang on 16/4/1.
//  Copyright © 2016年 Jack Huang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^YJBarButtonItemActionBlock)(UIBarButtonItem *barButtonItem);

@interface UIBarButtonItem (YJCategory)

- (instancetype)initWithTitle:(nullable NSString *)title
                        style:(UIBarButtonItemStyle)style
                  actionBlock:(nullable void(^)(UIBarButtonItem *barButtonItem))actionBlock;

@property (nullable, nonatomic, copy) YJBarButtonItemActionBlock actionBlock;

@end

NS_ASSUME_NONNULL_END
