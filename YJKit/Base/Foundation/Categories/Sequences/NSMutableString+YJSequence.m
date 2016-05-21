//
//  NSMutableString+YJSequence.m
//  YJKit
//
//  Created by huang-kun on 16/5/20.
//  Copyright © 2016年 huang-kun. All rights reserved.
//

#import "NSMutableString+YJSequence.h"
#import "NSObject+YJMutabilityChecking.h"

@implementation NSMutableString (YJSequence)

static void _yj_mStringKeep(NSMutableString *self, NSInteger fromIndex, NSInteger toIndex) {
    
    if (toIndex == NSUIntegerMax) {
        toIndex = -1;
    } else {
        NSCAssert(toIndex < self.length, @"The end index %@ for trimming %@ is out of bounds %@: %@",
                  @(toIndex), self.class, @(self.length), self);
    }

    NSRange backRange = NSMakeRange(toIndex + 1, self.length - toIndex - 1);
    if (backRange.length > 0 && backRange.location < self.length && NSMaxRange(backRange) <= self.length) {
        [self deleteCharactersInRange:backRange];
    }
    NSRange frontRange = NSMakeRange(0, fromIndex);
    if (frontRange.length > 0) [self deleteCharactersInRange:frontRange];
}

- (void)droppingFirst {
    [self droppingFirst:1];
}

- (void)droppingFirst:(NSUInteger)count {
    NSAssert(count <= self.length, @"The count %@ is out of %@ length %@.", @(count), self.class, @(self.length));
    _yj_mStringKeep(self, count, self.length - 1);
}

- (void)droppingLast {
    [self droppingLast:1];
}

- (void)droppingLast:(NSUInteger)count {
    NSAssert(count <= self.length, @"The count %@ is out of %@ length %@.", @(count), self.class, @(self.length));
    _yj_mStringKeep(self, 0, self.length - count - 1);
}

- (void)prefixing:(NSUInteger)count {
    NSAssert(count <= self.length, @"The count %@ is out of %@ length %@.", @(count), self.class, @(self.length));
    _yj_mStringKeep(self, 0, count - 1);
}

- (void)prefixingUpTo:(NSUInteger)upToIndex {
    NSAssert(upToIndex < self.length, @"The index %@ of end prefixing is beyond of %@ [0...%@].", @(upToIndex), self.class, @(self.length - 1));
    _yj_mStringKeep(self, 0, upToIndex);
}

- (void)suffixing:(NSUInteger)count {
    NSAssert(count <= self.length, @"The count %@ is out of %@ length %@.", @(count), self.class, @(self.length));
    _yj_mStringKeep(self, self.length - count, self.length - 1);
}

- (void)suffixingFrom:(NSUInteger)fromIndex {
    NSAssert(fromIndex < self.length, @"The index %@ of start suffixing is beyond of %@ [0...%@].", @(fromIndex), self.class, @(self.length - 1));
    _yj_mStringKeep(self, fromIndex, self.length - 1);
}

@end
