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
#import "UIColor+YJCategory.h"
#import "UIDevice+YJCategory.h"
#import "YJDebugMacros.h"
#import "YJConfigureMacros.h"

@interface YJMaskedImageView ()
@property (nonatomic, strong) CAShapeLayer *maskLayer;
@property (nonatomic, strong) UIColor *maskColor;
@end

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

#pragma mark - view hierarchy

- (void)willMoveToSuperview:(nullable UIView *)newSuperview {
    [super willMoveToSuperview:newSuperview];
    if (!newSuperview) return;
    // added to superview
    if (newSuperview.backgroundColor) {
        [self _configureMaskWithColor:newSuperview.backgroundColor];
        return;
    }
    [newSuperview addObservedKeyPath:@"backgroundColor" handleSetup:^(id  _Nonnull object, id  _Nullable newValue) {
        if (self.superview == object && newValue && [newValue isKindOfClass:[UIColor class]]) { // not go in from design phase.
            if (![self.maskColor isEqualToRGBColor:newValue]) {
                [self.maskLayer removeFromSuperlayer];
                [self _configureMaskWithColor:newValue];
                self.maskColor = newValue;
            }
        }
    }];
}

- (void)removeFromSuperview {
    self.maskColor = nil;
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
    // Compiler won't warn you if you make typos under TARGET_INTERFACE_BUILDER. So if you failed to build Xcode for IBDesignable phase by selecting Xcode menu bar (in interface builder, either .storyboard or .xib) -> Editor -> Debug Selected Views, then check your code under TARGET_INTERFACE_BUILDER.
    #if YJ_COMPILE_UNAVAILABLE
    UIImage *maskedImage = [self prepareMaskedImageForInterfaceBuilder];
    [super setImage:maskedImage];
    #endif
#endif
}

#pragma mark - internals

- (void)_configureMaskWithColor:(UIColor *)color {
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

// Deprecated
- (UIColor *)_backgroundColorRecursivelyFromSuperviewOfView:(UIView *)view {
    UIView *superview = view.superview;
    if (!view || !superview) return nil;
    UIColor *color = superview.backgroundColor;
    if (color && superview.alpha) return color;
    else return [self _backgroundColorRecursivelyFromSuperviewOfView:superview];
}

// For subclasses overriding
- (UIImage *)prepareMaskedImageForInterfaceBuilder { return nil; }
- (UIBezierPath *)prepareClosedMaskBezierPath { return nil; }
- (nullable CAShapeLayer *)prepareHighlightedMaskShapeLayerWithDefaultMaskColor:(UIColor *)maskColor { return nil; }

// Quote From WWDC: This is going to be invoked on our view right before it renders into the canvas, and it's a last miniute chance for us to do any additional setup.
- (void)prepareForInterfaceBuilder {
    if (!self.image && UIDevice.systemVersion >= 8.0) {
        NSBundle *bundle = [NSBundle bundleForClass:[self class]];
        self.image = [UIImage imageNamed:@"yj_head_icon" inBundle:bundle compatibleWithTraitCollection:nil];
    }
}

@end
