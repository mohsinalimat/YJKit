//
//  NSMutableArray+YJCollection.h
//  YJKit
//
//  Created by huang-kun on 16/5/12.
//  Copyright © 2016年 huang-kun. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSMutableArray <T> (YJCollection)

- (nullable T)removeFirst;

- (nullable T)removeLast;

@end

NS_ASSUME_NONNULL_END
