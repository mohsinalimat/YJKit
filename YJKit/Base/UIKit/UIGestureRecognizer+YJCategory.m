//
//  UIGestureRecognizer+YJCategory.m
//  YJKit
//
//  Created by huang-kun on 16/4/1.
//  Copyright © 2016年 huang-kun. All rights reserved.
//

#import <objc/runtime.h>
#import "UIGestureRecognizer+YJCategory.h"
#import "YJDebugMacros.h"

static const void *YJRestureRecognizerAssociatedTargetsKey = &YJRestureRecognizerAssociatedTargetsKey;

typedef void(^YJGestureActionHandler)(UIGestureRecognizer *);

@interface _YJGestureTarget : NSObject
@property (nonatomic, copy) YJGestureActionHandler actionHandler;
@property (nonatomic, copy) NSString *actionTag;
- (instancetype)initWithActionHandler:(YJGestureActionHandler)actionHandler;
- (void)invokeGestureRecognizer:(UIGestureRecognizer *)gestureRecognizer;
@end

@implementation _YJGestureTarget

- (instancetype)initWithActionHandler:(YJGestureActionHandler)actionHandler {
    self = [super init];
    if (self) _actionHandler = [actionHandler copy];
    return self;
}

- (void)invokeGestureRecognizer:(UIGestureRecognizer *)gestureRecognizer {
    if (self.actionHandler) self.actionHandler(gestureRecognizer);
}

#if YJ_DEBUG
- (void)dealloc {
    NSLog(@"%@ dealloc", self.class);
}
#endif

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

static _YJGestureTarget * _yj_targetForUIGestureRecognizer(UIGestureRecognizer *gestureRecognizer, NSString *actionTag, YJGestureActionHandler actionHandler) {
    _YJGestureTarget *target = [[_YJGestureTarget alloc] initWithActionHandler:actionHandler];
    if (actionTag) target.actionTag = actionTag;
    NSMutableSet *targets = [gestureRecognizer yj_targets];
    [targets addObject:target];
    return target;
}

- (instancetype)initWithActionHandler:(nullable void(^)(UIGestureRecognizer *gestureRecognizer))actionHandler {
    _YJGestureTarget *target = _yj_targetForUIGestureRecognizer(self, nil, actionHandler);
    return [self initWithTarget:target action:@selector(invokeGestureRecognizer:)];
}

- (instancetype)initWithActionTaged:(NSString *)tag actionHandler:(void (^)(UIGestureRecognizer * _Nonnull))actionHandler {
    _YJGestureTarget *target = _yj_targetForUIGestureRecognizer(self, (tag.length ? tag : nil), actionHandler);
    return [self initWithTarget:target action:@selector(invokeGestureRecognizer:)];
}

- (void)addActionHandler:(void(^)(UIGestureRecognizer *gestureRecognizer))actionHandler {
    _YJGestureTarget *target = _yj_targetForUIGestureRecognizer(self, nil, actionHandler);
    [self addTarget:target action:@selector(invokeGestureRecognizer:)];
}

- (void)addActionTaged:(NSString *)tag actionHandler:(void (^)(UIGestureRecognizer * _Nonnull))actionHandler {
    _YJGestureTarget *target = _yj_targetForUIGestureRecognizer(self, (tag.length ? tag : nil), actionHandler);
    [self addTarget:target action:@selector(invokeGestureRecognizer:)];
}

- (void)setActionHandler:(void(^)(UIGestureRecognizer *gestureRecognizer))actionHandler {
    [self removeAllActions];
    [self addActionHandler:actionHandler];
}

- (void)removeActionForTag:(NSString *)tag {
    NSMutableSet <_YJGestureTarget *> *targets = [self yj_targets];
    NSMutableArray *collector = [NSMutableArray arrayWithCapacity:targets.count];
    [targets enumerateObjectsUsingBlock:^(_YJGestureTarget * _Nonnull target, BOOL * _Nonnull stop) {
        if ([target.actionTag isEqualToString:tag]) {
            [self removeTarget:target action:@selector(invokeGestureRecognizer:)];
            [collector addObject:target];
        }
    }];
    for (NSUInteger i = 0; i < collector.count; i++) {
        id target = collector[i];
        [targets removeObject:target];
    }
}

- (void)removeAllActions {
    NSMutableSet <_YJGestureTarget *> *targets = [self yj_targets];
    [targets enumerateObjectsUsingBlock:^(_YJGestureTarget * _Nonnull target, BOOL * _Nonnull stop) {
        [self removeTarget:target action:@selector(invokeGestureRecognizer:)];
    }];
    [targets removeAllObjects];
}

- (nullable NSArray *)actionTags {
    NSMutableSet <_YJGestureTarget *> *targets = [self yj_targets];
    NSMutableArray *collector = [NSMutableArray arrayWithCapacity:targets.count];
    for (_YJGestureTarget *target in targets) {
        if (target.actionTag.length) [collector addObject:target.actionTag];
    }
    return collector.count ? collector : nil;
}

@end
