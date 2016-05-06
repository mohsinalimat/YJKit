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
#import "UIView+YJCategory.h"
#import "CGGeometry_YJExtension.h"
#import "UIDevice+YJCategory.h"
#import "YJDebugMacros.h"

@interface YJMaskedImageView ()
@property (nonatomic, strong) CAShapeLayer *maskLayer;
@property (nonatomic, strong) UIColor *maskColor;
@property (nonatomic, assign) CGRect maskFrame;
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

- (void)setImage:(UIImage *)image {
    [super setImage:image];
    if (!image) return;
    self.backgroundColor = nil;
    [self _updateMaskFrameIfNeeded];
    [self updateMaskLayer];
}

- (void)setFrame:(CGRect)frame {
    BOOL sizeChanged = NO;
    CGSize oldSize = super.frame.size;
    if (!CGSizeEqualToSize(oldSize, frame.size)) sizeChanged = YES;
    [super setFrame:frame];
    if (sizeChanged) [self updateMaskLayer];
}

- (void)setContentMode:(UIViewContentMode)contentMode {
    [super setContentMode:contentMode];
    [self _updateMaskFrameIfNeeded];
    [self updateMaskLayer];
}

#pragma mark - masking

- (void)updateMaskLayer {
    [self.maskLayer removeFromSuperlayer];
    [self _configureMaskLayerWithColor:self.maskColor];
}

- (void)_configureMaskLayerWithColor:(UIColor *)color {
    if (self.isMasked || !color) return;
    CGRect maskRect = !CGRectIsEmpty(self.maskFrame) ? self.maskFrame : self.bounds;
    self.maskLayer = [self prepareHighlightedMaskShapeLayerInRect:maskRect withDefaultMaskColor:color];
    if (!self.maskLayer) {
        UIBezierPath *maskShape = [self prepareMaskShapePathInRect:maskRect];
        self.maskLayer = [CAShapeLayer maskLayerForBezierPath:maskShape fillColor:color.CGColor];
    }
    [self.layer addSublayer:self.maskLayer];
}

- (BOOL)isMasked {
    return self.maskLayer.superlayer ? YES : NO;
}

- (void)_updateMaskFrameIfNeeded {
    YJViewContentMode mode = [self mappedYJcontentMode];
    if (mode == YJViewContentModeUnspecified) return;
    CGRect displayedImageRect = CGRectPositioned((CGRect){ CGPointZero, self.image.size }, self.bounds, mode);
    CGRect finalRect = CGRectIntersection(displayedImageRect, self.bounds);
    if (!CGRectIsNull(finalRect)) self.maskFrame = finalRect;
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
- (UIBezierPath *)prepareMaskShapePathInRect:(CGRect)rect { return nil; }
- (nullable CAShapeLayer *)prepareHighlightedMaskShapeLayerInRect:(CGRect)rect withDefaultMaskColor:(UIColor *)maskColor { return nil; }

// Quote From WWDC: This is going to be invoked on our view right before it renders into the canvas, and it's a last miniute chance for us to do any additional setup.
- (void)prepareForInterfaceBuilder {
    if (!self.image && UIDevice.systemVersion >= 8.0) {
        NSBundle *bundle = [NSBundle bundleForClass:[self class]];
        self.image = [UIImage imageNamed:@"yj_head_icon" inBundle:bundle compatibleWithTraitCollection:nil];
    }
}

@end
