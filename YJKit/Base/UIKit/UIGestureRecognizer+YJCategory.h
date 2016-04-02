//
//  UIGestureRecognizer+YJCategory.h
//  YJKit
//
//  Created by Jack Huang on 16/4/1.
//  Copyright © 2016年 Jack Huang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIGestureRecognizer (YJCategory)

- (instancetype)initWithActionBlock:(nullable void(^)(UIGestureRecognizer *gestureRecognizer))actionBlock;

- (void)addActionBlock:(void(^)(UIGestureRecognizer *gestureRecognizer))actionBlock;

@end

NS_ASSUME_NONNULL_END