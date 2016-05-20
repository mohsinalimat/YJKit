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

id _yj_stringKeep(NSString *self, NSInteger fromIndex, NSInteger toIndex) {
    
    if (toIndex == NSUIntegerMax) {
        toIndex = -1;
    } else {
        NSCAssert(toIndex < self.length, @"The end index %@ for trimming %@ is out of bounds %@: %@",
                  @(toIndex), self.class, @(self.length), self);
    }
    
    if (self.isMutable) {
        NSMutableString *_self = (NSMutableString *)self;
        NSRange backRange = NSMakeRange(toIndex + 1, _self.length - toIndex - 1);
        if (backRange.length > 0 && backRange.location < _self.length && NSMaxRange(backRange) <= _self.length) {
            [_self deleteCharactersInRange:backRange];
        }
        NSRange frontRange = NSMakeRange(0, fromIndex);
        if (frontRange.length > 0) [_self deleteCharactersInRange:frontRange];
        return _self;
    } else {
        if (fromIndex >= self.length || toIndex < 0) return @"";
        NSMutableString *collector = [NSMutableString stringWithCapacity:self.length];
        for (NSUInteger i = fromIndex; i <= toIndex; ++i) {
            unichar character = [self characterAtIndex:i];
            NSString *charString = [NSString stringWithCharacters:&character length:1];
            [collector appendString:charString];
        }
        return [collector copy];
    }
}

- (NSArray <NSString *> *)characters {
    NSMutableArray *collector = [NSMutableArray arrayWithCapacity:self.length];
    for (NSUInteger i = 0; i < self.length; ++i) {
        unichar character = [self characterAtIndex:i];
        NSString *charString = [NSString stringWithCharacters:&character length:1];
        [collector addObject:charString];
    }
    return [collector copy];
}

- (nullable NSString *)firstCharacter {
    return self.characters.firstObject;
}

- (nullable NSString *)lastCharacter {
    return self.characters.lastObject;
}

- (id)dropFirst {
    return [self dropFirst:1];
}

- (id)dropFirst:(NSUInteger)count {
    NSAssert(count <= self.length, @"The count %@ is out of %@ length %@.", @(count), self.class, @(self.length));
    return _yj_stringKeep(self, count, self.length - 1);
}

- (id)dropLast {
    return [self dropLast:1];
}

- (id)dropLast:(NSUInteger)count {
    NSAssert(count <= self.length, @"The count %@ is out of %@ length %@.", @(count), self.class, @(self.length));
    return _yj_stringKeep(self, 0, self.length - count - 1);
}

- (id)prefix:(NSUInteger)count {
    NSAssert(count <= self.length, @"The count %@ is out of %@ length %@.", @(count), self.class, @(self.length));
    return _yj_stringKeep(self, 0, count - 1);
}

- (id)prefixUpTo:(NSUInteger)upToIndex {
    NSAssert(upToIndex < self.length, @"The index %@ of end prefix is beyond of %@ [0...%@].", @(upToIndex), self.class, @(self.length - 1));
    return _yj_stringKeep(self, 0, upToIndex);
}

- (id)suffix:(NSUInteger)count {
    NSAssert(count <= self.length, @"The count %@ is out of %@ length %@.", @(count), self.class, @(self.length));
    return _yj_stringKeep(self, self.length - count, self.length - 1);
}

- (id)suffixFrom:(NSUInteger)fromIndex {
    NSAssert(fromIndex < self.length, @"The index %@ of start suffix is beyond of %@ [0...%@].", @(fromIndex), self.class, @(self.length - 1));
    return _yj_stringKeep(self, fromIndex, self.length - 1);
}

@end
