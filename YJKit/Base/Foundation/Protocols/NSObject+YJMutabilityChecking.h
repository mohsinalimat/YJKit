//
//  NSObject+YJMutabilityChecking.h
//  YJKit
//
//  Created by huang-kun on 16/5/20.
//  Copyright © 2016年 huang-kun. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol YJMutabilityChecking <NSCopying>
- (BOOL)isMutable;
@end

@interface NSObject (YJMutabilityChecking)
@property (nonatomic, readonly) BOOL isMutable;
@end
