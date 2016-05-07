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
/* @implementation XXMaskedView */{ \
    CALayer *_maskLayer; \
    UIColor *_maskColor; \
    CGRect _transparentFrame; \
} \
\
/* generate internal properties */ \
\
/* @property (nonatomic, strong, nullable) CALayer *maskLayer; */ \
/* @property (nonatomic, strong, nullable) UIColor *maskColor; */ \
/* @property (nonatomic, assign) CGRect transparentFrame; */ \
\
- (void)setMaskLayer:(CALayer *)maskLayer { \
    _maskLayer = maskLayer; \
} \
\
- (CALayer *)maskLayer { \
    return _maskLayer; \
} \
\
- (void)setMaskColor:(UIColor *)maskColor { \
    _maskColor = maskColor; \
} \
\
- (UIColor *)maskColor { \
    return _maskColor; \
} \
\
- (void)setTransparentFrame:(CGRect)transparentFrame { \
    _transparentFrame = transparentFrame; \
} \
\
- (CGRect)transparentFrame { \
    return _transparentFrame; \
} \
\
/* override view hierarchy */ \
\
- (void)willMoveToSuperview:(nullable UIView *)newSuperview { \
    [super willMoveToSuperview:newSuperview]; \
    if (!newSuperview) return; \
    /* added to superview */ \
    if (newSuperview.backgroundColor) { \
        self.maskColor = newSuperview.backgroundColor; \
        [self updateMaskLayer]; \
        return; \
    } \
    [newSuperview addObservedKeyPath:@"backgroundColor" handleSetup:^(id  _Nonnull object, id  _Nullable newValue) { \
        if (self.superview == object && newValue && [newValue isKindOfClass:[UIColor class]]) { /* not go in from design phase.*/ \
            if (![self.maskColor isEqualToRGBColor:newValue]) { \
                self.maskColor = newValue; \
                [self updateMaskLayer]; \
            } \
        } \
    }]; \
} \
\
- (void)removeFromSuperview { \
    self.maskColor = nil; \
    [self.superview removeObservedKeyPath:@"backgroundColor"]; \
    [super removeFromSuperview]; \
} \
\
/* override setters */ \
\
- (void)setFrame:(CGRect)frame { \
    BOOL sizeChanged = NO; \
    CGSize oldSize = super.frame.size; \
    if (!CGSizeEqualToSize(oldSize, frame.size)) sizeChanged = YES; \
    [super setFrame:frame]; \
    if (sizeChanged) [self updateMaskLayer]; \
} \
\
/* masking */ \
\
- (void)updateMaskLayer { \
    [self.maskLayer removeFromSuperlayer]; \
    [self _configureMaskLayerWithColor:self.maskColor]; \
} \
\
- (void)_configureMaskLayerWithColor:(UIColor *)color { \
    if (self.isMasked || !color) return; \
    self.maskLayer = [self prepareMaskLayerWithDefaultMaskColor:color]; \
    if (!self.maskLayer) { \
        UIBezierPath *maskShape = [self prepareMaskRegion]; \
        self.maskLayer = [CAShapeLayer maskLayerForBezierPath:maskShape fillColor:color.CGColor]; \
    } \
    [self.layer addSublayer:self.maskLayer]; \
} \
\
- (BOOL)isMasked { \
    return self.maskLayer.superlayer ? YES : NO; \
} \
\

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
- (UIBezierPath *)prepareMaskRegion { return nil; } \
- (nullable CALayer *)prepareMaskLayerWithDefaultMaskColor:(UIColor *)maskColor { return nil; } \
\

#endif


#endif /* _YJLayerBasedMasking_h */
