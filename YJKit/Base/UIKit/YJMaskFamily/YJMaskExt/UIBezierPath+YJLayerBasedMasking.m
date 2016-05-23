//
//  UIBezierPath+YJLayerBasedMasking.m
//  YJKit
//
//  Created by huang-kun on 16/5/5.
//  Copyright © 2016年 huang-kun. All rights reserved.
//

#import "UIBezierPath+YJLayerBasedMasking.h"
#import "YJUIMacros.h"

@implementation UIBezierPath (YJLayerBasedMasking)

void (^calculateMaskBoundaries)(CGRect *, CGRect *, UIEdgeInsets);

+ (instancetype)bezierPathWithCircleMaskShapeInSize:(CGSize)size outerFramePath:(UIBezierPath **)framePathPtr innerCirclePath:(UIBezierPath **)circularPathPtr {
    return [self bezierPathWithCircleMaskShapeInSize:size edgeInsets:UIEdgeInsetsZero outerFramePath:framePathPtr innerCirclePath:circularPathPtr];
}

// In iOS 7, calling -[UIBezierPath copy] is not correctly behaved because it does not literally copying the it's path. For iOS 8 and above, it behaves as we expected. So it might be a bug for iOS 7. One solution is using -[UIBezierPath bezierPathWithCGPath:] instead of -[UIBezierPath copy].

+ (instancetype)bezierPathWithCircleMaskShapeInSize:(CGSize)size edgeInsets:(UIEdgeInsets)edgeInsets outerFramePath:(UIBezierPath **)framePathPtr innerCirclePath:(UIBezierPath **)circlePathPtr {
    Class BPClass = [self class];
    CGFloat minValue = MIN(size.width, size.height);
    CGRect frame = (CGRect){ CGPointZero, size };
    CGRect outerSquare = CGRectMake(ABS(minValue - size.width) / 2, ABS(minValue - size.height) / 2, minValue, minValue);
    CGRect maskSquare = UIEdgeInsetsInsetRect(outerSquare, edgeInsets);
    UIBezierPath *framePath = [BPClass bezierPathWithRect:frame];
    UIBezierPath *circlePath = [BPClass bezierPathWithOvalInRect:maskSquare];
    if (kSystemVersion >= 8.0) {
        if (framePathPtr) *framePathPtr = [framePath copy];
        if (circlePathPtr) *circlePathPtr = [circlePath copy];
    } else {
        if (framePathPtr) *framePathPtr = [UIBezierPath bezierPathWithCGPath:framePath.CGPath];
        if (circlePathPtr) *circlePathPtr = [UIBezierPath bezierPathWithCGPath:circlePath.CGPath];
    }
    [framePath appendPath:circlePath];
    return framePath;
}

+ (instancetype)bezierPathWithRoundedCornerMaskShapeInSize:(CGSize)size cornerRadius:(CGFloat)cornerRadius outerFramePath:(UIBezierPath **)framePathPtr innerRoundPath:(UIBezierPath **)roundPathPtr {
    return [self bezierPathWithRoundedCornerMaskShapeInSize:size cornerRadius:cornerRadius edgeInsets:UIEdgeInsetsZero outerFramePath:framePathPtr innerRoundPath:roundPathPtr];
}

+ (instancetype)bezierPathWithRoundedCornerMaskShapeInSize:(CGSize)size cornerRadius:(CGFloat)cornerRadius edgeInsets:(UIEdgeInsets)edgeInsets outerFramePath:(UIBezierPath **)framePathPtr innerRoundPath:(UIBezierPath **)roundPathPtr {
    Class BPClass = [self class];
    CGRect outerFrame = (CGRect){ CGPointZero, size };
    CGRect transparentFrame = UIEdgeInsetsInsetRect(outerFrame, edgeInsets);
    UIBezierPath *framePath = [BPClass bezierPathWithRect:outerFrame];
    UIBezierPath *roundPath = [BPClass bezierPathWithRoundedRect:transparentFrame cornerRadius:cornerRadius];
    if (kSystemVersion >= 8.0) {
        if (framePathPtr) *framePathPtr = [framePath copy];
        if (roundPathPtr) *roundPathPtr = [roundPath copy];
    } else {
        if (framePathPtr) *framePathPtr = [UIBezierPath bezierPathWithCGPath:framePath.CGPath];
        if (roundPathPtr) *roundPathPtr = [UIBezierPath bezierPathWithCGPath:roundPath.CGPath];
    }
    [framePath appendPath:roundPath];
    return framePath;
}

@end
