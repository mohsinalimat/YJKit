//
//  NSTimer+YJCategory.h
//  YJKit
//
//  Created by huang-kun on 16/4/4.
//  Copyright © 2016年 huang-kun. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSTimer (YJCategory)

/**
 *  @brief Creates and returns a new NSTimer object and schedules it on the current run loop in the default mode.
 *  @discussion After seconds seconds have elapsed, the timer fires, executing time handler block.
 *
 *  @remark The time handler block will retain (or capture) the objects when timer is alive.
 *
 *  @param seconds      The number of seconds between firings of the timer. If seconds is less than or equal to 0.0, this method chooses the nonnegative value of 0.1 milliseconds instead.
 *  @param yesOrNo      If YES, the timer will repeatedly reschedule itself until invalidated. If NO, the timer will be invalidated after it fires.
 *  @param timerHandler The block of code will be performed when the timer fires.
 *
 *  @return A new NSTimer object, configured according to the specified parameters.
 */
+ (NSTimer *)scheduledTimerWithTimeInterval:(NSTimeInterval)seconds repeats:(BOOL)yesOrNo timerHandler:(void(^)(NSTimer *timer))timerHandler;

/**
 *  @brief Creates and returns a new NSTimer object initialized with the specified time handler block.
 *  @discussion You must add the new timer to a run loop, using addTimer:forMode:. Then, after seconds seconds have elapsed, the timer fires, executing time handler block. (If the timer is configured to repeat, there is no need to subsequently re-add the timer to the run loop.)
 *
 *  @remark The time handler block will retain (or capture) the objects when timer is alive.
 *
 *  @param seconds      The number of seconds between firings of the timer. If seconds is less than or equal to 0.0, this method chooses the nonnegative value of 0.1 milliseconds instead.
 *  @param yesOrNo      If YES, the timer will repeatedly reschedule itself until invalidated. If NO, the timer will be invalidated after it fires.
 *  @param timerHandler The block of code will be performed when the timer fires.
 *
 *  @return A new NSTimer object, configured according to the specified parameters.
 */
+ (NSTimer *)timerWithTimeInterval:(NSTimeInterval)seconds repeats:(BOOL)yesOrNo timerHandler:(void(^)(NSTimer *timer))timerHandler;

@end

NS_ASSUME_NONNULL_END
