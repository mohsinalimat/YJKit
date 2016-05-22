//
//  YJMaskedView.m
//  YJKit
//
//  Created by huang-kun on 16/5/6.
//  Copyright © 2016年 huang-kun. All rights reserved.
//

#import "YJMaskedView.h"
#import "_YJLayerBasedMasking.h"
#import "YJDebugMacros.h"

@implementation YJMaskedView

// Add default YJLayerBasedMasking implementations
YJ_LAYER_BASED_MASKING_PROTOCOL_DEFAULT_IMPLEMENTATION_FOR_YJMASKEDVIEW_SUBCLASS

#if YJ_DEBUG
- (void)dealloc {
    NSLog(@"%@ dealloc", self.class);
}
#endif

- (nullable instancetype)initWithCoder:(NSCoder *)decoder {
    self = [super initWithCoder:decoder];
    if (self) {
        _maskLayer = [decoder decodeObjectForKey:@"maskLayer"];
        _oldMaskValues = [decoder decodeObjectForKey:@"oldMaskValues"];
        _transparentFrame = [[decoder decodeObjectForKey:@"transparentFrame"] CGRectValue];
        _didFirstLayout = [decoder decodeBoolForKey:@"didFirstLayout"];
        _forceMaskColor = [decoder decodeBoolForKey:@"forceMaskColor"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)coder {
    [coder encodeObject:_maskLayer forKey:@"maskLayer"];
    [coder encodeObject:_oldMaskValues forKey:@"oldMaskValues"];
    [coder encodeObject:[NSValue valueWithCGRect:_transparentFrame] forKey:@"transparentFrame"];
    [coder encodeBool:_didFirstLayout forKey:@"didFirstLayout"];
    [coder encodeBool:_forceMaskColor forKey:@"forceMaskColor"];
    [super encodeWithCoder:coder];
}

@end
