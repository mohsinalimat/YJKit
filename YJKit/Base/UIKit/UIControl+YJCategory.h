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
 *
 *  @param events      A bitmask specifying the control events for which the action message is sent. See Control Events for bitmask constants.
 *  @param actionHandler The action code which can be executed for specified control events.
 *
 *  @remark The actionHandler will retain the objects that inside of block when the control (receiver) is alive.
 */
- (void)addActionForControlEvents:(UIControlEvents)events actionHandler:(void(^)(UIControl *sender))actionHandler;

@end

NS_ASSUME_NONNULL_END