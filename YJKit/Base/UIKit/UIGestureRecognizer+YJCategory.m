//
//  UIGestureRecognizer+YJCategory.m
//  YJKit
//
//  Created by huang-kun on 16/4/1.
//  Copyright © 2016年 huang-kun. All rights reserved.
//

#import <objc/runtime.h>
#import "UIGestureRecognizer+YJCategory.h"

static const void *YJRestureRecognizerAssociatedTargetsKey = &YJRestureRecognizerAssociatedTargetsKey;

@interface _YJGestureTarget : NSObject
@property (nonatomic, copy) void(^actionHandler)(UIGestureRecognizer *);
- (instancetype)initWithActionHandler:(void(^)(UIGestureRecognizer *))actionHandler;
- (void)invokeGestureRecognizer:(UIGestureRecognizer *)gestureRecognizer;
@end

@implementation _YJGestureTarget

- (instancetype)initWithActionHandler:(void (^)(UIGestureRecognizer *))actionHandler {
    self = [super init];
    if (self) _actionHandler = [actionHandler copy];
    return self;
}

- (void)invokeGestureRecognizer:(UIGestureRecognizer *)gestureRecognizer {
    if (self.actionHandler) self.actionHandler(gestureRecognizer);
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

- (instancetype)initWithActionHandler:(nullable void(^)(UIGestureRecognizer *gestureRecognizer))actionHandler {
    _YJGestureTarget *target = [[_YJGestureTarget alloc] initWithActionHandler:actionHandler];
    [self.yj_targets addObject:target];
    return [self initWithTarget:target action:@selector(invokeGestureRecognizer:)];
}

- (void)addActionHandler:(void(^)(UIGestureRecognizer *gestureRecognizer))actionHandler {
    _YJGestureTarget *target = [[_YJGestureTarget alloc] initWithActionHandler:actionHandler];
    [self.yj_targets addObject:target];
    [self addTarget:target action:@selector(invokeGestureRecognizer:)];
}

@end
