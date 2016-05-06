//
//  YJRoundedCornerView.m
//  YJKit
//
//  Created by huang-kun on 16/5/6.
//  Copyright © 2016年 huang-kun. All rights reserved.
//

#import "YJRoundedCornerView.h"
#import "UIBezierPath+YJCategory.h"
#import "CAShapeLayer+YJCategory.h"

static const CGFloat kYJRoundedCornerViewDefaultCornerRadius = 10.0f;

@implementation YJRoundedCornerView

// init from code
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _cornerRadius = kYJRoundedCornerViewDefaultCornerRadius;
    }
    return self;
}

// init from IB
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        _cornerRadius = kYJRoundedCornerViewDefaultCornerRadius;
    }
    return self;
}

- (void)setCornerRadius:(CGFloat)cornerRadius {
    if (cornerRadius < 0.0f) cornerRadius = 0.0f;
    _cornerRadius = cornerRadius;
    [self updateUIForInterfaceBuilder];
}

- (void)updateUIForInterfaceBuilder {
#if TARGET_INTERFACE_BUILDER
    self.layer.cornerRadius = self.cornerRadius;
#endif
    [super updateUIForInterfaceBuilder];
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
