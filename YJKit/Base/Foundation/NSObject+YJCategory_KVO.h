//
//  NSObject+YJCategory_KVO.h
//  YJKit
//
//  Created by Jack Huang on 16/4/3.
//  Copyright © 2016年 huang-kun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (YJCategory_KVO)

- (void)addObserverForKeyPath:(NSString *)keyPath valueChangeHandler:(void(^)(id object, id oldValue, id newValue))changeHandler;

- (void)removeObserverForKeyPath:(NSString *)keyPath;

- (void)removeAllObservedKeyPaths;

@end
