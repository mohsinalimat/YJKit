//
//  UIBarButtonItem+YJCategory.m
//  YJKit
//
//  Created by huang-kun on 16/4/1.
//  Copyright © 2016年 huang-kun. All rights reserved.
//

#import <objc/runtime.h>
#import "UIBarButtonItem+YJCategory.h"

static void *YJBarButtonItemAssociatedTargetKey = &YJBarButtonItemAssociatedTargetKey;

@interface _YJBarButtonItemTarget : NSObject
@property (nonatomic, copy) void(^actionBlock)(UIBarButtonItem *);
- (instancetype)initWithActionBlock:(void(^)(UIBarButtonItem *barButtonItem))actionBlock;
- (void)yj_performActionFromBarButtonItem:(UIBarButtonItem *)barButtonItem;
@end

@implementation _YJBarButtonItemTarget

- (instancetype)initWithActionBlock:(void (^)(UIBarButtonItem *))actionBlock {
    self = [super init];
    if (self) _actionBlock = [actionBlock copy];
    return self;
}

- (void)yj_performActionFromBarButtonItem:(UIBarButtonItem *)barButtonItem {
    if (self.actionBlock) self.actionBlock(barButtonItem);
}

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
                  actionBlock:(nullable void(^)(UIBarButtonItem *barButtonItem))actionBlock {
    self.yj_target = [[_YJBarButtonItemTarget alloc] initWithActionBlock:actionBlock];
    return [self initWithTitle:title style:style target:self.yj_target action:@selector(yj_performActionFromBarButtonItem:)];
}

- (void)setActionBlock:(nullable YJBarButtonItemActionBlock)actionBlock {
    self.yj_target = [[_YJBarButtonItemTarget alloc] initWithActionBlock:actionBlock];
}

- (nullable YJBarButtonItemActionBlock)actionBlock {
    return self.yj_target.actionBlock;
}

@end
