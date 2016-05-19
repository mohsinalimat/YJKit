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
#import "YJUIMacros.h"

/**
 * Must declare properties: 
    
    CGFloat cornerRadius,
    CGFloat borderWidth, 
    UIColor *borderColor
 
 */
#ifndef YJ_ROUNDED_CORNER_VIEW_DEFAULT_IMPLEMENTATION_FOR_UIVIEW_SUBCLASS_WITH_EXTRA_INIT
#define YJ_ROUNDED_CORNER_VIEW_DEFAULT_IMPLEMENTATION_FOR_UIVIEW_SUBCLASS_WITH_EXTRA_INIT(EXTRA_INIT) \
\
static const CGFloat kYJRoundedCornerViewDefaultCornerRadius = 10.0f;   \
\
/* init from code */   \
- (instancetype)initWithFrame:(CGRect)frame {   \
    self = [super initWithFrame:frame];   \
    if (self) {   \
        _cornerRadius = kYJRoundedCornerViewDefaultCornerRadius;   \
        EXTRA_INIT \
    }   \
    return self;   \
}   \
\
/* init from IB */   \
- (instancetype)initWithCoder:(NSCoder *)aDecoder {   \
    self = [super initWithCoder:aDecoder];   \
    if (self) {   \
        _cornerRadius = kYJRoundedCornerViewDefaultCornerRadius;   \
        EXTRA_INIT \
    }   \
    return self;   \
}   \
\
- (void)setCornerRadius:(CGFloat)cornerRadius {   \
    if (cornerRadius < 0.0f) cornerRadius = 0.0f;   \
        _cornerRadius = cornerRadius;   \
        [self updateMaskLayer];   \
}   \
\
- (void)setBorderWidth:(CGFloat)borderWidth {   \
    if (borderWidth < 0.0f) borderWidth = 0.0f;   \
        _borderWidth = borderWidth;   \
        [self updateMaskLayer];   \
}   \
\
- (void)setBorderColor:(UIColor *)borderColor {   \
    _borderColor = borderColor;   \
    [self updateMaskLayer];   \
}   \
\
- (UIBezierPath *)prepareMaskRegionInSize:(CGSize)size {  \
    /* rounded corner rect */  \
    CGRect rcRect = !CGRectIsEmpty(_transparentFrame) ? _transparentFrame : (CGRect){ CGPointZero, size };  \
    CGFloat twoPixelInPoint = 2 / kUIScreenScale;  \
      \
    UIEdgeInsets edgeInsets;  \
    edgeInsets.top = rcRect.origin.y + twoPixelInPoint;  \
    edgeInsets.left = rcRect.origin.x + twoPixelInPoint;  \
    edgeInsets.bottom = size.height - rcRect.size.height - rcRect.origin.y + twoPixelInPoint;  \
    edgeInsets.right = size.width - rcRect.size.width - rcRect.origin.x + twoPixelInPoint;  \
      \
    return [UIBezierPath bezierPathWithRoundedCornerMaskShapeInSize:size  \
                                                       cornerRadius:self.cornerRadius  \
                                                         edgeInsets:edgeInsets  \
                                                     outerFramePath:NULL  \
                                                     innerRoundPath:NULL];  \
}  \
\
- (nullable CALayer *)prepareMaskLayerInSize:(CGSize)size withDefaultMaskColor:(UIColor *)maskColor {  \
    if (!self.borderWidth || !self.borderColor) {  \
        return nil;  \
    } else {  \
        /* rounded corner rect */  \
        CGRect rcRect = !CGRectIsEmpty(_transparentFrame) ? _transparentFrame : (CGRect){ CGPointZero, size };  \
        CGFloat twoPixelInPoint = 2 / kUIScreenScale;  \
          \
        UIEdgeInsets edgeInsets;  \
        edgeInsets.top = rcRect.origin.y + twoPixelInPoint;  \
        edgeInsets.left = rcRect.origin.x + twoPixelInPoint;  \
        edgeInsets.bottom = size.height - rcRect.size.height - rcRect.origin.y + twoPixelInPoint;  \
        edgeInsets.right = size.width - rcRect.size.width - rcRect.origin.x + twoPixelInPoint;  \
          \
        CGSize innerSize = CGSizeMake(size.width - self.borderWidth / 2, size.height - self.borderWidth / 2);  \
        UIBezierPath *framePath, *roundedBorderPath;  \
        [UIBezierPath bezierPathWithRoundedCornerMaskShapeInSize:innerSize  \
                                                    cornerRadius:self.cornerRadius  \
                                                      edgeInsets:edgeInsets  \
                                                  outerFramePath:&framePath  \
                                                  innerRoundPath:&roundedBorderPath];  \
          \
        return [CAShapeLayer maskLayerForFrameBezierPath:framePath  \
                                         shapeBezierPath:roundedBorderPath  \
                                               fillColor:maskColor.CGColor  \
                                             strokeWidth:self.borderWidth  \
                                             strokeColor:self.borderColor.CGColor];  \
    }  \
}  \

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


#ifndef YJ_ROUNDED_CORNER_VIEW_DEFAULT_IMPLEMENTATION_FOR_UIVIEW_SUBCLASS
#define YJ_ROUNDED_CORNER_VIEW_DEFAULT_IMPLEMENTATION_FOR_UIVIEW_SUBCLASS \
        YJ_ROUNDED_CORNER_VIEW_DEFAULT_IMPLEMENTATION_FOR_UIVIEW_SUBCLASS_WITH_EXTRA_INIT()
#endif


#endif /* _YJRoundedCornerView_h */
