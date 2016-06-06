//
//  NSObject+YJCodingExtension.h
//  YJKit
//
//  Created by huang-kun on 16/6/5.
//  Copyright © 2016年 huang-kun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (YJCodingExtension)

- (void)encodeIvarListWithCoder:(NSCoder *)coder;
- (void)encodeIvarListWithCoder:(NSCoder *)coder forClass:(Class)cls;

- (void)decodeIvarListWithCoder:(NSCoder *)decoder;
- (void)decodeIvarListWithCoder:(NSCoder *)decoder forClass:(Class)cls;

@end

