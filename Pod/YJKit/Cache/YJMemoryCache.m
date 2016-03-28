//
//  YJMemoryCache.m
//  YJKit
//
//  Created by Jack Huang on 16/3/20.
//  Copyright © 2016年 Jack Huang. All rights reserved.
//

#import <UIKit/UIApplication.h>
#import "YJMemoryCache.h"

typedef id ObjectType;
typedef id KeyType;

@interface YJMemoryCache () {
    @package
    NSMutableDictionary *_cache;
}
@end

@implementation YJMemoryCache

#pragma mark - init & dealloc

- (instancetype)init {
    self = [super init];
    if (self) {
        _cache = [[NSMutableDictionary alloc] init];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleMemoryWarning) name:UIApplicationDidReceiveMemoryWarningNotification object:[UIApplication sharedApplication]];
    }
    return self;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

+ (instancetype)defaultMemoryCache {
    static YJMemoryCache *memo;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        memo = [[YJMemoryCache alloc] init];
    });
    return memo;
}

#pragma mark - public api

- (void)setObject:(ObjectType)anObject forKey:(KeyType <NSCopying>)aKey {
    _cache[aKey] = anObject;
}

- (nullable ObjectType)objectForKey:(KeyType)aKey {
    return _cache[aKey];
}

- (nullable ObjectType)objectForKeyedSubscript:(KeyType)key {
    return _cache[key];
}

- (void)setObject:(nullable ObjectType)obj forKeyedSubscript:(KeyType <NSCopying>)key {
    _cache[key] = obj;
}

- (void)removeAllObjects {
    [_cache removeAllObjects];
}

#pragma mark - notification

- (void)handleMemoryWarning {
    [_cache removeAllObjects];
}

#pragma mark - debug

- (NSString *)debugDescription {
    return [NSString stringWithFormat:@"%@", _cache];
}

@end
