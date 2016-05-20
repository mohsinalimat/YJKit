//
//  NSMutableArray+YJCollection.h
//  YJKit
//
//  Created by huang-kun on 16/5/20.
//  Copyright © 2016年 huang-kun. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef id U;

@interface NSMutableArray <T> (YJCollection)

- (void)mapping:(U(^)(T obj))mapping;

- (void)filtering:(BOOL(^)(T obj))condition;

- (void)flattening;

- (void)flatMapping:(U(^)(T obj))mapping;

@end

NS_ASSUME_NONNULL_END
