//
//  NSObject+YJAssociatedIdentifier.h
//  YJKit
//
//  Created by huang-kun on 16/5/25.
//  Copyright © 2016年 huang-kun. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

FOUNDATION_EXTERN const NSInteger YJAssociatedTagInvalid;
FOUNDATION_EXTERN const NSInteger YJAssociatedTagNone;

@interface NSObject (YJAssociatedIdentifier)
@property (nonatomic, copy, nullable) NSString *associatedIdentifier; // Maybe returns nil
@property (nonatomic, assign) NSInteger associatedTag; // Maybe returns YJAssociatedTagNone or YJAssociatedTagInvalid
@end


@interface NSArray <ObjectType> (YJAssociatedIdentifier)
- (BOOL)containsObjectWithAssociatedIdentifier:(NSString *)associatedIdentifier;
- (BOOL)containsObjectWithAssociatedTag:(NSInteger)associatedTag;
- (void)enumerateAssociatedObjectsUsingBlock:(void (^)(ObjectType obj, NSUInteger idx, BOOL *stop))block;
@end

NS_ASSUME_NONNULL_END