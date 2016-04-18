//
//  UIBarButtonItem+YJCategory.m
//  YJKit
//
//  Created by huang-kun on 16/4/1.
//  Copyright © 2016年 huang-kun. All rights reserved.
//

#import <objc/runtime.h>
#import "UIBarButtonItem+YJCategory.h"
#import "YJDebugMacros.h"

static const void *YJBarButtonItemAssociatedTargetKey = &YJBarButtonItemAssociatedTargetKey;

@interface _YJBarButtonItemTarget : NSObject
@property (nonatomic, copy) void(^actionHandler)(UIBarButtonItem *);
- (instancetype)initWithActionHandler:(void(^)(UIBarButtonItem *barButtonItem))actionHandler;
- (void)invokeActionFromBarButtonItem:(UIBarButtonItem *)barButtonItem;
@end

@implementation _YJBarButtonItemTarget

- (instancetype)initWithActionHandler:(void (^)(UIBarButtonItem *))actionHandler {
    self = [super init];
    if (self) _actionHandler = [actionHandler copy];
    return self;
}

- (void)invokeActionFromBarButtonItem:(UIBarButtonItem *)barButtonItem {
    if (self.actionHandler) self.actionHandler(barButtonItem);
}

#if YJ_DEBUG
- (void)dealloc {
    NSLog(@"%@ dealloc", self.class);
}
#endif

@end

@interface UIBarButtonItem ()
@property (nonatomic, strong) _YJBarButtonItemTarget *yj_target;
@end

@implementation UIBarButtonItem (YJCategory)

- (void)setYj_target:(_YJBarButtonItemTarget *)yj_target {
    objc_setAssociatedObject(self, YJBarButtonItemAssociatedTargetKey, yj_target, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (_YJBarButtonItemTarget *)yj_target {
    return objc_getAssociatedObject(self, YJBarButtonItemAssociatedTargetKey);
}

- (instancetype)initWithTitle:(nullable NSString *)title
                        style:(UIBarButtonItemStyle)style
                  actionHandler:(nullable void(^)(UIBarButtonItem *sender))actionHandler {
    self.yj_target = [[_YJBarButtonItemTarget alloc] initWithActionHandler:actionHandler];
    return [self initWithTitle:title style:style target:self.yj_target action:@selector(invokeActionFromBarButtonItem:)];
}

- (void)setActionHandler:(nullable YJBarButtonItemActionHandler)actionHandler {
    self.yj_target = [[_YJBarButtonItemTarget alloc] initWithActionHandler:actionHandler];
}

- (nullable YJBarButtonItemActionHandler)actionHandler {
    return self.yj_target.actionHandler;
}

@end
