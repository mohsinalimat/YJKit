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

typedef void(^YJControlActionHandler)(UIControl *);

@interface _YJControlTarget : NSObject
@property (nonatomic, copy) YJControlActionHandler actionHandler;
@property (nonatomic) UIControlEvents events;
@property (nonatomic, copy) NSString *actionTag;
- (instancetype)initWithControlEvents:(UIControlEvents)events actionHandler:(YJControlActionHandler)actionHandler;
- (void)invokeActionFromControl:(UIControl *)sender;
@end

@implementation _YJControlTarget

- (instancetype)initWithControlEvents:(UIControlEvents)events actionHandler:(YJControlActionHandler)actionHandler {
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

//- (void)dealloc {
//    NSLog(@"%@ dealloc", self.class);
//}

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

static void _yj_registerTargetActionPairForUIControl(UIControl *control, UIControlEvents events, NSString *actionTag, YJControlActionHandler actionHandler) {
    _YJControlTarget *target = [[_YJControlTarget alloc] initWithControlEvents:events actionHandler:actionHandler];
    if (actionTag) target.actionTag = actionTag;
    NSMutableSet *targets = [control yj_targets];
    [targets addObject:target];
    [control addTarget:target action:@selector(invokeActionFromControl:) forControlEvents:events];
}

- (void)addActionForControlEvents:(UIControlEvents)events actionHandler:(void(^)(UIControl *sender))actionHandler {
    _yj_registerTargetActionPairForUIControl(self, events, nil, actionHandler);
}

- (void)addActionForControlEvents:(UIControlEvents)events tag:(NSString *)tag actionHandler:(void(^)(UIControl *sender))actionHandler {
    _yj_registerTargetActionPairForUIControl(self, events, (tag.length ? tag : nil), actionHandler);
}

static void _yj_removeTargetActionPairForUIControl(UIControl *control, BOOL(^condition)(_YJControlTarget *target)) {
    NSMutableSet <_YJControlTarget *> *targets = [control yj_targets];
    NSMutableArray *collector = [NSMutableArray arrayWithCapacity:targets.count];
    [targets enumerateObjectsUsingBlock:^(_YJControlTarget * _Nonnull target, BOOL * _Nonnull stop) {
        if (condition(target)) {
            [control removeTarget:target action:@selector(invokeActionFromControl:) forControlEvents:target.events];
            [collector addObject:target];
        }
    }];
    for (NSUInteger i = 0; i < collector.count; i++) {
        [targets removeObject:collector[i]];
    }
}

- (void)removeActionForControlEvents:(UIControlEvents)events {
    _yj_removeTargetActionPairForUIControl(self, ^BOOL(_YJControlTarget *target) {
        return target.events == events ? YES : NO;
    });
}

- (void)removeActionForTag:(NSString *)tag {
    if (!tag.length) return;
    _yj_removeTargetActionPairForUIControl(self, ^BOOL(_YJControlTarget *target) {
        return [target.actionTag isEqualToString:tag] ? YES : NO;
    });
}

- (void)removeAllActions {
    NSMutableSet <_YJControlTarget *> *targets = self.yj_targets;
    [targets enumerateObjectsUsingBlock:^(_YJControlTarget * _Nonnull target, BOOL * _Nonnull stop) {
        [self removeTarget:target action:@selector(invokeActionFromControl:) forControlEvents:target.events];
    }];
    [targets removeAllObjects];
}

- (nullable NSArray *)actionTagsForControlEvents:(UIControlEvents)events {
    NSMutableSet <_YJControlTarget *> *targets = self.yj_targets;
    NSMutableArray *collector = [NSMutableArray arrayWithCapacity:targets.count];
    [targets enumerateObjectsUsingBlock:^(_YJControlTarget * _Nonnull target, BOOL * _Nonnull stop) {
        if (target.actionTag.length && target.events == events) {
            [collector addObject:target.actionTag];
        }
    }];
    return collector.count ? collector : nil;
}

@end
