//
//  UIGestureRecognizer+YJCategory.h
//  YJKit
//
//  Created by huang-kun on 16/4/1.
//  Copyright © 2016年 huang-kun. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIGestureRecognizer (YJCategory)

- (instancetype)initWithActionHandler:(nullable void(^)(UIGestureRecognizer *gestureRecognizer))actionHandler;

- (void)addActionHandler:(void(^)(UIGestureRecognizer *gestureRecognizer))actionHandler;

@end

NS_ASSUME_NONNULL_END