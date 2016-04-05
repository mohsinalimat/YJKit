//
//  UIControl+YJCategory.m
//  YJKit
//
//  Created by huang-kun on 16/4/1.
//  Copyright © 2016年 huang-kun. All rights reserved.
//
//  Reference: https://github.com/lavoy/ALActionBlocks

#import <objc/runtime.h>
#import "UIControl+YJCategory.h"

static const void *YJControlAssociatedTargetsKey = &YJControlAssociatedTargetsKey;

@interface _YJControlTarget : NSObject
@property (nonatomic, copy) void(^actionHandler)(UIControl *);
@property (nonatomic) UIControlEvents events;
- (instancetype)initWithControlEvents:(UIControlEvents)events actionHandler:(void(^)(UIControl *sender))actionHandler;
- (void)invokeActionFromControl:(UIControl *)sender;
@end

@implementation _YJControlTarget

- (instancetype)initWithControlEvents:(UIControlEvents)events actionHandler:(void(^)(UIControl *sender))actionHandler {
    self = [super init];
    if (self) {
        _events = events;
        _actionHandler = [actionHandler copy];
    }
    return self;
}

- (void)invokeActionFromControl:(UIControl *)sender {
    if (self.actionHandler) self.actionHandler(sender);
}

@end

@interface UIControl ()
@property (nonatomic, strong) NSMutableSet *yj_targets;
@end

@implementation UIControl (YJCategory)

- (void)setYj_targets:(NSMutableSet *)yj_targets {
    objc_setAssociatedObject(self, YJControlAssociatedTargetsKey, yj_targets, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSMutableSet *)yj_targets {
    NSMutableSet *targets = objc_getAssociatedObject(self, YJControlAssociatedTargetsKey);
    if (!targets) {
        targets = [NSMutableSet new];
        [self setYj_targets:targets];
    }
    return targets;
}

- (void)addActionForControlEvents:(UIControlEvents)events actionHandler:(void(^)(UIControl *sender))actionHandler {
    _YJControlTarget *target = [[_YJControlTarget alloc] initWithControlEvents:events actionHandler:actionHandler];
    [self.yj_targets addObject:target];
    [self addTarget:target action:@selector(invokeActionFromControl:) forControlEvents:events];
}

@end
