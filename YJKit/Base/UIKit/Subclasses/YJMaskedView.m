//
//  YJMaskedView.m
//  YJKit
//
//  Created by huang-kun on 16/5/6.
//  Copyright © 2016年 huang-kun. All rights reserved.
//

#import "YJMaskedView.h"
#import "NSObject+YJCategory_KVO.h"
#import "CAShapeLayer+YJCategory.h"
#import "UIColor+YJCategory.h"
#import "YJDebugMacros.h"
#import "YJConfigureMacros.h"

@interface YJMaskedView ()
@property (nonatomic, strong) CAShapeLayer *maskLayer;
@property (nonatomic, strong) UIColor *maskColor;
@end

@implementation YJMaskedView

#if YJ_DEBUG
- (void)dealloc {
    NSLog(@"%@ dealloc", self.class);
}
#endif

#pragma mark - override view hierarchy

- (void)willMoveToSuperview:(nullable UIView *)newSuperview {
    [super willMoveToSuperview:newSuperview];
    if (!newSuperview) return;
    // added to superview
    if (newSuperview.backgroundColor) {
        self.maskColor = newSuperview.backgroundColor;
        [self updateMaskLayer];
        return;
    }
    [newSuperview addObservedKeyPath:@"backgroundColor" handleSetup:^(id  _Nonnull object, id  _Nullable newValue) {
        if (self.superview == object && newValue && [newValue isKindOfClass:[UIColor class]]) { // not go in from design phase.
            if (![self.maskColor isEqualToRGBColor:newValue]) {
                self.maskColor = newValue;
                [self updateMaskLayer];
            }
        }
    }];
}

- (void)removeFromSuperview {
    self.maskColor = nil;
    [self.superview removeObservedKeyPath:@"backgroundColor"];
    [super removeFromSuperview];
}

#pragma mark - override setters

- (void)setFrame:(CGRect)frame {
    BOOL sizeChanged = NO;
    CGSize oldSize = super.frame.size;
    if (!CGSizeEqualToSize(oldSize, frame.size)) sizeChanged = YES;
    [super setFrame:frame];
    if (sizeChanged) [self updateMaskLayer];
}

#pragma mark - masking

// #if TARGET_INTERFACE_BUILDER
// Compiler won't warn you if you make typos under TARGET_INTERFACE_BUILDER. So if you failed to build Xcode for IBDesignable phase by selecting Xcode menu bar (in interface builder, either .storyboard or .xib) -> Editor -> Debug Selected Views, then check your code under TARGET_INTERFACE_BUILDER.
// #endif

- (void)updateMaskLayer {
    [self.maskLayer removeFromSuperlayer];
    [self _configureMaskLayerWithColor:self.maskColor];
}

- (void)_configureMaskLayerWithColor:(UIColor *)color {
    if (self.isMasked || !color) return;
    self.maskLayer = [self prepareHighlightedMaskShapeLayerWithDefaultMaskColor:color];
    if (!self.maskLayer) {
        UIBezierPath *maskShape = [self prepareClosedMaskBezierPath];
        self.maskLayer = [CAShapeLayer maskLayerForBezierPath:maskShape fillColor:color.CGColor];
    }
    [self.layer addSublayer:self.maskLayer];
}

- (BOOL)isMasked {
    return self.maskLayer.superlayer ? YES : NO;
}

#pragma mark - subclasses overriding

- (UIBezierPath *)prepareClosedMaskBezierPath { return nil; }
- (nullable CAShapeLayer *)prepareHighlightedMaskShapeLayerWithDefaultMaskColor:(UIColor *)maskColor { return nil; }

@end
