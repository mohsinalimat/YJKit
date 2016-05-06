//
//  YJMaskedView.h
//  YJKit
//
//  Created by huang-kun on 16/5/6.
//  Copyright © 2016年 huang-kun. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YJMaskedView : UIView

/// Call this method to update mask layer for both design phase and runtime.
- (void)updateMaskLayer;

/// Override: returns an UIBezierPath object which for rendering masked CAShapeLayer object at runtime.
- (UIBezierPath *)prepareClosedMaskBezierPath;

/// Override: returns an CAShapeLayer object with highlighted mask shape which for rendering at runtime. Returns a nonnull object will ignore the -prepareClosedMaskBezierPath;
- (nullable CAShapeLayer *)prepareHighlightedMaskShapeLayerWithDefaultMaskColor:(UIColor *)maskColor;

@end

NS_ASSUME_NONNULL_END