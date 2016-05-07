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
#ifndef YJ_LAYER_BASED_MASKING_PROTOCOL_DEFAULT_IMPLEMENTATION_FOR_YJMASKEDVIEW_SUBCLASS
#define YJ_LAYER_BASED_MASKING_PROTOCOL_DEFAULT_IMPLEMENTATION_FOR_YJMASKEDVIEW_SUBCLASS \
\
@synthesize maskLayer = _maskLayer; \
@synthesize maskColor = _maskColor; \
@synthesize maskFrame = _maskFrame; \
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
    CGRect maskRect = !CGRectIsEmpty(self.maskFrame) ? self.maskFrame : self.bounds; \
    self.maskLayer = [self prepareHighlightedMaskShapeLayerInRect:maskRect withDefaultMaskColor:color]; \
    if (!self.maskLayer) { \
        UIBezierPath *maskShape = [self prepareMaskShapePathInRect:maskRect]; \
        self.maskLayer = [CAShapeLayer maskLayerForBezierPath:maskShape fillColor:color.CGColor]; \
    } \
    [self.layer addSublayer:self.maskLayer]; \
} \
\
- (BOOL)isMasked { \
    return self.maskLayer.superlayer ? YES : NO; \
} \
\

#endif // YJ_LAYER_BASED_MASKING_PROTOCOL_DEFAULT_IMPLEMENTATION_FOR_UIVIEW_SUBCLASS


/**
 * Must conforms protocol <YJLayerBasedMasking> to your custom UIView subclass
 */
#ifndef YJ_LAYER_BASED_MASKING_PROTOCOL_DEFAULT_IMPLEMENTATION_FOR_UIVIEW_SUBCLASS
#define YJ_LAYER_BASED_MASKING_PROTOCOL_DEFAULT_IMPLEMENTATION_FOR_UIVIEW_SUBCLASS \
\
        YJ_LAYER_BASED_MASKING_PROTOCOL_DEFAULT_IMPLEMENTATION_FOR_YJMASKEDVIEW_SUBCLASS \
\
/* for subclasses overriding */ \
\
- (UIBezierPath *)prepareMaskShapePathInRect:(CGRect)rect { return nil; } \
- (nullable CAShapeLayer *)prepareHighlightedMaskShapeLayerInRect:(CGRect)rect withDefaultMaskColor:(UIColor *)maskColor { return nil; } \
\

#endif


#endif /* _YJLayerBasedMasking_h */
