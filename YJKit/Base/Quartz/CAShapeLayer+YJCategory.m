//
//  CAShapeLayer+YJCategory.m
//  YJKit
//
//  Created by huang-kun on 16/5/5.
//  Copyright © 2016年 huang-kun. All rights reserved.
//

#import "CAShapeLayer+YJCategory.h"
#import "UIBezierPath+YJCategory.h"
#import "YJUIMacros.h"

@implementation CAShapeLayer (YJCategory)

+ (instancetype)maskLayerForBezierPath:(UIBezierPath *)bezierPath fillColor:(CGColorRef)fillColor {
    CAShapeLayer *maskLayer = [self layer];
    maskLayer.fillColor = fillColor;
    maskLayer.fillRule = kCAFillRuleEvenOdd;
    maskLayer.path = bezierPath.CGPath;
    return maskLayer;
}

+ (instancetype)maskLayerForFrameBezierPath:(UIBezierPath *)frameBezierPath shapeBezierPath:(UIBezierPath *)shapeBezierPath fillColor:(CGColorRef)fillColor strokeWidth:(CGFloat)strokeWidth strokeColor:(CGColorRef)strokeColor {
    // create a mask layer
    CAShapeLayer *maskLayer = [self layer];
    maskLayer.fillColor = fillColor;
    maskLayer.fillRule = kCAFillRuleEvenOdd;
    maskLayer.strokeColor = fillColor; // cover the rect path of corner
    maskLayer.lineWidth = strokeWidth;
    UIBezierPath *cornerPath = [shapeBezierPath copy];
    if (kSystemVersion < 8.0) cornerPath = [UIBezierPath bezierPathWithCGPath:shapeBezierPath.CGPath];
    [cornerPath appendPath:frameBezierPath];
    maskLayer.path = cornerPath.CGPath;
    if (!strokeWidth) return maskLayer;
    // if stroke, then create a stroke layer
    CAShapeLayer *strokeLayer = [CAShapeLayer layer];
    strokeLayer.fillColor = nil;
    strokeLayer.strokeColor = strokeColor;
    strokeLayer.lineWidth = strokeWidth;
    strokeLayer.path = shapeBezierPath.CGPath;
    [maskLayer addSublayer:strokeLayer];
    return maskLayer;
}

+ (instancetype)circularMaskLayerInSize:(CGSize)size fillColor:(CGColorRef)fillColor {
    return [self circularMaskLayerInSize:size fillColor:fillColor strokeWidth:0.0f strokeColor:fillColor];
}

// default implementation - shape path is offset by 2 pixels from size boundary
+ (instancetype)circularMaskLayerInSize:(CGSize)size fillColor:(CGColorRef)fillColor strokeWidth:(CGFloat)strokeWidth strokeColor:(CGColorRef)strokeColor {
    UIBezierPath *framePath, *circularPath;
    CGSize innerSize = CGSizeMake(size.width - strokeWidth / 2, size.height - strokeWidth / 2);
    CGFloat twoPixelInPoint = 2 / kUIScreenScale;
    
    [UIBezierPath bezierPathWithCircleMaskShapeInSize:innerSize
                                           edgeInsets:(UIEdgeInsets){ twoPixelInPoint, twoPixelInPoint, twoPixelInPoint, twoPixelInPoint }
                                       outerFramePath:&framePath
                                      innerCirclePath:&circularPath];
    
    return [self maskLayerForFrameBezierPath:framePath
                             shapeBezierPath:circularPath
                                   fillColor:fillColor
                                 strokeWidth:strokeWidth
                                 strokeColor:strokeColor];
}

+ (instancetype)roundedRectMaskLayerInSize:(CGSize)size cornerRadius:(CGFloat)cornerRadius fillColor:(CGColorRef)fillColor {
    return [self roundedRectMaskLayerInSize:size cornerRadius:cornerRadius fillColor:fillColor strokeWidth:0.0f strokeColor:fillColor];
}

// default implementation - shape path is offset by 2 pixels from size boundary
+ (instancetype)roundedRectMaskLayerInSize:(CGSize)size cornerRadius:(CGFloat)cornerRadius fillColor:(CGColorRef)fillColor strokeWidth:(CGFloat)strokeWidth strokeColor:(CGColorRef)strokeColor {
    UIBezierPath *framePath, *roundedPath;
    CGSize innerSize = CGSizeMake(size.width - strokeWidth / 2, size.height - strokeWidth / 2);
    CGFloat twoPixelInPoint = 2 / kUIScreenScale;
    
    [UIBezierPath bezierPathWithRoundedCornerMaskShapeInSize:innerSize
                                                cornerRadius:cornerRadius
                                                  edgeInsets:(UIEdgeInsets){ twoPixelInPoint, twoPixelInPoint, twoPixelInPoint, twoPixelInPoint }
                                              outerFramePath:&framePath
                                              innerRoundPath:&roundedPath];
    
    return [self maskLayerForFrameBezierPath:framePath
                             shapeBezierPath:roundedPath
                                   fillColor:fillColor
                                 strokeWidth:strokeWidth
                                 strokeColor:strokeColor];
}

@end
