//
//  YJRoundedCornerLabel.m
//  YJKit
//
//  Created by huang-kun on 16/5/7.
//  Copyright © 2016年 huang-kun. All rights reserved.
//

#import "YJRoundedCornerLabel.h"
#import "_YJLayerBasedMasking.h"
#import "_YJRoundedCornerView.h"
#import "NSObject+YJCategory_KVO.h"
#import "YJObjcMacros.h"
#import "UIColor+YJCategory.h"

@implementation YJRoundedCornerLabel

// Add default YJLayerBasedMasking implementations
YJ_LAYER_BASED_MASKING_PROTOCOL_DEFAULT_IMPLEMENTATION_FOR_UIVIEW_SUBCLASS

// Add default rounded corner implementations
YJ_ROUNDED_CORNER_VIEW_DEFAULT_IMPLEMENTATION_FOR_UIVIEW_SUBCLASS_WITH_EXTRA_INIT(
                                                                                  
    self.textAlignment = NSTextAlignmentCenter;
                                                                                  
    _titleIndentationStyle = YJTitleIndentationStyleDefault;
    _borderWidth = 1.0f;

    @weakify(self)
    [self addObservedKeyPath:@"textColor" handleSetup:^(id  _Nonnull object, id  _Nullable newValue) {
        @strongify(self)
        if (newValue) {
            if (![self.borderColor isEqualToRGBColor:newValue]) {
                self.borderColor = newValue;
            }
        }
    }];
)

- (void)dealloc {
    [self removeObservedKeyPath:@"textColor"];
}

- (void)setTitleIndentationStyle:(YJTitleIndentationStyle)titleIndentationStyle {
    _titleIndentationStyle = titleIndentationStyle;
    [self updateMaskLayer];
}

// Add default intrinsicContentSize implementation

- (CGSize)sizeThatFits:(CGSize)size {
    return [self intrinsicContentSize];
}

- (CGSize)intrinsicContentSize {
    CGSize size = [super intrinsicContentSize];
    YJTitleIndents indents = [self titleIndentsForIdentationStyle:self.titleIndentationStyle contentSize:size];
    size.width += indents.left + indents.right;
    size.height += indents.top + indents.bottom;
    return size;
}

- (YJTitleIndents)titleIndents {
    return [self titleIndentsForIdentationStyle:self.titleIndentationStyle contentSize:[super intrinsicContentSize]];
}

- (YJTitleIndents)titleIndentsForIdentationStyle:(YJTitleIndentationStyle)style
                                     contentSize:(CGSize)contentSize {
    CGFloat height = contentSize.height;
    YJTitleIndents indents = YJTitleIndentsZero;
    
    switch (style) {
        case YJTitleIndentationStyleNone:
            break;
        case YJTitleIndentationStyleDefault:
            indents.top = height / 8;
            indents.bottom = height / 8;
            indents.left = height / 2;
            indents.right = height / 2;
            break;
        case YJTitleIndentationStyleLarge:
            indents.top = height / 8;
            indents.bottom = height / 8;
            indents.left = height / 2 * 1.8;
            indents.right = height / 2 * 1.8;
            break;
    }
    return indents;
}

@end
