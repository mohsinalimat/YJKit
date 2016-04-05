//
//  UIControl+YJCategory.h
//  YJKit
//
//  Created by huang-kun on 16/4/1.
//  Copyright © 2016年 huang-kun. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIControl (YJCategory)

/**
 *  The block based action setup for replacing -[UIControl addTarget:action:forControlEvents:]
 *  @param events           A bitmask specifying the control events for which the action message is sent. See Control Events for bitmask constants.
 *  @param actionHandler    The action block which can be executed for specified control events.
 *  @remark The actionHandler will retain the objects that inside of block when the control (receiver) is alive.
 *  @code
 [button addActionForControlEvents:UIControlEventTouchUpInside actionHandler:^(UIControl *sender) {
    UIButton *cameraButton = (UIButton *)sender;
    ...
 }];
 *  @endcode
 */
- (void)addActionForControlEvents:(UIControlEvents)events actionHandler:(void(^)(UIControl *sender))actionHandler;

/**
 *  The block based action setup for replacing -[UIControl addTarget:action:forControlEvents:]
 *  @param events           A bitmask specifying the control events for which the action message is sent. See Control Events for bitmask constants.
 *  @param tag              The tag string associated with the action block. Better be unique and descriptive.
 *  @param actionHandler    The action block which can be executed for specified control events.
 *  @remark The actionHandler will retain the objects that inside of block when the control (receiver) is alive.
 *  @code
 [button addActionForControlEvents:UIControlEventTouchUpInside tag:@"cameraButtonTapped" actionHandler:^(UIControl *sender) {
    UIButton *cameraButton = (UIButton *)sender;
    ...
 }];
 *  @endcode
 */
- (void)addActionForControlEvents:(UIControlEvents)events tag:(NSString *)tag actionHandler:(void(^)(UIControl *sender))actionHandler;

/**
 *  Removes the action block for a particular event (or events) from an internal dispatch table.
 *  @param events A bitmask specifying the control events associated with target and action. See Control Events for bitmask constants.
 */
- (void)removeActionForControlEvents:(UIControlEvents)events;

/**
 *  Removes the action block for a specified tag string from an internal dispatch table.
 *  @param events A bitmask specifying the control events associated with target and action. See Control Events for bitmask constants.
 *  @param tag    The tag string associated with the action block.
 *  @code
 [button removeActionForTag:@"cameraButtonTapped"];
 *  @endcode
 */
- (void)removeActionForTag:(NSString *)tag;

/**
 *  Removes all action blocks associated with the receiver.
 */
- (void)removeAllActions;

/**
 *  The action tags is associated with the action block.
 *  @discussion The action tag should be unique and descriptive for each specific action block.
 *  @param events A bitmask specifying the control events associated with target and action. See Control Events for bitmask constants.
 *  @return Returns the action tags is associated with the action block.
 */
- (nullable NSArray *)actionTagsForControlEvents:(UIControlEvents)events;

@end

NS_ASSUME_NONNULL_END