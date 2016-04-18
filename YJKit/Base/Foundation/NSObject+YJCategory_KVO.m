//
//  NSObject+YJCategory_KVO.m
//  YJKit
//
//  Created by huang-kun on 16/4/3.
//  Copyright © 2016年 huang-kun. All rights reserved.
//

#import <objc/runtime.h>
#import "NSObject+YJCategory_KVO.h"
#import "YJDebugMacros.h"

static const void *YJKVOAssociatedObserversKey = &YJKVOAssociatedObserversKey;

typedef void(^YJKVOChangeHandler)(id object, id oldValue, id newValue);
typedef void(^YJKVOSetupHandler)(id object, id newValue);

@interface _YJKeyValueObserver : NSObject
@property (nonatomic, copy) YJKVOChangeHandler changeHandler;
@property (nonatomic, copy) YJKVOSetupHandler setupHandler;
@property (nonatomic) BOOL shouldPerformHandlerOnMainThread;
@end

@implementation _YJKeyValueObserver

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    if (change[NSKeyValueChangeNotificationIsPriorKey]) return;

    void (^handleSetupForObject)(id,NSDictionary*) = ^(id object, NSDictionary<NSString *,id> *change){
        if (!self.setupHandler) return;
        id newValue = change[NSKeyValueChangeNewKey];
        if (newValue == [NSNull null]) newValue = nil;
        self.setupHandler(object, newValue);
    };
    
    void (^handleChangesForObject)(id,NSDictionary*) = ^(id object, NSDictionary<NSString *,id> *change){
        if (!self.changeHandler) return;
        id oldValue = change[NSKeyValueChangeOldKey];
        if (oldValue == [NSNull null]) oldValue = nil;
        id newValue = change[NSKeyValueChangeNewKey];
        if (newValue == [NSNull null]) newValue = nil;
        self.changeHandler(object, oldValue, newValue);
    };
    
    if (self.shouldPerformHandlerOnMainThread) {
        dispatch_async(dispatch_get_main_queue(), ^{
            handleSetupForObject(object, change);
            handleChangesForObject(object, change);
        });
    } else {
        handleSetupForObject(object, change);
        handleChangesForObject(object, change);
    }
}

#if YJ_DEBUG
- (void)dealloc {
    NSLog(@"%@ dealloc", self.class);
}
#endif

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

static void _yj_registerKVOForObject(NSObject *object, NSString *keyPath, NSKeyValueObservingOptions options, BOOL callbackOnMainThread, YJKVOSetupHandler setupHandler, YJKVOChangeHandler changeHandler) {
    
    _YJKeyValueObserver *observer = [[_YJKeyValueObserver alloc] init];
    if (setupHandler) observer.setupHandler = setupHandler;
    if (changeHandler) observer.changeHandler = changeHandler;
    observer.shouldPerformHandlerOnMainThread = callbackOnMainThread;
    
    NSMutableDictionary *observers = [object yj_observers];
    NSMutableSet *observersForKeyPath = observers[keyPath];
    if (!observersForKeyPath) {
        observersForKeyPath = [NSMutableSet new];
        observers[keyPath] = observersForKeyPath;
    }
    [observersForKeyPath addObject:observer];
    
    [object addObserver:observer forKeyPath:keyPath options:options context:NULL];
}

- (void)addObservedKeyPath:(NSString *)keyPath handleChanges:(void (^)(id, id, id))changeHandler {
    _yj_registerKVOForObject(self, keyPath, (NSKeyValueObservingOptionOld | NSKeyValueObservingOptionNew), NO, nil, changeHandler);
}

- (void)addObservedKeyPath:(NSString *)keyPath handleChangesOnMainThread:(void (^)(id, id, id))changeHandler {
    _yj_registerKVOForObject(self, keyPath, (NSKeyValueObservingOptionOld | NSKeyValueObservingOptionNew), YES, nil, changeHandler);
}

- (void)addObservedKeyPath:(NSString *)keyPath handleSetup:(void(^)(id, id))setupHandler {
    _yj_registerKVOForObject(self, keyPath, NSKeyValueObservingOptionInitial | NSKeyValueObservingOptionNew, NO, setupHandler, nil);
}

- (void)addObservedKeyPath:(NSString *)keyPath handleSetupOnMainThread:(void(^)(id, id))setupHandler {
    _yj_registerKVOForObject(self, keyPath, NSKeyValueObservingOptionInitial | NSKeyValueObservingOptionNew, YES, setupHandler, nil);
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
