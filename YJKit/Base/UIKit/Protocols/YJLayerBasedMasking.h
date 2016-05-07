//
//  YJLayerBasedMasking.h
//  YJKit
//
//  Created by huang-kun on 16/5/7.
//  Copyright © 2016年 huang-kun. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol YJLayerBasedMasking <NSObject>

@property (nonatomic, strong) CAShapeLayer *maskLayer;
@property (nonatomic, strong, nullable) UIColor *maskColor;
@property (nonatomic, assign) CGRect maskFrame;

/// Call this method to update mask layer for both design phase and runtime.
- (void)updateMaskLayer;

/// Returns an UIBezierPath object which for rendering masked CAShapeLayer object at runtime.
- (UIBezierPath *)prepareMaskShapePathInRect:(CGRect)rect;

/// Returns an CAShapeLayer object with highlighted mask shape which for rendering at runtime. Returns a nonnull object will ignore the -prepareClosedMaskBezierPath;
- (nullable CAShapeLayer *)prepareHighlightedMaskShapeLayerInRect:(CGRect)rect withDefaultMaskColor:(UIColor *)maskColor;

@end

NS_ASSUME_NONNULL_END






