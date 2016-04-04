//
//  NSObject+YJCategory_KVO.m
//  YJKit
//
//  Created by huang-kun on 16/4/3.
//  Copyright © 2016年 huang-kun. All rights reserved.
//

#import <objc/runtime.h>
#import "NSObject+YJCategory_KVO.h"

static void *YJKVOAssociatedObserversKey = &YJKVOAssociatedObserversKey;

@interface _YJKVOObserver : NSObject
@property (nonatomic, copy) void(^changeHandler)(id object, id oldValue, id newValue);
- (instancetype)initWithChangeHandler:(void(^)(id object, id oldValue, id newValue))changeHandler;
@end

@implementation _YJKVOObserver

- (instancetype)initWithChangeHandler:(void (^)(id, id, id))changeHandler {
    self = [super init];
    if (self) _changeHandler = [changeHandler copy];
    return self;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    id oldValue = change[NSKeyValueChangeOldKey];
    id newValue = change[NSKeyValueChangeNewKey];
    self.changeHandler(object, oldValue, newValue);
}

@end

@interface NSObject ()
@property (nonatomic, strong) NSMutableDictionary <NSString *, NSMutableSet <_YJKVOObserver *> *> *yj_observers;
@end

@implementation NSObject (YJCategory_KVO)

- (void)setYj_observers:(NSMutableDictionary<NSString *,NSMutableSet<_YJKVOObserver *> *> *)yj_observers {
    objc_setAssociatedObject(self, YJKVOAssociatedObserversKey, yj_observers, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSMutableDictionary<NSString *,NSMutableSet<_YJKVOObserver *> *> *)yj_observers {
    NSMutableDictionary *observers = objc_getAssociatedObject(self, YJKVOAssociatedObserversKey);
    if (!observers) {
        observers = [NSMutableDictionary new];
        [self setYj_observers:observers];
    }
    return observers;
}

- (void)addObserverForKeyPath:(NSString *)keyPath valueChangeHandler:(void (^)(id, id, id))changeHandler {
    _YJKVOObserver *observer = [[_YJKVOObserver alloc] initWithChangeHandler:changeHandler];
    NSMutableSet *observersForKeyPath = self.yj_observers[keyPath];
    if (!observersForKeyPath) {
        observersForKeyPath = [NSMutableSet new];
        self.yj_observers[keyPath] = observersForKeyPath;
    }
    [observersForKeyPath addObject:observer];
    [self addObserver:observer forKeyPath:keyPath options:NSKeyValueObservingOptionOld | NSKeyValueObservingOptionNew context:NULL];
}

- (void)removeObserverForKeyPath:(NSString *)keyPath {
    NSMutableSet <_YJKVOObserver *> *observersForKeyPath = self.yj_observers[keyPath];
    [observersForKeyPath enumerateObjectsUsingBlock:^(_YJKVOObserver * _Nonnull observer, BOOL * _Nonnull stop) {
        [self removeObserver:observer forKeyPath:keyPath];
    }];
    [self.yj_observers removeObjectForKey:keyPath];
}

- (void)removeAllObservedKeyPaths {
    NSMutableDictionary *observers = self.yj_observers;
    [observers enumerateKeysAndObjectsUsingBlock:^(id _Nonnull keyPath, NSMutableSet *  _Nonnull observersForKeyPath, BOOL * _Nonnull stop) {
        [observersForKeyPath enumerateObjectsUsingBlock:^(id  _Nonnull observer, BOOL * _Nonnull stop) {
            [self removeObserver:observer forKeyPath:keyPath];
        }];
    }];
    [observers removeAllObjects];
}

@end
