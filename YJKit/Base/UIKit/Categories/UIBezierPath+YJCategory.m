//
//  UIBezierPath+YJCategory.m
//  YJKit
//
//  Created by huang-kun on 16/5/5.
//  Copyright © 2016年 huang-kun. All rights reserved.
//

#import "UIBezierPath+YJCategory.h"

@implementation UIBezierPath (YJCategory)

void (^calculateMaskBoundaries)(CGRect *, CGRect *, UIEdgeInsets);

+ (instancetype)bezierPathWithCircleMaskShapeInSize:(CGSize)size outerFramePath:(UIBezierPath **)framePathPtr innerCircularPath:(UIBezierPath **)circularPathPtr {
    return [self bezierPathWithCircleMaskShapeInSize:size edgeInsets:UIEdgeInsetsZero outerFramePath:framePathPtr innerCircularPath:circularPathPtr];
}

+ (instancetype)bezierPathWithCircleMaskShapeInSize:(CGSize)size edgeInsets:(UIEdgeInsets)edgeInsets outerFramePath:(UIBezierPath **)framePathPtr innerCircularPath:(UIBezierPath **)circularPathPtr {
    Class BPClass = [self class];
    CGFloat minValue = MIN(size.width, size.height);
    CGRect frame = (CGRect){ CGPointZero, size };
    CGRect outerSquare = CGRectMake(ABS(minValue - size.width) / 2, ABS(minValue - size.height) / 2, minValue, minValue);
    CGRect maskSquare = UIEdgeInsetsInsetRect(outerSquare, edgeInsets);
    UIBezierPath *framePath = [BPClass bezierPathWithRect:frame];
    UIBezierPath *circularPath = [BPClass bezierPathWithOvalInRect:maskSquare];
    if (framePathPtr) *framePathPtr = [framePath copy];
    if (circularPathPtr) *circularPathPtr = [circularPath copy];
    [framePath appendPath:circularPath];
    return framePath;
}

+ (instancetype)bezierPathWithRoundedCornerMaskShapeInSize:(CGSize)size cornerRadius:(CGFloat)cornerRadius outerFramePath:(UIBezierPath **)framePathPtr innerRoundedPath:(UIBezierPath **)roundedPathPtr {
    return [self bezierPathWithRoundedCornerMaskShapeInSize:size cornerRadius:cornerRadius edgeInsets:UIEdgeInsetsZero outerFramePath:framePathPtr innerRoundedPath:roundedPathPtr];
}

+ (instancetype)bezierPathWithRoundedCornerMaskShapeInSize:(CGSize)size cornerRadius:(CGFloat)cornerRadius edgeInsets:(UIEdgeInsets)edgeInsets outerFramePath:(UIBezierPath **)framePathPtr innerRoundedPath:(UIBezierPath **)roundedPathPtr {
    Class BPClass = [self class];
    CGRect outerFrame = (CGRect){ CGPointZero, size };
    CGRect transparentFrame = UIEdgeInsetsInsetRect(outerFrame, edgeInsets);
    UIBezierPath *framePath = [BPClass bezierPathWithRect:outerFrame];
    UIBezierPath *roundedPath = [BPClass bezierPathWithRoundedRect:transparentFrame cornerRadius:cornerRadius];
    if (framePathPtr) *framePathPtr = [framePath copy];
    if (roundedPathPtr) *roundedPathPtr = [roundedPath copy];
    [framePath appendPath:roundedPath];
    return framePath;
}

@end
