//
//  YJMemoryCache.h
//  YJKit
//
//  Created by huang-kun on 16/3/20.
//  Copyright © 2016年 huang-kun. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 *  set object into memory  -   memoCache[@"key"] = object
 *  get object from memory  -   object = memoCache[@"key"]
 */
@interface YJMemoryCache <__covariant KeyType, __covariant ObjectType> : NSObject

+ (instancetype)defaultMemoryCache;

- (void)setObject:(ObjectType)anObject forKey:(KeyType <NSCopying>)aKey;
- (nullable ObjectType)objectForKey:(KeyType)aKey;

- (void)setObject:(nullable ObjectType)obj forKeyedSubscript:(KeyType <NSCopying>)key;
- (nullable ObjectType)objectForKeyedSubscript:(KeyType)key;

- (void)removeAllObjects;

@end

NS_ASSUME_NONNULL_END