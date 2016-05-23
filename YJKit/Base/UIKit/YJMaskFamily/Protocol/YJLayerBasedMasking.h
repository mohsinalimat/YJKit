//
//  YJLayerBasedMasking.h
//  YJKit
//
//  Created by huang-kun on 16/5/7.
//  Copyright © 2016年 huang-kun. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/**
 * This is a protocol for rendering the shape layer based custom mask on UIView object. Any subclass of UIView can conform this protocol.
 */
@protocol YJLayerBasedMasking <NSObject>

/// Call this method to update mask layer for both design phase and runtime.
- (void)updateMaskLayer;

/// Returns an UIBezierPath object which for rendering masked CAShapeLayer object at runtime.
/// The mask region will be rendered in self's boundary, the size parameter is slightly larger than the boundary.
- (UIBezierPath *)prepareMaskRegionInSize:(CGSize)size;

/// Returns an CALayer object with custom mask shape which for rendering at runtime.
/// The mask region will be rendered in self's boundary, the size parameter is slightly larger than the boundary.
/// Notice: Returning a nonnull CAShapeLayer object will ignore the UIBezierPath object from -prepareMaskRegionInSize:
- (nullable CALayer *)prepareMaskLayerInSize:(CGSize)size withDefaultMaskColor:(UIColor *)maskColor;

@optional

/// Specify a mask color instead of default color. Normally, a UIView object will take it's superview's background color as it's mask color. If it's superview does not have a background color, then there will be no mask effect, except you can manually specify a UIColor object here.
/// Notice: Call -[view setMaskColor:aColor] will ignore it's superview's background color changing.
///         Call -[view setMaskColor:nil] will set mask color back to it's superview's background color.
@property (nonatomic, strong, nullable) UIColor *maskColor;

@end

NS_ASSUME_NONNULL_END
