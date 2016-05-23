//
//  _YJLayerBasedMasking.h
//  YJKit
//
//  Created by huang-kun on 16/5/7.
//  Copyright © 2016年 huang-kun. All rights reserved.
//

#ifndef _YJLayerBasedMasking_h
#define _YJLayerBasedMasking_h

// Debug Tip for TARGET_INTERFACE_BUILDER:
// Compiler won't warn you if you make typos under TARGET_INTERFACE_BUILDER. So if you failed to build Xcode for IBDesignable phase by selecting Xcode menu bar (in interface builder, either .storyboard or .xib) -> Editor -> Debug Selected Views, then check your code under TARGET_INTERFACE_BUILDER.

#import "NSObject+YJBlockBasedKVO.h"
#import "CAShapeLayer+YJLayerBasedMasking.h"
#import "UIColor+YJCategory.h"
#import "RGBColor.h"
#import "YJUIMacros.h"

/**
 * Must declare a kind of YJMaskView abstract class which conforms protocol <YJLayerBasedMasking>
 * Then declare a custom mask view which inherits that abstract class.
 */
#ifndef YJ_LAYER_BASED_MASKING_PROTOCOL_DEFAULT_IMPLEMENTATION_FOR_UIVIEW_SUBCLASS
#define YJ_LAYER_BASED_MASKING_PROTOCOL_DEFAULT_IMPLEMENTATION_FOR_UIVIEW_SUBCLASS \
\
/* @implementation XXMaskedView */{  \
    CALayer *_maskLayer;  \
    NSMutableDictionary <NSString *, NSValue *> *_oldMaskValues;  \
    CGRect _transparentFrame;  \
    BOOL _didFirstLayout;  \
    BOOL _forceMaskColor;  \
}  \
  \
@synthesize maskColor = _maskColor;  \
  \
/* If call -setMaskColor:, the superview's background color changes will not be effective */  \
- (void)setMaskColor:(UIColor *)maskColor {  \
    if (![_maskColor isEqualToColor:maskColor]) {  \
        _maskColor = maskColor;  \
        _forceMaskColor = YES;  \
        if (!maskColor) {  \
            _forceMaskColor = NO;  \
            _maskColor = self.superview.backgroundColor;  \
        }  \
        [self updateMaskLayer];  \
    }  \
}  \
  \
/* override view hierarchy */  \
  \
- (void)willMoveToSuperview:(nullable UIView *)newSuperview {  \
    [super willMoveToSuperview:newSuperview];  \
    if (!newSuperview) return;  \
    /* added to superview */  \
    if (newSuperview.backgroundColor) {  \
        _maskColor = newSuperview.backgroundColor;  \
        [self updateMaskLayer];  \
    }  \
    [newSuperview registerObserverForKeyPath:@"backgroundColor" handleSetup:^(id  _Nonnull object, id  _Nullable newValue) {  \
        if (self.superview == object && newValue && [newValue isKindOfClass:[UIColor class]]) { /* not go in from design phase.*/  \
            if (![_maskColor isEqualToColor:newValue] && !_forceMaskColor) {  \
                _maskColor = newValue;  \
                [self updateMaskLayer];  \
            }  \
        }  \
    }];  \
}  \
  \
- (void)removeFromSuperview {  \
    _maskColor = nil;  \
    [self.superview removeObservedKeyPath:@"backgroundColor"];  \
    [super removeFromSuperview];  \
}  \
  \
/* override layouts (e.g. update auto-layout constraints or view's size changed) */  \
  \
- (void)layoutSubviews {  \
    [super layoutSubviews];  \
    _didFirstLayout = YES;  \
    [self updateMaskLayer];  \
}  \
  \
/* masking */  \
  \
- (void)updateMaskLayer {  \
    if (!_didFirstLayout) return;  \
    if (![self didChangeMaskValues]) return;  \
    [_maskLayer removeFromSuperlayer];  \
    [self configureMaskLayerWithColor:_maskColor];  \
}  \
  \
- (void)configureMaskLayerWithColor:(UIColor *)color {  \
    if (_maskLayer.superlayer || !color) return;  \
    CGFloat onePixelInPoint = 1 / kUIScreenScale;  \
    CGSize size = (CGSize){ self.bounds.size.width + onePixelInPoint * 2, self.bounds.size.height + onePixelInPoint * 2 };  \
    _maskLayer = [self prepareMaskLayerInSize:size withDefaultMaskColor:color];  \
    if (!_maskLayer) {  \
        UIBezierPath *maskShape = [self prepareMaskRegionInSize:size];  \
        _maskLayer = [CAShapeLayer maskLayerForBezierPath:maskShape fillColor:color.CGColor];  \
    }  \
    [self.layer addSublayer:_maskLayer];  \
    _maskLayer.position = (CGPoint){ -onePixelInPoint, -onePixelInPoint };  \
}  \
  \
- (BOOL)didChangeMaskValues {  \
    if (!_oldMaskValues) _oldMaskValues = @{}.mutableCopy;  \
        CGSize oldSize = [_oldMaskValues[@"maskSize"] CGSizeValue];  \
        RGBColor oldColor = [_oldMaskValues[@"maskColor"] RGBColorValue];  \
    /* check if size has changed */  \
        BOOL sizeChanged = NO;  \
        if (!CGSizeEqualToSize(oldSize, self.bounds.size)) {  \
            _oldMaskValues[@"maskSize"] = [NSValue valueWithCGSize:self.bounds.size];  \
            sizeChanged = YES;  \
        }  \
    /* check if color has changed */  \
    BOOL colorChanged = NO;  \
    RGBColor newColor = [_maskColor RGBColor];  \
    if (!RGBColorEqualToColor(newColor, oldColor)) {  \
        _oldMaskValues[@"maskColor"] = @(newColor);  \
        colorChanged = YES;  \
    }  \
    return (sizeChanged || colorChanged) ? YES : NO;  \
}  \

#endif // YJ_LAYER_BASED_MASKING_PROTOCOL_DEFAULT_IMPLEMENTATION_FOR_YJMASKEDVIEW_SUBCLASS


/**
 * Must conforms protocol <YJLayerBasedMasking> to your custom UIView subclass
 */
#ifndef YJ_LAYER_BASED_MASKING_PROTOCOL_DEFAULT_IMPLEMENTATION_FOR_YJMASKEDVIEW_SUBCLASS
#define YJ_LAYER_BASED_MASKING_PROTOCOL_DEFAULT_IMPLEMENTATION_FOR_YJMASKEDVIEW_SUBCLASS \
\
        YJ_LAYER_BASED_MASKING_PROTOCOL_DEFAULT_IMPLEMENTATION_FOR_UIVIEW_SUBCLASS \
\
/* for subclasses overriding */ \
\
- (UIBezierPath *)prepareMaskRegionInSize:(CGSize)size { return nil; } \
- (nullable CALayer *)prepareMaskLayerInSize:(CGSize)size withDefaultMaskColor:(UIColor *)maskColor { return nil; } \
\

#endif


#endif /* _YJLayerBasedMasking_h */
