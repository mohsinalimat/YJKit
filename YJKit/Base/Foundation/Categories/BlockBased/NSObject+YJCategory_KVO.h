//
//  NSObject+YJCategory_KVO.h
//  YJKit
//
//  Created by huang-kun on 16/4/3.
//  Copyright © 2016年 huang-kun. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (YJCategory_KVO)

/**
 *  @brief      Key-Value observing the key path and execute the handler block when observed value changes.
 *  @discussion This method performs as same as add observer with options (NSKeyValueObservingOptionOld | NSKeyValueObservingOptionNew)
 *  @remark     The handler block captures inner objects while the receiver is alive.
 *  @param keyPath       The key path, relative to the array, of the property to observe. This value must not be nil.
 *  @param changeHandler The block of code will be performed when observed value get changed.
 */
- (void)addObservedKeyPath:(NSString *)keyPath handleChanges:(void(^)(id object, id _Nullable oldValue, id _Nullable newValue))changeHandler;

/**
 *  @brief      Key-Value observing the key path and execute the handler block when observed value changes.
 *  @discussion This method performs as same as add observer with options (NSKeyValueObservingOptionInitial | NSKeyValueObservingOptionNew)
 *  @remark     The handler block captures inner objects while the receiver is alive.
 *  @param keyPath       The key path, relative to the array, of the property to observe. This value must not be nil.
 *  @param setupHandler  The block of code will be performed when observed value get setup.
 */
- (void)addObservedKeyPath:(NSString *)keyPath handleSetup:(void(^)(id object, id _Nullable newValue))setupHandler;

/**
 *  Stops observing changes for the property specified by a given key-path relative to the receiver.
 *  @remark If the same keyPath is being observed multiple times, then it should be removed once only.
 *  @param keyPath       The key path, relative to the array, of the property to observe. This value must not be nil.
 */
- (void)removeObservedKeyPath:(NSString *)keyPath;

/**
 *  Stops observing changes for all properties relative to the receiver.
 */
- (void)removeAllObservedKeyPaths;

@end

NS_ASSUME_NONNULL_END