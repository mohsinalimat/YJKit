//
//  NSObject+YJTaggedPointerChecking.h
//  YJKit
//
//  Created by huang-kun on 16/5/25.
//  Copyright © 2016年 huang-kun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (YJTaggedPointerChecking)
@property (nonatomic, readonly) BOOL isTaggedPointer;
@end
