//
//  YJRoundedCornerButton.m
//  YJKit
//
//  Created by huang-kun on 16/5/7.
//  Copyright © 2016年 huang-kun. All rights reserved.
//

#import "YJRoundedCornerButton.h"
#import "_YJLayerBasedMasking.h"
#import "_YJRoundedCornerView.h"
#import "NSObject+YJBlockBasedKVO.h"
#import "YJObjcMacros.h"
#import "RGBColor.h"
#import "NSCoder+YJCategory.h"

@interface YJRoundedCornerButton ()
@property (nonatomic) YJContentIndents titleIndents;
@end

@implementation YJRoundedCornerButton

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
        
        _cornerRadius = [decoder decodeCGFloatForKey:@"cornerRadius"];
        _borderWidth = [decoder decodeCGFloatForKey:@"borderWidth"];
        _borderColor = [UIColor colorWithRGBColor:[decoder decodeRGBColorForKey:@"borderColor"]];
        
        _titleIndentationStyle = [decoder decodeIntegerForKey:@"titleIndentationStyle"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)coder {
    [coder encodeObject:_maskLayer forKey:@"maskLayer"];
    [coder encodeObject:_oldMaskValues forKey:@"oldMaskValues"];
    [coder encodeObject:[NSValue valueWithCGRect:_transparentFrame] forKey:@"transparentFrame"];
    [coder encodeBool:_didFirstLayout forKey:@"didFirstLayout"];
    [coder encodeBool:_forceMaskColor forKey:@"forceMaskColor"];
    
    [coder encodeCGFloat:_cornerRadius forKey:@"cornerRadius"];
    [coder encodeCGFloat:_borderWidth forKey:@"borderWidth"];
    [coder encodeRGBColor:[_borderColor RGBColor] forKey:@"borderColor"];
    
    [coder encodeInteger:_titleIndentationStyle forKey:@"titleIndentationStyle"];
    [super encodeWithCoder:coder];
}

- (void)setup {
    _cornerRadius = 10.0f;
    _titleIndentationStyle = YJContentIndentationStyleDefault;
    _borderWidth = 1.0f;
    [self observeTintColor];
}

- (void)dealloc {
    [self removeObservedKeyPath:@"tintColor"];
}

- (void)observeTintColor {
    @weakify(self)
    [self registerObserverForKeyPath:@"tintColor" handleSetup:^(id  _Nonnull object, id  _Nullable newValue) {
        @strongify(self)
        if (newValue) {
            if (![self.borderColor isEqualToColor:newValue]) {
                self.borderColor = newValue;
            }
        }
    }];
}

- (void)setTitleIndentationStyle:(YJContentIndentationStyle)titleIndentationStyle {
    _titleIndentationStyle = titleIndentationStyle;
    [self updateMaskLayer];
}

// Add default intrinsicContentSize implementation

- (CGSize)sizeThatFits:(CGSize)size {
    return [self intrinsicContentSize];
}

- (CGSize)intrinsicContentSize {
    CGSize size = [super intrinsicContentSize];
    YJContentIndents indents = [self titleIndentsForIdentationStyle:self.titleIndentationStyle contentSize:size];
    size.width += indents.left + indents.right;
    size.height += indents.top + indents.bottom;
    return size;
}

- (YJContentIndents)titleIndents {
    return [self titleIndentsForIdentationStyle:self.titleIndentationStyle contentSize:[super intrinsicContentSize]];
}

- (YJContentIndents)titleIndentsForIdentationStyle:(YJContentIndentationStyle)style
                                     contentSize:(CGSize)contentSize {
    CGFloat height = contentSize.height;
    YJContentIndents indents = YJContentIndentsZero;
    
    switch (style) {
        case YJContentIndentationStyleNone:
            break;
        case YJContentIndentationStyleDefault:
            indents.left = height / 2;
            indents.right = height / 2;
            break;
        case YJContentIndentationStyleLarge:
            indents.left = height / 2 * 1.8;
            indents.right = height / 2 * 1.8;
            break;
    }
    return indents;
}

@end
