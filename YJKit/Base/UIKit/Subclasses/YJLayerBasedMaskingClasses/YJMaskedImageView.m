//
//  YJMaskedImageView.m
//  YJKit
//
//  Created by huang-kun on 16/5/5.
//  Copyright © 2016年 huang-kun. All rights reserved.
//

#import "YJMaskedImageView.h"
#import "UIView+YJCategory.h"
#import "CGGeometry_YJExtension.h"
#import "UIDevice+YJCategory.h"
#import "YJDebugMacros.h"
#import "_YJLayerBasedMasking.h"


@implementation YJMaskedImageView

// Add default YJLayerBasedMasking implementations
YJ_LAYER_BASED_MASKING_PROTOCOL_DEFAULT_IMPLEMENTATION_FOR_YJMASKEDVIEW_SUBCLASS /* set _transparantFrame later */

#pragma mark - init & dealloc

// init from code
//- (instancetype)initWithFrame:(CGRect)frame {
//    self = [super initWithFrame:frame];
//    if (self) {
//        // ...
//    }
//    return self;
//}

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

#pragma mark - override setters

- (void)setImage:(UIImage *)image {
    [super setImage:image];
    if (!image) return;
    self.backgroundColor = nil;
    [self _updateTransparentFrameIfNeeded];
    [self updateMaskLayer];
}

- (void)setContentMode:(UIViewContentMode)contentMode {
    [super setContentMode:contentMode];
    [self _updateTransparentFrameIfNeeded];
    [self updateMaskLayer];
}

#pragma mark - masking

- (void)_updateTransparentFrameIfNeeded {
    YJViewContentMode mode = [self mappedYJcontentMode];
    if (mode == YJViewContentModeUnspecified) return;
    CGRect displayedImageRect = CGRectPositioned((CGRect){ CGPointZero, self.image.size }, self.bounds, mode);
    CGRect finalRect = CGRectIntersection(displayedImageRect, self.bounds);
    if (!CGRectIsNull(finalRect)) self.transparentFrame = finalRect;
}

// Deprecated
//- (UIColor *)_backgroundColorRecursivelyFromSuperviewOfView:(UIView *)view {
//    UIView *superview = view.superview;
//    if (!view || !superview) return nil;
//    UIColor *color = superview.backgroundColor;
//    if (color && superview.alpha) return color;
//    else return [self _backgroundColorRecursivelyFromSuperviewOfView:superview];
//}

// Quote From WWDC: This is going to be invoked on our view right before it renders into the canvas, and it's a last miniute chance for us to do any additional setup.
- (void)prepareForInterfaceBuilder {
    if (!self.image && UIDevice.systemVersion >= 8.0) {
        NSBundle *bundle = [NSBundle bundleForClass:[self class]];
        self.image = [UIImage imageNamed:@"yj_head_icon" inBundle:bundle compatibleWithTraitCollection:nil];
    }
}

@end
