//
//  YJRoundedCornerImageView.m
//  YJKit
//
//  Created by huang-kun on 16/4/28.
//  Copyright © 2016年 huang-kun. All rights reserved.
//

#import "YJRoundedCornerImageView.h"
#import "UIBezierPath+YJCategory.h"
#import "CAShapeLayer+YJCategory.h"

static const CGFloat kYJRoundedCornerImageViewDefaultCornerRadius = 10.0f;

@implementation YJRoundedCornerImageView

// init from code
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _cornerRadius = kYJRoundedCornerImageViewDefaultCornerRadius;
    }
    return self;
}

// init from IB
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        _cornerRadius = kYJRoundedCornerImageViewDefaultCornerRadius;
    }
    return self;
}

- (void)setCornerRadius:(CGFloat)cornerRadius {
    if (cornerRadius < 0.0f) cornerRadius = 0.0f;
    _cornerRadius = cornerRadius;
    if (self.image) [self updateMaskLayer];
}

- (void)setBorderWidth:(CGFloat)borderWidth {
    if (borderWidth < 0.0f) borderWidth = 0.0f;
    _borderWidth = borderWidth;
    if (self.image) [self updateMaskLayer];
}

- (void)setBorderColor:(UIColor *)borderColor {
    _borderColor = borderColor;
    if (self.image) [self updateMaskLayer];
}

- (UIBezierPath *)prepareClosedMaskBezierPath {
    return [UIBezierPath bezierPathWithRoundedCornerMaskShapeInSize:self.bounds.size cornerRadius:self.cornerRadius outerFramePath:NULL innerRoundedPath:NULL];
}

- (nullable CAShapeLayer *)prepareHighlightedMaskShapeLayerWithDefaultMaskColor:(UIColor *)maskColor {
    if (!self.borderWidth || !self.borderColor) {
        return nil;
    } else {
        UIBezierPath *framePath, *roundedBorderPath;
        CGSize innerSize = CGSizeMake(self.bounds.size.width - self.borderWidth / 2, self.bounds.size.height - self.borderWidth / 2);
        [UIBezierPath bezierPathWithRoundedCornerMaskShapeInSize:innerSize cornerRadius:self.cornerRadius outerFramePath:&framePath innerRoundedPath:&roundedBorderPath];
        return [CAShapeLayer maskLayerForFrameBezierPath:framePath
                                         shapeBezierPath:roundedBorderPath
                                               fillColor:maskColor.CGColor
                                             strokeWidth:self.borderWidth
                                             strokeColor:self.borderColor.CGColor];
    }
}

@end
