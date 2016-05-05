//
//  YJMaskedImageView.h
//  YJKit
//
//  Created by huang-kun on 16/5/5.
//  Copyright © 2016年 huang-kun. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YJMaskedImageView : UIImageView

/// refresh UI for design phase.
- (void)updateUIForInterfaceBuilder;

/// Override: returns an masked UIImage object which for rendering at IBDesignable phase. It will be called after imageView.image being set.
- (UIImage *)prepareMaskedImageForInterfaceBuilder;

/// Override: returns an UIBezierPath object which for rendering masked CAShapeLayer object at runtime.
- (UIBezierPath *)prepareClosedBezierPathForRenderingMask;

/// Override: returns an CAShapeLayer object with highlighted mask shape which for rendering at runtime. Returns a nonnull object will ignore the -prepareClosedBezierPathForRenderingMask;
- (nullable CAShapeLayer *)prepareHighlightedMaskShapeLayerWithDefaultMaskColor:(UIColor *)maskColor;

@end

NS_ASSUME_NONNULL_END