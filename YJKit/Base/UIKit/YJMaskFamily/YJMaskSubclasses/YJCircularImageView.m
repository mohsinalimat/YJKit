//
//  YJCircularImageView.m
//  YJKit
//
//  Created by huang-kun on 16/4/28.
//  Copyright © 2016年 huang-kun. All rights reserved.
//
//  Reference: https://developer.apple.com/videos/play/wwdc2014/401/ (CircularImageView demo)

#import "YJCircularImageView.h"
#import "UIBezierPath+YJLayerBasedMasking.h"
#import "CAShapeLayer+YJLayerBasedMasking.h"
#import "NSObject+YJCodingExtension.h"
#import "YJDebugMacros.h"
#import "YJUIMacros.h"

@implementation YJCircularImageView

#pragma mark - life

#if YJ_DEBUG
- (void)dealloc {
    NSLog(@"%@ dealloc", self.class);
}
#endif

- (nullable instancetype)initWithCoder:(NSCoder *)decoder {
    self = [super initWithCoder:decoder];
    if (self) [self decodeIvarListWithCoder:decoder];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)coder {
    [self encodeIvarListWithCoder:coder];
    [super encodeWithCoder:coder];
}

#pragma mark - accessors

- (void)setCircleWidth:(CGFloat)circleWidth {
    if (circleWidth < 0.0) circleWidth = 0.0f;
    _circleWidth = circleWidth;
    [self updateMaskLayer];
}

- (void)setCircleColor:(UIColor *)circleColor {
    _circleColor = circleColor;
    [self updateMaskLayer];
}

#pragma mark - YJLayerBasedMasking

- (UIBezierPath *)prepareMaskRegionInSize:(CGSize)size {
    CGFloat twoPixelInPoint = 2 / kUIScreenScale;
    return [UIBezierPath bezierPathWithCircleMaskShapeInSize:size
                                                  edgeInsets:(UIEdgeInsets){ twoPixelInPoint, twoPixelInPoint, twoPixelInPoint, twoPixelInPoint }
                                              outerFramePath:NULL
                                             innerCirclePath:NULL];
}

- (nullable CALayer *)prepareMaskLayerInSize:(CGSize)size withDefaultMaskColor:(UIColor *)maskColor {
    if (!self.circleWidth || !self.circleColor) {
        return nil;
    } else {
        CGFloat twoPixelInPoint = 2 / kUIScreenScale;
        
        UIBezierPath *framePath, *circlePath;
        [UIBezierPath bezierPathWithCircleMaskShapeInSize:size
                                               edgeInsets:(UIEdgeInsets){ twoPixelInPoint, twoPixelInPoint, twoPixelInPoint, twoPixelInPoint }
                                           outerFramePath:&framePath
                                          innerCirclePath:&circlePath];
        
        return [CAShapeLayer maskLayerForFrameBezierPath:framePath
                                         shapeBezierPath:circlePath
                                               fillColor:maskColor.CGColor
                                             strokeWidth:self.circleWidth
                                             strokeColor:self.circleColor.CGColor];
    }
}

@end
