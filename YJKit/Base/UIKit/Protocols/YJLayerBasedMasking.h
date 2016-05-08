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
 * This is a protocol for rendering the layer based custom mask on UIView object. Any subclass of UIView can conform this protocol.
 */
@protocol YJLayerBasedMasking <NSObject>

/// Call this method to update mask layer for both design phase and runtime.
- (void)updateMaskLayer;

/// Returns an UIBezierPath object which for rendering masked CAShapeLayer object at runtime.
/// The mask region will be rendered in self's boundary.
- (UIBezierPath *)prepareMaskRegion;

/// Returns an CALayer object with custom mask shape which for rendering at runtime.
/// The mask layer will be rendered in self's boundary.
/// Notice: Returning a nonnull CAShapeLayer object will ignore the UIBezierPath object from -prepareMaskRegion;
- (nullable CALayer *)prepareMaskLayerWithDefaultMaskColor:(UIColor *)maskColor;

@end

NS_ASSUME_NONNULL_END






