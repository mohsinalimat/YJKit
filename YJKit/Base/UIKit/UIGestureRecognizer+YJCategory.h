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

/**
 *  Initializes an allocated gesture-recognizer object with action block.
 *  @param actionHandler The block of code will be executed when the gesture is recognized.
 *  @return An initialized instance of a concrete UIGestureRecognizer subclass or nil if an error occurred in the attempt to initialize the object.
 */
- (instancetype)initWithActionHandler:(nullable void(^)(UIGestureRecognizer *gestureRecognizer))actionHandler;

/**
 *  Adds an action block to a gesture-recognizer object.
 *  @discussion You may call this method multiple times to specify multiple action handler blocks.
 *  @param actionHandler The block of code will be executed when the gesture is recognized.
 */
- (void)addActionHandler:(void(^)(UIGestureRecognizer *gestureRecognizer))actionHandler;

@end

NS_ASSUME_NONNULL_END