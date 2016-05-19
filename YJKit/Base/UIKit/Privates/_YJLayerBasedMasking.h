//
//  _YJLayerBasedMasking.h
//  YJKit
//
//  Created by huang-kun on 16/5/7.
//  Copyright © 2016年 huang-kun. All rights reserved.
//

#ifndef _YJLayerBasedMasking_h
#define _YJLayerBasedMasking_h


// #if TARGET_INTERFACE_BUILDER
// Compiler won't warn you if you make typos under TARGET_INTERFACE_BUILDER. So if you failed to build Xcode for IBDesignable phase by selecting Xcode menu bar (in interface builder, either .storyboard or .xib) -> Editor -> Debug Selected Views, then check your code under TARGET_INTERFACE_BUILDER.
// #endif

#import "NSObject+YJCategory_KVO.h"
#import "CAShapeLayer+YJCategory.h"
#import "UIColor+YJCategory.h"

/**
 * Must declare a kind of YJMaskView abstract class which conforms protocol <YJLayerBasedMasking>
 * Then declare a custom mask view which inherits that abstract class.
 */
#ifndef YJ_LAYER_BASED_MASKING_PROTOCOL_DEFAULT_IMPLEMENTATION_FOR_UIVIEW_SUBCLASS
#define YJ_LAYER_BASED_MASKING_PROTOCOL_DEFAULT_IMPLEMENTATION_FOR_UIVIEW_SUBCLASS \
\
/* @implementation XXMaskedView */{    \
    CALayer *_maskLayer;    \
    CGRect _transparentFrame;    \
    BOOL _didFirstLayout;    \
}    \
\
@synthesize maskColor = _maskColor;    \
\
- (void)setMaskColor:(UIColor *)maskColor {    \
    if (![_maskColor isEqualToRGBColor:maskColor]) {    \
        _maskColor = maskColor;    \
        [self updateMaskLayer];    \
    }    \
}    \
\
/* override view hierarchy */    \
\
- (void)willMoveToSuperview:(nullable UIView *)newSuperview {    \
    [super willMoveToSuperview:newSuperview];    \
    if (!newSuperview) return;    \
    /* added to superview */    \
    if (newSuperview.backgroundColor) {    \
        self.maskColor = newSuperview.backgroundColor;    \
        [self updateMaskLayer];    \
    }    \
    [newSuperview addObservedKeyPath:@"backgroundColor" handleSetup:^(id  _Nonnull object, id  _Nullable newValue) {    \
        if (self.superview == object && newValue && [newValue isKindOfClass:[UIColor class]]) { /* not go in from design phase.*/    \
            if (![self.maskColor isEqualToRGBColor:newValue]) {    \
                self.maskColor = newValue;    \
                [self updateMaskLayer];    \
            }    \
        }    \
    }];    \
}    \
\
- (void)removeFromSuperview {    \
    self.maskColor = nil;    \
    [self.superview removeObservedKeyPath:@"backgroundColor"];    \
    [super removeFromSuperview];    \
}    \
\
/* override layouts (e.g. update auto-layout constraints or view's size changed) */    \
\
- (void)layoutSubviews {    \
    [super layoutSubviews];    \
    _didFirstLayout = YES;    \
    [self updateMaskLayer];    \
}    \
\
/* masking */    \
\
- (void)updateMaskLayer {    \
    if (!_didFirstLayout) return;    \
    [_maskLayer removeFromSuperlayer];    \
    [self _configureMaskLayerWithColor:self.maskColor];    \
}    \
\
- (void)_configureMaskLayerWithColor:(UIColor *)color {    \
    if (_maskLayer.superlayer || !color) return;  \
    CGSize size = (CGSize){ self.bounds.size.width + 2, self.bounds.size.height + 2 };  \
    _maskLayer = [self prepareMaskLayerInSize:size withDefaultMaskColor:color];  \
    if (!_maskLayer) {    \
        UIBezierPath *maskShape = [self prepareMaskRegionInSize:size];  \
        _maskLayer = [CAShapeLayer maskLayerForBezierPath:maskShape fillColor:color.CGColor];  \
    }  \
    [self.layer addSublayer:_maskLayer];  \
    _maskLayer.position = (CGPoint){ -1, -1 };  \
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
