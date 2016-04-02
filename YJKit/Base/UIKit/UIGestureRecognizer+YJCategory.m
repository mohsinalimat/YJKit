//
//  UIGestureRecognizer+YJCategory.m
//  YJKit
//
//  Created by huang-kun on 16/4/1.
//  Copyright © 2016年 huang-kun. All rights reserved.
//

#import <objc/runtime.h>
#import "UIGestureRecognizer+YJCategory.h"

static void *YJRestureRecognizerAssociatedTargetsKey = &YJRestureRecognizerAssociatedTargetsKey;

@interface _YJGestureTarget : NSObject
@property (nonatomic, copy) void(^actionBlock)(UIGestureRecognizer *);
- (instancetype)initWithActionBlock:(void(^)(UIGestureRecognizer *))actionBlock;
- (void)yj_handleGestureRecognizer:(UIGestureRecognizer *)gestureRecognizer;
@end

@implementation _YJGestureTarget

- (instancetype)initWithActionBlock:(void (^)(UIGestureRecognizer *))actionBlock {
    self = [super init];
    if (self) _actionBlock = [actionBlock copy];
    return self;
}

- (void)yj_handleGestureRecognizer:(UIGestureRecognizer *)gestureRecognizer {
    if (self.actionBlock) self.actionBlock(gestureRecognizer);
}

@end

@interface UIGestureRecognizer ()
@property (nonatomic, strong) NSMutableSet *yj_targets;
@end

@implementation UIGestureRecognizer (YJCategory)

- (void)setYj_targets:(NSMutableSet *)yj_targets {
    objc_setAssociatedObject(self, YJRestureRecognizerAssociatedTargetsKey, yj_targets, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSMutableSet *)yj_targets {
    NSMutableSet *targets = objc_getAssociatedObject(self, YJRestureRecognizerAssociatedTargetsKey);
    if (!targets) {
        targets = [NSMutableSet new];
        [self setYj_targets:targets];
    }
    return targets;
}

- (instancetype)initWithActionBlock:(nullable void(^)(UIGestureRecognizer *gestureRecognizer))actionBlock {
    _YJGestureTarget *target = [[_YJGestureTarget alloc] initWithActionBlock:actionBlock];
    [self.yj_targets addObject:target];
    return [self initWithTarget:target action:@selector(yj_handleGestureRecognizer:)];
}

- (void)addActionBlock:(void(^)(UIGestureRecognizer *gestureRecognizer))actionBlock {
    _YJGestureTarget *target = [[_YJGestureTarget alloc] initWithActionBlock:actionBlock];
    [self.yj_targets addObject:target];
    [self addTarget:target action:@selector(yj_handleGestureRecognizer:)];
}

@end
