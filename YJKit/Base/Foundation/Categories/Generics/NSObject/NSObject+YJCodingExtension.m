//
//  NSObject+YJCodingExtension.m
//  YJKit
//
//  Created by huang-kun on 16/6/5.
//  Copyright © 2016年 huang-kun. All rights reserved.
//

#import <objc/runtime.h>
#import "NSObject+YJCodingExtension.h"

@interface NSCoder (YJCodingPrivate)
@property (nonatomic, strong) NSMutableSet <NSString *> *yj_encodedKeys;
@property (nonatomic, strong) NSMutableSet <NSString *> *yj_decodedKeys;
@end

@implementation NSCoder (YJCodingPrivate)

- (void)setYj_encodedKeys:(NSMutableSet <NSString *> *)yj_encodedKeys {
    objc_setAssociatedObject(self, @selector(yj_encodedKeys), yj_encodedKeys, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSMutableSet <NSString *> *)yj_encodedKeys {
    NSMutableSet *ivarNames = objc_getAssociatedObject(self, _cmd);
    if (!ivarNames) {
        ivarNames = [NSMutableSet new];
        self.yj_encodedKeys = ivarNames;
    }
    return ivarNames;
}

- (void)setYj_decodedKeys:(NSMutableSet<NSString *> *)yj_decodedKeys {
    objc_setAssociatedObject(self, @selector(yj_decodedKeys), yj_decodedKeys, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSMutableSet <NSString *> *)yj_decodedKeys {
    NSMutableSet *ivarNames = objc_getAssociatedObject(self, _cmd);
    if (!ivarNames) {
        ivarNames = [NSMutableSet new];
        self.yj_decodedKeys = ivarNames;
    }
    return ivarNames;
}

@end


@implementation NSObject (YJCodingExtension)

#pragma mark - Encoding

- (void)encodeIvarListWithCoder:(NSCoder *)coder {
    [self encodeIvarListWithCoder:coder forClass:self.class];
}

- (void)encodeIvarListWithCoder:(NSCoder *)coder forClass:(Class)cls {
    if (![self conformsToProtocol:@protocol(NSCoding)] || ![cls conformsToProtocol:@protocol(NSCoding)])
        return;
    
    unsigned int ivarCount = 0;
    Ivar *ivars = class_copyIvarList(cls, &ivarCount);
    
    unsigned int hasEncodedCount = 0;
    
    for (unsigned int i = 0; i < ivarCount; ++i) {
        Ivar ivar = ivars[i];
        const char *utf8Name = ivar_getName(ivar);
        NSString *name = [NSString stringWithUTF8String:utf8Name];
        if (![coder.yj_encodedKeys containsObject:name]) {
            [coder.yj_encodedKeys addObject:name];
            id value = [self valueForKey:name];
            if ([value conformsToProtocol:@protocol(NSCoding)]) {
                [coder encodeObject:value forKey:name];
            }
        } else {
            hasEncodedCount++;
        }
    }
    free(ivars);
    
    if (hasEncodedCount == ivarCount) {
        Class superCls = class_getSuperclass(cls);
        if (superCls) {
            [self encodeIvarListWithCoder:coder forClass:superCls];
        }
    }
}

#pragma mark - Decoding

- (void)decodeIvarListWithCoder:(NSCoder *)decoder {
    [self decodeIvarListWithCoder:decoder forClass:self.class];
}

- (void)decodeIvarListWithCoder:(NSCoder *)decoder forClass:(Class)cls {
    if (![self conformsToProtocol:@protocol(NSCoding)] || ![cls conformsToProtocol:@protocol(NSCoding)])
        return;
    
    unsigned int ivarCount = 0;
    Ivar *ivars = class_copyIvarList(cls, &ivarCount);
    
    unsigned int hasDecodedCount = 0;
    
    for (unsigned int i = 0; i < ivarCount; ++i) {
        Ivar ivar = ivars[i];
        const char *utf8Name = ivar_getName(ivar);
        NSString *name = [NSString stringWithUTF8String:utf8Name];
        if (![decoder.yj_decodedKeys containsObject:name]) {
            [decoder.yj_decodedKeys addObject:name];
            id value = [decoder decodeObjectForKey:name];
            if (value) [self setValue:value forKey:name];
        } else {
            hasDecodedCount++;
        }
    }
    free(ivars);
    
    if (hasDecodedCount == ivarCount) {
        Class superCls = class_getSuperclass(cls);
        if (superCls) {
            [self decodeIvarListWithCoder:decoder forClass:superCls];
        }
    }
}

@end
