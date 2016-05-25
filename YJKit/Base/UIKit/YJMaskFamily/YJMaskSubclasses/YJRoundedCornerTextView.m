//
//  YJRoundedCornerTextView.m
//  YJKit
//
//  Created by huang-kun on 16/5/20.
//  Copyright © 2016年 huang-kun. All rights reserved.
//

#import "YJRoundedCornerTextView.h"
#import "_YJLayerBasedMasking.h"
#import "_YJRoundedCornerView.h"
#import "YJObjcMacros.h"
#import "NSObject+YJBlockBasedKVO.h"
#import "NSValue+YJGeometryExtension.h"
#import "RGBColor.h"

@implementation YJRoundedCornerTextView

// Add default YJLayerBasedMasking implementations
YJ_LAYER_BASED_MASKING_PROTOCOL_DEFAULT_IMPLEMENTATION_FOR_UIVIEW_SUBCLASS

// Add default rounded corner implementations
YJ_ROUNDED_CORNER_VIEW_DEFAULT_IMPLEMENTATION_FOR_UIVIEW_SUBCLASS

/* init from code */
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

/* init from IB */
- (nullable instancetype)initWithCoder:(NSCoder *)decoder {
    self = [super initWithCoder:decoder];
    if (self) {
        _maskLayer = [decoder decodeObjectForKey:@"maskLayer"];
        _oldMaskValues = [decoder decodeObjectForKey:@"oldMaskValues"];
        _transparentFrame = [[decoder decodeObjectForKey:@"transparentFrame"] CGRectValue];
        _didFirstLayout = [decoder decodeBoolForKey:@"didFirstLayout"];
        _forceMaskColor = [decoder decodeBoolForKey:@"forceMaskColor"];
        _borderWidth = [decoder decodeCGFloatForKey:@"borderWidth"];
        _borderColor = [UIColor colorWithRGBColor:[decoder decodeRGBColorForKey:@"borderColor"]];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)coder {
    [coder encodeObject:_maskLayer forKey:@"maskLayer"];
    [coder encodeObject:_oldMaskValues forKey:@"oldMaskValues"];
    [coder encodeObject:[NSValue valueWithCGRect:_transparentFrame] forKey:@"transparentFrame"];
    [coder encodeBool:_didFirstLayout forKey:@"didFirstLayout"];
    [coder encodeBool:_forceMaskColor forKey:@"forceMaskColor"];
    [coder encodeCGFloat:_borderWidth forKey:@"borderWidth"];
    [coder encodeRGBColor:[_borderColor RGBColor] forKey:@"borderColor"];
    [super encodeWithCoder:coder];
}

- (void)setup {
    self.textContainerInset = UIEdgeInsetsMake(10, 10, 10, 10);
    _cornerRadius = 10.0f;
    [self observeCornerRadius];
}

- (void)observeCornerRadius {
    @weakify(self)
    [self registerObserverForKeyPath:@"cornerRadius" handleChanges:^(id object, id _Nullable oldValue, id _Nullable newValue){
        @strongify(self)
        CGFloat inset = [newValue CGFloatValue] / 2;
        self.textContainerInset = UIEdgeInsetsMake(inset, inset, inset, inset);
    }];
}

@end
