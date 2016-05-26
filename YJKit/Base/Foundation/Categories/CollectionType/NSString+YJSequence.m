//
//  NSString+YJSequence.m
//  YJKit
//
//  Created by huang-kun on 16/5/16.
//  Copyright © 2016年 huang-kun. All rights reserved.
//

#import "NSString+YJSequence.h"

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

- (NSString *)droppingFirst {
    return [self droppingFirst:1];
}

- (NSString *)stringByDroppingFirstCharacter {
    return [self droppingFirst:1];
}

- (NSString *)droppingFirst:(NSUInteger)count {
    NSAssert(count <= self.length, @"The count %@ is out of %@ length %@.", @(count), self.class, @(self.length));
    return _yj_stringKeep(self, count, self.length - 1);
}

- (NSString *)stringByDroppingFirstCharactersWithCount:(NSUInteger)count {
    return [self droppingFirst:count];
}

- (NSString *)droppingLast {
    return [self droppingLast:1];
}

- (NSString *)stringByDroppingLastCharacter {
    return [self droppingLast:1];
}

- (NSString *)droppingLast:(NSUInteger)count {
    NSAssert(count <= self.length, @"The count %@ is out of %@ length %@.", @(count), self.class, @(self.length));
    return _yj_stringKeep(self, 0, self.length - count - 1);
}

- (NSString *)stringByDroppingLastCharactersWithCount:(NSUInteger)count {
    return [self droppingLast:count];
}

- (NSString *)prefixed:(NSUInteger)count {
    NSAssert(count <= self.length, @"The count %@ is out of %@ length %@.", @(count), self.class, @(self.length));
    return _yj_stringKeep(self, 0, count - 1);
}

- (NSString *)stringByPrefixingCharactersWithCount:(NSUInteger)count {
    return [self prefixed:count];
}

- (NSString *)prefixingUpToIndex:(NSUInteger)upToIndex {
    NSAssert(upToIndex < self.length, @"The index %@ of end prefix is beyond of %@ [0...%@].", @(upToIndex), self.class, @(self.length - 1));
    return _yj_stringKeep(self, 0, upToIndex);
}

- (NSString *)stringByPrefixingCharactersUpToIndex:(NSUInteger)upToIndex {
    return [self prefixingUpToIndex:upToIndex];
}

- (NSString *)suffixed:(NSUInteger)count {
    NSAssert(count <= self.length, @"The count %@ is out of %@ length %@.", @(count), self.class, @(self.length));
    return _yj_stringKeep(self, self.length - count, self.length - 1);
}

- (NSString *)stringBySuffixingCharactersWithCount:(NSUInteger)count {
    return [self suffixed:count];
}

- (NSString *)suffixingFromIndex:(NSUInteger)fromIndex {
    NSAssert(fromIndex < self.length, @"The index %@ of start suffix is beyond of %@ [0...%@].", @(fromIndex), self.class, @(self.length - 1));
    return _yj_stringKeep(self, fromIndex, self.length - 1);
}

- (NSString *)stringBySuffixingCharactersFromIndex:(NSUInteger)fromIndex {
    return [self suffixingFromIndex:fromIndex];
}

@end
