//
//  YJCircularImageView.m
//  YJKit
//
//  Created by huang-kun on 16/4/28.
//  Copyright © 2016年 huang-kun. All rights reserved.
//
//  Reference: https://developer.apple.com/videos/play/wwdc2014/401/

#import "YJCircularImageView.h"
#import "UIBezierPath+YJCategory.h"
#import "CAShapeLayer+YJCategory.h"
#import "YJDebugMacros.h"

@implementation YJCircularImageView

#if YJ_DEBUG
- (void)dealloc {
    NSLog(@"%@ dealloc", self.class);
}
#endif

- (void)setCircleWidth:(CGFloat)circleWidth {
    if (circleWidth < 0.0) circleWidth = 0.0f;
    _circleWidth = circleWidth;
    [self updateMaskLayer];
}

- (void)setCircleColor:(UIColor *)circleColor {
    _circleColor = circleColor;
    [self updateMaskLayer];
}

- (UIBezierPath *)prepareClosedMaskBezierPath {
    return [UIBezierPath bezierPathWithCircleMaskShapeInSize:self.bounds.size outerFramePath:NULL innerCircularPath:NULL];
}

- (nullable CAShapeLayer *)prepareHighlightedMaskShapeLayerWithDefaultMaskColor:(UIColor *)maskColor {
    if (!self.circleWidth || !self.circleColor) {
        return nil;
    } else {
        UIBezierPath *framePath, *circlePath;
        CGSize innerSize = CGSizeMake(self.bounds.size.width - self.circleWidth / 2, self.bounds.size.height - self.circleWidth / 2);
        [UIBezierPath bezierPathWithCircleMaskShapeInSize:innerSize outerFramePath:&framePath innerCircularPath:&circlePath];
        return [CAShapeLayer maskLayerForFrameBezierPath:framePath
                                         shapeBezierPath:circlePath
                                               fillColor:maskColor.CGColor
                                             strokeWidth:self.circleWidth
                                             strokeColor:self.circleColor.CGColor];
    }
}

@end
