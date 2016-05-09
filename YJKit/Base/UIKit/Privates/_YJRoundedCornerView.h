//
//  _YJRoundedCornerView.h
//  YJKit
//
//  Created by huang-kun on 16/5/7.
//  Copyright © 2016年 huang-kun. All rights reserved.
//

#ifndef _YJRoundedCornerView_h
#define _YJRoundedCornerView_h

#import "UIBezierPath+YJCategory.h"
#import "CAShapeLayer+YJCategory.h"

/**
 * Must declare properties: 
    
    CGFloat cornerRadius,
    CGFloat borderWidth, 
    UIColor *borderColor
 
 */
#ifndef YJ_ROUNDED_CORNER_VIEW_DEFAULT_IMPLEMENTATION_FOR_UIVIEW_SUBCLASS
#define YJ_ROUNDED_CORNER_VIEW_DEFAULT_IMPLEMENTATION_FOR_UIVIEW_SUBCLASS \
\
static const CGFloat kYJRoundedCornerViewDefaultCornerRadius = 10.0f; \
\
/* init from code */ \
- (instancetype)initWithFrame:(CGRect)frame { \
    self = [super initWithFrame:frame]; \
    if (self) { \
        _cornerRadius = kYJRoundedCornerViewDefaultCornerRadius; \
    } \
    return self; \
} \
\
/* init from IB */ \
- (instancetype)initWithCoder:(NSCoder *)aDecoder { \
    self = [super initWithCoder:aDecoder]; \
    if (self) { \
        _cornerRadius = kYJRoundedCornerViewDefaultCornerRadius; \
    } \
    return self; \
} \
\
- (void)setCornerRadius:(CGFloat)cornerRadius { \
    if (cornerRadius < 0.0f) cornerRadius = 0.0f; \
        _cornerRadius = cornerRadius; \
        [self updateMaskLayer]; \
} \
\
- (void)setBorderWidth:(CGFloat)borderWidth { \
    if (borderWidth < 0.0f) borderWidth = 0.0f; \
        _borderWidth = borderWidth; \
        [self updateMaskLayer]; \
} \
\
- (void)setBorderColor:(UIColor *)borderColor { \
    _borderColor = borderColor; \
    [self updateMaskLayer]; \
} \
\
- (UIBezierPath *)prepareMaskRegion { \
    CGRect bounds = self.bounds; \
    CGRect rcRect = !CGRectIsEmpty(_transparentFrame) ? _transparentFrame : self.bounds; /* rounded corner rect */ \
    \
    UIEdgeInsets edgeInsets; \
    edgeInsets.top = rcRect.origin.y; \
    edgeInsets.left = rcRect.origin.x; \
    edgeInsets.bottom = bounds.size.height - rcRect.size.height - rcRect.origin.y; \
    edgeInsets.right = bounds.size.width - rcRect.size.width - rcRect.origin.x; \
    \
    return [UIBezierPath bezierPathWithRoundedCornerMaskShapeInSize:bounds.size \
                                                       cornerRadius:self.cornerRadius \
                                                         edgeInsets:edgeInsets \
                                                     outerFramePath:NULL \
                                                   innerRoundedPath:NULL]; \
} \
\
- (nullable CALayer *)prepareMaskLayerWithDefaultMaskColor:(UIColor *)maskColor { \
    if (!self.borderWidth || !self.borderColor) { \
        return nil; \
    } else { \
        CGRect bounds = self.bounds; \
        CGRect rcRect = !CGRectIsEmpty(_transparentFrame) ? _transparentFrame : self.bounds; /* rounded corner rect */ \
        \
        UIEdgeInsets edgeInsets; \
        edgeInsets.top = rcRect.origin.y; \
        edgeInsets.left = rcRect.origin.x; \
        edgeInsets.bottom = bounds.size.height - rcRect.size.height - rcRect.origin.y; \
        edgeInsets.right = bounds.size.width - rcRect.size.width - rcRect.origin.x; \
        \
        CGSize innerSize = CGSizeMake(bounds.size.width - self.borderWidth / 2, bounds.size.height - self.borderWidth / 2); \
        UIBezierPath *framePath, *roundedBorderPath; \
        [UIBezierPath bezierPathWithRoundedCornerMaskShapeInSize:innerSize \
                                                    cornerRadius:self.cornerRadius \
                                                      edgeInsets:edgeInsets \
                                                  outerFramePath:&framePath \
                                                innerRoundedPath:&roundedBorderPath]; \
        \
        return [CAShapeLayer maskLayerForFrameBezierPath:framePath \
                                         shapeBezierPath:roundedBorderPath \
                                               fillColor:maskColor.CGColor \
                                             strokeWidth:self.borderWidth \
                                             strokeColor:self.borderColor.CGColor]; \
    } \
} \

#endif // YJ_ROUNDED_CORNER_VIEW_DEFAULT_IMPLEMENTATION_FOR_YJMASKEDVIEW_SUBCLASS


/**
 * Must declare properties:
 
 CGFloat cornerRadius,
 CGFloat borderWidth,
 UIColor *borderColor
 
 */
#ifndef YJ_ROUNDED_CORNER_VIEW_DEFAULT_IMPLEMENTATION_FOR_YJMASKEDVIEW_SUBCLASS
#define YJ_ROUNDED_CORNER_VIEW_DEFAULT_IMPLEMENTATION_FOR_YJMASKEDVIEW_SUBCLASS \
\
/* @implementation XXRoundedCornerView */{ \
    CGRect _transparentFrame; \
} \
\
        YJ_ROUNDED_CORNER_VIEW_DEFAULT_IMPLEMENTATION_FOR_UIVIEW_SUBCLASS \
\

#endif // YJ_ROUNDED_CORNER_VIEW_DEFAULT_IMPLEMENTATION_FOR_UIVIEW_SUBCLASS


#endif /* _YJRoundedCornerView_h */
