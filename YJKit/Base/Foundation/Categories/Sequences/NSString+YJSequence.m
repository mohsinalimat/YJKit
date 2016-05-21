//
//  NSString+YJSequence.m
//  YJKit
//
//  Created by huang-kun on 16/5/16.
//  Copyright © 2016年 huang-kun. All rights reserved.
//

#import "NSString+YJSequence.h"
#import "NSObject+YJMutabilityChecking.h"

@implementation NSString (YJSequence)

static NSString * _yj_stringKeep(NSString *self, NSInteger fromIndex, NSInteger toIndex) {
    
    if (toIndex == NSUIntegerMax) {
        toIndex = -1;
    } else {
        NSCAssert(toIndex < self.length, @"The end index %@ for trimming %@ is out of bounds %@: %@",
                  @(toIndex), self.class, @(self.length), self);
    }
    
    if (fromIndex >= self.length || toIndex < 0) return @"";
    NSMutableString *collector = [NSMutableString stringWithCapacity:self.length];
    for (NSUInteger i = fromIndex; i <= toIndex; ++i) {
        unichar character = [self characterAtIndex:i];
        NSString *charString = [NSString stringWithCharacters:&character length:1];
        [collector appendString:charString];
    }
    return [collector copy];
}

- (NSString *)dropFirst {
    return [self dropFirst:1];
}

- (NSString *)dropFirst:(NSUInteger)count {
    NSAssert(count <= self.length, @"The count %@ is out of %@ length %@.", @(count), self.class, @(self.length));
    return _yj_stringKeep(self, count, self.length - 1);
}

- (NSString *)dropLast {
    return [self dropLast:1];
}

- (NSString *)dropLast:(NSUInteger)count {
    NSAssert(count <= self.length, @"The count %@ is out of %@ length %@.", @(count), self.class, @(self.length));
    return _yj_stringKeep(self, 0, self.length - count - 1);
}

- (NSString *)prefix:(NSUInteger)count {
    NSAssert(count <= self.length, @"The count %@ is out of %@ length %@.", @(count), self.class, @(self.length));
    return _yj_stringKeep(self, 0, count - 1);
}

- (NSString *)prefixUpTo:(NSUInteger)upToIndex {
    NSAssert(upToIndex < self.length, @"The index %@ of end prefix is beyond of %@ [0...%@].", @(upToIndex), self.class, @(self.length - 1));
    return _yj_stringKeep(self, 0, upToIndex);
}

- (NSString *)suffix:(NSUInteger)count {
    NSAssert(count <= self.length, @"The count %@ is out of %@ length %@.", @(count), self.class, @(self.length));
    return _yj_stringKeep(self, self.length - count, self.length - 1);
}

- (NSString *)suffixFrom:(NSUInteger)fromIndex {
    NSAssert(fromIndex < self.length, @"The index %@ of start suffix is beyond of %@ [0...%@].", @(fromIndex), self.class, @(self.length - 1));
    return _yj_stringKeep(self, fromIndex, self.length - 1);
}

@end
