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

@interface YJRoundedCornerButton ()
@property (nonatomic) YJTitleIndents titleIndents;
@end

@implementation YJRoundedCornerButton

// Add default YJLayerBasedMasking implementations
//YJ_LAYER_BASED_MASKING_PROTOCOL_DEFAULT_IMPLEMENTATION_FOR_UIVIEW_SUBCLASS

/* @implementation XXMaskedView */{  
    CALayer *_maskLayer;  
    CGRect _transparentFrame;  
    BOOL _didFirstLayout;
}

@synthesize maskColor = _maskColor;  

- (void)setMaskColor:(UIColor *)maskColor {  
    if (![_maskColor isEqualToRGBColor:maskColor]) {  
        _maskColor = maskColor;  
        [self updateMaskLayer];  
    }  
}  

/* override view hierarchy */  

- (void)willMoveToSuperview:(nullable UIView *)newSuperview {  
    [super willMoveToSuperview:newSuperview];  
    if (!newSuperview) return;  
    /* added to superview */  
    if (newSuperview.backgroundColor) {  
        self.maskColor = newSuperview.backgroundColor;  
        [self updateMaskLayer];  
        return;  
    }  
    [newSuperview addObservedKeyPath:@"backgroundColor" handleSetup:^(id  _Nonnull object, id  _Nullable newValue) {  
        if (self.superview == object && newValue && [newValue isKindOfClass:[UIColor class]]) { /* not go in from design phase.*/  
            if (![self.maskColor isEqualToRGBColor:newValue]) {  
                self.maskColor = newValue;  
                [self updateMaskLayer];  
            }  
        }  
    }];  
}  

- (void)removeFromSuperview {  
    self.maskColor = nil;  
    [self.superview removeObservedKeyPath:@"backgroundColor"];  
    [super removeFromSuperview];  
}  

/* override layouts (e.g. update auto-layout constraints or view's size changed) */  

- (void)layoutSubviews {  
    [super layoutSubviews];  
    _didFirstLayout = YES;  
    [self updateMaskLayer];  
}  

/* masking */  

- (void)updateMaskLayer {  
    if (!_didFirstLayout) return;  
    [_maskLayer removeFromSuperlayer];  
    [self _configureMaskLayerWithColor:self.maskColor];  
}  

- (void)_configureMaskLayerWithColor:(UIColor *)color {  
    if (_maskLayer.superlayer || !color) return;  
    _maskLayer = [self prepareMaskLayerWithDefaultMaskColor:color];  
    if (!_maskLayer) {  
        UIBezierPath *maskShape = [self prepareMaskRegion];  
        _maskLayer = [CAShapeLayer maskLayerForBezierPath:maskShape fillColor:color.CGColor];  
    }  
    [self.layer addSublayer:_maskLayer];  
}



// Add default rounded corner implementations
//YJ_ROUNDED_CORNER_VIEW_DEFAULT_IMPLEMENTATION_FOR_UIVIEW_SUBCLASS

static const CGFloat kYJRoundedCornerViewDefaultCornerRadius = 10.0f; 

/* init from code */ 
- (instancetype)initWithFrame:(CGRect)frame { 
    self = [super initWithFrame:frame]; 
    if (self) { 
        _cornerRadius = kYJRoundedCornerViewDefaultCornerRadius;
        _titleIndentationStyle = YJTitleIndentationStyleDefault;
    }
    return self; 
} 

/* init from IB */ 
- (instancetype)initWithCoder:(NSCoder *)aDecoder { 
    self = [super initWithCoder:aDecoder]; 
    if (self) { 
        _cornerRadius = kYJRoundedCornerViewDefaultCornerRadius;
        _titleIndentationStyle = YJTitleIndentationStyleDefault;
    }
    return self; 
} 

- (void)setCornerRadius:(CGFloat)cornerRadius { 
    if (cornerRadius < 0.0f) cornerRadius = 0.0f; 
    _cornerRadius = cornerRadius;
    [self updateMaskLayer];
}

- (void)setBorderWidth:(CGFloat)borderWidth { 
    if (borderWidth < 0.0f) borderWidth = 0.0f; 
    _borderWidth = borderWidth; 
    [self updateMaskLayer]; 
} 

- (void)setBorderColor:(UIColor *)borderColor { 
    _borderColor = borderColor; 
    [self updateMaskLayer]; 
} 

- (UIBezierPath *)prepareMaskRegion { 
    CGRect bounds = self.bounds; 
    CGRect rcRect = !CGRectIsEmpty(_transparentFrame) ? _transparentFrame : self.bounds; /* rounded corner rect */ 
    
    UIEdgeInsets edgeInsets; 
    edgeInsets.top = rcRect.origin.y; 
    edgeInsets.left = rcRect.origin.x; 
    edgeInsets.bottom = bounds.size.height - rcRect.size.height - rcRect.origin.y; 
    edgeInsets.right = bounds.size.width - rcRect.size.width - rcRect.origin.x; 
    
    return [UIBezierPath bezierPathWithRoundedCornerMaskShapeInSize:bounds.size 
                                                       cornerRadius:self.cornerRadius 
                                                         edgeInsets:edgeInsets 
                                                     outerFramePath:NULL 
                                                     innerRoundPath:NULL]; 
} 

- (nullable CALayer *)prepareMaskLayerWithDefaultMaskColor:(UIColor *)maskColor { 
    if (!self.borderWidth || !self.borderColor) { 
        return nil; 
    } else { 
        CGRect bounds = self.bounds; 
        CGRect rcRect = !CGRectIsEmpty(_transparentFrame) ? _transparentFrame : self.bounds; /* rounded corner rect */ 
        
        UIEdgeInsets edgeInsets; 
        edgeInsets.top = rcRect.origin.y; 
        edgeInsets.left = rcRect.origin.x; 
        edgeInsets.bottom = bounds.size.height - rcRect.size.height - rcRect.origin.y; 
        edgeInsets.right = bounds.size.width - rcRect.size.width - rcRect.origin.x; 
        
        CGSize innerSize = CGSizeMake(bounds.size.width - self.borderWidth / 2, bounds.size.height - self.borderWidth / 2); 
        UIBezierPath *framePath, *roundedBorderPath; 
        [UIBezierPath bezierPathWithRoundedCornerMaskShapeInSize:innerSize 
                                                    cornerRadius:self.cornerRadius 
                                                      edgeInsets:edgeInsets 
                                                  outerFramePath:&framePath 
                                                  innerRoundPath:&roundedBorderPath]; 
        
        return [CAShapeLayer maskLayerForFrameBezierPath:framePath 
                                         shapeBezierPath:roundedBorderPath 
                                               fillColor:maskColor.CGColor 
                                             strokeWidth:self.borderWidth 
                                             strokeColor:self.borderColor.CGColor]; 
    } 
}


// Add default intrinsicContentSize implementation
//YJ_ROUNDED_CORNER_CONTENT_VIEW_DEFAULT_IMPLEMENTATION_FOR_UIVIEW_SUBCLASS

- (void)setTintColor:(UIColor *)tintColor {
    [super setTintColor:tintColor];
    if (!_borderColor) _borderColor = tintColor;
    [self updateMaskLayer];
}

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
            indents.top = height / 4;
            indents.bottom = height / 4;
            indents.left = height / 2;
            indents.right = height / 2;
            break;
        case YJTitleIndentationStyleLarge:
            indents.top = height / 4;
            indents.bottom = height / 4;
            indents.left = height / 2 * 1.6;
            indents.right = height / 2 * 1.6;
            break;
    }
    return indents;
}

@end
