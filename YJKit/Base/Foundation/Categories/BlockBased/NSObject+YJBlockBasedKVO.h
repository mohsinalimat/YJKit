//
//  NSObject+YJBlockBasedKVO.h
//  YJKit
//
//  Created by huang-kun on 16/4/3.
//  Copyright © 2016年 huang-kun. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (YJBlockBasedKVO)

/**
 *  @brief      Key-Value observing the key path and execute the handler block when observed value changes. 
 *  @discussion This method performs as same as add observer with options (NSKeyValueObservingOptionOld | NSKeyValueObservingOptionNew). The observer will be generated implicitly and it's safe for not removing observer explicitly because eventually observer will be removed when receiver gets deallocated.
 *  @remark     The handler block captures inner objects while the receiver is alive.
 *  @param keyPath       The key path, relative to the array, of the property to observe. This value must not be nil.
 *  @param changeHandler The block of code will be performed when observed value get changed.
 */
- (void)registerObserverForKeyPath:(NSString *)keyPath handleChanges:(void(^)(id object, id _Nullable oldValue, id _Nullable newValue))changeHandler;


/**
 *  @brief      Key-Value observing the key path and execute the handler block when observed value changes.
 *  @discussion This method performs as same as add observer with options (NSKeyValueObservingOptionInitial | NSKeyValueObservingOptionNew). The observer will be generated implicitly and it's safe for not removing observer explicitly because eventually observer will be removed when receiver gets deallocated.
 *  @remark     The handler block captures inner objects while the receiver is alive.
 *  @param keyPath       The key path, relative to the array, of the property to observe. This value must not be nil.
 *  @param setupHandler  The block of code will be performed when observed value get setup.
 */
- (void)registerObserverForKeyPath:(NSString *)keyPath handleSetup:(void(^)(id object, id _Nullable newValue))setupHandler;


/**
 *  @brief      Key-Value observing the key path and execute the handler block when observed value changes.
 *  @discussion This method performs as same as add observer with options (NSKeyValueObservingOptionOld | NSKeyValueObservingOptionNew)
 *  @remark     The handler block captures inner objects while the receiver is alive.
 *  @param keyPath       The key path, relative to the array, of the property to observe. This value must not be nil.
 *  @param changeHandler The block of code will be performed when observed value get changed.
 */
- (void)addObservedKeyPath:(NSString *)keyPath handleChanges:(void(^)(id object, id _Nullable oldValue, id _Nullable newValue))changeHandler DEPRECATED_MSG_ATTRIBUTE("This method is deprecated. Call registerObserverForKeyPath:handleChanges: instead.");


/**
 *  @brief      Key-Value observing the key path and execute the handler block when observed value changes.
 *  @discussion This method performs as same as add observer with options (NSKeyValueObservingOptionInitial | NSKeyValueObservingOptionNew)
 *  @remark     The handler block captures inner objects while the receiver is alive.
 *  @param keyPath       The key path, relative to the array, of the property to observe. This value must not be nil.
 *  @param setupHandler  The block of code will be performed when observed value get setup.
 */
- (void)addObservedKeyPath:(NSString *)keyPath handleSetup:(void(^)(id object, id _Nullable newValue))setupHandler DEPRECATED_MSG_ATTRIBUTE("This method is deprecated. Call registerObserverForKeyPath:handleSetup: instead.");


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