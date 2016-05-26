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

/// Avoid using introspection for class cluster
/// e.g. Don't call -[string isKindOfClass:[NSMutableString class]]

@interface NSString (YJMutabilityChecking)
@property (nonatomic, readonly) BOOL isMutable;
@end

@interface NSArray (YJMutabilityChecking)
@property (nonatomic, readonly) BOOL isMutable;
@end