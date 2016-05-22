//
//  NSObject+YJMutabilityChecking.m
//  YJKit
//
//  Created by huang-kun on 16/5/20.
//  Copyright © 2016年 huang-kun. All rights reserved.
//

#import "NSObject+YJMutabilityChecking.h"

@implementation NSString (YJMutabilityChecking)
- (BOOL)isMutable { return self.copy != self; }
@end

@implementation NSArray (YJMutabilityChecking)
- (BOOL)isMutable { return self.copy != self; }
@end
