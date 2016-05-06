//
//  YJMaskedImageView.h
//  YJKit
//
//  Created by huang-kun on 16/5/5.
//  Copyright © 2016年 huang-kun. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/**
 * This is an ABSTRACT class for displaying image with masked effect. For performance reason, it will not re-render the image for masking.
 */
@interface YJMaskedImageView : UIImageView

/// Call this method to update mask layer for both design phase and runtime.
- (void)updateMaskLayer;

/// Override: returns an UIBezierPath object which for rendering masked CAShapeLayer object at runtime.
- (UIBezierPath *)prepareMaskShapePathInRect:(CGRect)rect;

/// Override: returns an CAShapeLayer object with highlighted mask shape which for rendering at runtime. Returns a nonnull object will ignore the -prepareClosedMaskBezierPath;
- (nullable CAShapeLayer *)prepareHighlightedMaskShapeLayerInRect:(CGRect)rect withDefaultMaskColor:(UIColor *)maskColor;

@end

NS_ASSUME_NONNULL_END
