//
//  NSTimer+YJCategory.h
//  YJKit
//
//  Created by huang-kun on 16/4/4.
//  Copyright © 2016年 huang-kun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSTimer (YJCategory)

+ (NSTimer *)scheduledTimerWithTimeInterval:(NSTimeInterval)ti repeats:(BOOL)yesOrNo timerHandler:(void(^)(NSTimer *timer))timerHandler;

+ (NSTimer *)timerWithTimeInterval:(NSTimeInterval)ti repeats:(BOOL)yesOrNo timerHandler:(void(^)(NSTimer *timer))timerHandler;

@end
