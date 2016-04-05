//
//  NSObject+YJCategory_KVO.m
//  YJKit
//
//  Created by huang-kun on 16/4/3.
//  Copyright © 2016年 huang-kun. All rights reserved.
//

#import <objc/runtime.h>
#import "NSObject+YJCategory_KVO.h"

static const void *YJKVOAssociatedObserversKey = &YJKVOAssociatedObserversKey;

@interface _YJKeyValueObserver : NSObject
@property (nonatomic, copy) void(^changeHandler)(id object, id oldValue, id newValue);
@property (nonatomic) BOOL shouldPerformChangeHandlerOnMainThread;
- (instancetype)initWithChangeHandler:(void(^)(id object, id oldValue, id newValue))changeHandler;
@end

@implementation _YJKeyValueObserver

- (instancetype)initWithChangeHandler:(void (^)(id, id, id))changeHandler {
    self = [super init];
    if (self) _changeHandler = [changeHandler copy];
    return self;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    if (!self.changeHandler) return;
    if (change[NSKeyValueChangeNotificationIsPriorKey]) return;
    
    void (^handleObservedObject)(id,NSDictionary*) = ^(id object, NSDictionary<NSString *,id> *change){
        id oldValue = change[NSKeyValueChangeOldKey];
        if (oldValue == [NSNull null]) oldValue = nil;
        id newValue = change[NSKeyValueChangeNewKey];
        if (newValue == [NSNull null]) newValue = nil;
        self.changeHandler(object, oldValue, newValue);
    };
    
    if (self.shouldPerformChangeHandlerOnMainThread) {
        dispatch_async(dispatch_get_main_queue(), ^{ handleObservedObject(object, change); });
    } else {
        handleObservedObject(object, change);
    }
}

//- (void)dealloc {
//    NSLog(@"%@ dealloc", self.class);
//}

@end

@interface NSObject ()
@property (nonatomic, strong) NSMutableDictionary <NSString *, NSMutableSet <_YJKeyValueObserver *> *> *yj_observers;
@end

@implementation NSObject (YJCategory_KVO)

- (void)setYj_observers:(NSMutableDictionary<NSString *,NSMutableSet<_YJKeyValueObserver *> *> *)yj_observers {
    objc_setAssociatedObject(self, YJKVOAssociatedObserversKey, yj_observers, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSMutableDictionary<NSString *,NSMutableSet<_YJKeyValueObserver *> *> *)yj_observers {
    NSMutableDictionary *observers = objc_getAssociatedObject(self, YJKVOAssociatedObserversKey);
    if (!observers) {
        observers = [NSMutableDictionary new];
        [self setYj_observers:observers];
    }
    return observers;
}

- (void)addObservedKeyPath:(NSString *)keyPath valueChangeHandler:(void (^)(id, id, id))changeHandler {
    _YJKeyValueObserver *observer = [[_YJKeyValueObserver alloc] initWithChangeHandler:changeHandler];
    NSMutableSet *observersForKeyPath = self.yj_observers[keyPath];
    if (!observersForKeyPath) {
        observersForKeyPath = [NSMutableSet new];
        self.yj_observers[keyPath] = observersForKeyPath;
    }
    [observersForKeyPath addObject:observer];
    [self addObserver:observer forKeyPath:keyPath options:NSKeyValueObservingOptionOld | NSKeyValueObservingOptionNew context:NULL];
}

- (void)addObservedKeyPath:(NSString *)keyPath valueChangeHandlerOnMainThread:(void (^)(id, id, id))changeHandler {
    _YJKeyValueObserver *observer = [[_YJKeyValueObserver alloc] initWithChangeHandler:changeHandler];
    observer.shouldPerformChangeHandlerOnMainThread = YES;
    NSMutableSet *observersForKeyPath = self.yj_observers[keyPath];
    if (!observersForKeyPath) {
        observersForKeyPath = [NSMutableSet new];
        self.yj_observers[keyPath] = observersForKeyPath;
    }
    [observersForKeyPath addObject:observer];
    [self addObserver:observer forKeyPath:keyPath options:NSKeyValueObservingOptionOld | NSKeyValueObservingOptionNew context:NULL];
}

- (void)removeObservedKeyPath:(NSString *)keyPath {
    NSMutableSet <_YJKeyValueObserver *> *observersForKeyPath = self.yj_observers[keyPath];
    if (!observersForKeyPath.count) return;
    [observersForKeyPath enumerateObjectsUsingBlock:^(_YJKeyValueObserver * _Nonnull observer, BOOL * _Nonnull stop) {
        [self removeObserver:observer forKeyPath:keyPath];
    }];
    [self.yj_observers removeObjectForKey:keyPath];
}

- (void)removeAllObservedKeyPaths {
    NSMutableDictionary *observers = self.yj_observers;
    if (!observers.count) return;
    [observers enumerateKeysAndObjectsUsingBlock:^(id _Nonnull keyPath, NSMutableSet *  _Nonnull observersForKeyPath, BOOL * _Nonnull stop) {
        [observersForKeyPath enumerateObjectsUsingBlock:^(id  _Nonnull observer, BOOL * _Nonnull stop) {
            [self removeObserver:observer forKeyPath:keyPath];
        }];
    }];
    [observers removeAllObjects];
}

@end
