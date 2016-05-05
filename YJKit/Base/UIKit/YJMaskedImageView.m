//
//  YJMaskedImageView.m
//  YJKit
//
//  Created by huang-kun on 16/5/5.
//  Copyright © 2016年 huang-kun. All rights reserved.
//

#import "YJMaskedImageView.h"
#import "NSObject+YJCategory_KVO.h"
#import "CAShapeLayer+YJCategory.h"
#import "UIDevice+YJCategory.h"
#import "YJDebugMacros.h"

@implementation YJMaskedImageView

#pragma mark - init & dealloc

// init from code
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // ...
    }
    return self;
}

// init from IB
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        if ([self image]) [self setImage:[self image]];
    }
    return self;
}

#if YJ_DEBUG
- (void)dealloc {
    NSLog(@"%@ dealloc", self.class);
}
#endif

#pragma mark - life cycle

- (void)willMoveToSuperview:(nullable UIView *)newSuperview {
    [super willMoveToSuperview:newSuperview];
    if (!newSuperview) return;
    // added to superview
    if (newSuperview.backgroundColor) {
        [self _displayMaskedImageWithCornerColor:newSuperview.backgroundColor];
        return;
    }
    [newSuperview addObservedKeyPath:@"backgroundColor" handleSetup:^(id  _Nonnull object, id  _Nullable newValue) {
        if (self.superview == object && newValue) [self _displayMaskedImageWithCornerColor:newValue]; // not go in from design phase.
    }];
}

- (void)removeFromSuperview {
    [self.superview removeObservedKeyPath:@"backgroundColor"];
    [super removeFromSuperview];
}

#pragma mark - modifying

- (void)setImage:(UIImage *)image {
    [super setImage:image];
    if (!image) return;
    self.backgroundColor = nil;
    [self updateUIForInterfaceBuilder];
}

- (void)updateUIForInterfaceBuilder {
#if TARGET_INTERFACE_BUILDER
    // Compiler won't warn you if you make typos under TARGET_INTERFACE_BUILDER. So if you failed
    // to build Xcode for IBDesignable phase, check your code under TARGET_INTERFACE_BUILDER.
    UIImage *maskedImage = [self prepareMaskedImageForInterfaceBuilder];
    [super setImage:maskedImage];
#else
    [self _displayMaskedImageWithCornerColor:nil];
#endif
}

#pragma mark - internals

- (void)_displayMaskedImageWithCornerColor:(UIColor *)cornerColor {
    if ([self _isMasked]) return;
    UIColor *fillColor = cornerColor;
    if (!fillColor) fillColor = [self _backgroundColorRecursivelyFromSuperviewOfView:self];
    if (!fillColor) return;
    
    CAShapeLayer *maskLayer = [self prepareHighlightedMaskShapeLayerWithDefaultMaskColor:fillColor];
    if (!maskLayer) {
        UIBezierPath *maskPath = [self prepareClosedBezierPathForRenderingMask];
        maskLayer = [CAShapeLayer maskLayerForBezierPath:maskPath fillColor:fillColor.CGColor];
    }
    [self.layer addSublayer:maskLayer];
}

- (BOOL)_isMasked {
    return [self.layer.sublayers.lastObject isKindOfClass:[CAShapeLayer class]] ? YES : NO;
}

- (UIColor *)_backgroundColorRecursivelyFromSuperviewOfView:(UIView *)view {
    UIView *superview = view.superview;
    if (!view || !superview) return nil;
    UIColor *color = superview.backgroundColor;
    if (color && superview.alpha) return color;
    else return [self _backgroundColorRecursivelyFromSuperviewOfView:superview];
}

// Override
- (UIImage *)prepareMaskedImageForInterfaceBuilder { return nil; }
- (UIBezierPath *)prepareClosedBezierPathForRenderingMask { return nil; }
- (nullable CAShapeLayer *)prepareHighlightedMaskShapeLayerWithDefaultMaskColor:(UIColor *)maskColor { return nil; }

// Quote From WWDC: This is going to be invoked on our view right before it renders into the canvas, and it's a last miniute chance for us to do any additional setup.
- (void)prepareForInterfaceBuilder {
    if (!self.image && UIDevice.systemVersion >= 8.0) {
        NSBundle *bundle = [NSBundle bundleForClass:[self class]];
        self.image = [UIImage imageNamed:@"yj_head_icon" inBundle:bundle compatibleWithTraitCollection:nil];
    }
}

@end
