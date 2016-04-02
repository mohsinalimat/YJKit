//
//  UIControl+YJCategory.h
//  YJKit
//
//  Created by Jack Huang on 16/4/1.
//  Copyright © 2016年 Jack Huang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIControl (YJCategory)

/**
 *  The block based action setup for replacing -[UIControl addTarget:action:forControlEvents:]
 *
 *  @param events      A bitmask specifying the control events for which the action message is sent. See Control Events for bitmask constants.
 *  @param actionBlock The action code which can be executed for specified control events.
 *
 *  @remark The actionBlock will retain the objects that inside of block when the control (receiver) is alive.
 */
- (void)addActionForControlEvents:(UIControlEvents)events actionBlock:(void(^)(UIControl *sender))actionBlock;

@end
