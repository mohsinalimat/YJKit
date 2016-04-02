//
//  UIControl+YJCategory.m
//  YJKit
//
//  Created by Jack Huang on 16/4/1.
//  Copyright © 2016年 Jack Huang. All rights reserved.
//
//  Reference: https://github.com/lavoy/ALActionBlocks 

#import <objc/runtime.h>
#import "UIControl+YJCategory.h"

static void *YJControlAssociatedTargetsKey = &YJControlAssociatedTargetsKey;

@interface _YJControlTarget : NSObject
@property (nonatomic, copy) void(^actionBlock)(UIControl *);
@property (nonatomic) UIControlEvents events;
- (instancetype)initWithControlEvents:(UIControlEvents)events actionBlock:(void(^)(UIControl *sender))actionBlock;
- (void)yj_performActionFromControl:(UIControl *)sender;
@end

@implementation _YJControlTarget

- (instancetype)initWithControlEvents:(UIControlEvents)events actionBlock:(void(^)(UIControl *sender))actionBlock {
    self = [super init];
    if (self) {
        _events = events;
        _actionBlock = [actionBlock copy];
    }
    return self;
}

- (void)yj_performActionFromControl:(UIControl *)sender {
    if (self.actionBlock) self.actionBlock(sender);
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

- (void)addActionForControlEvents:(UIControlEvents)events actionBlock:(void(^)(UIControl *sender))actionBlock {
    _YJControlTarget *target = [[_YJControlTarget alloc] initWithControlEvents:events actionBlock:actionBlock];
    [self.yj_targets addObject:target];
    [self addTarget:target action:@selector(yj_performActionFromControl:) forControlEvents:events];
}

@end
