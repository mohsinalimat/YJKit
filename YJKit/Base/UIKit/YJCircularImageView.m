//
//  YJCircularImageView.m
//  YJKit
//
//  Created by huang-kun on 16/4/28.
//  Copyright © 2016年 huang-kun. All rights reserved.
//
//  Reference: https://developer.apple.com/videos/play/wwdc2014/401/

#import "YJCircularImageView.h"

@interface YJCircularImageView ()
@end

@implementation YJCircularImageView

// init from code
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _saturation = 1.0f;
    }
    return self;
}

// init from IB
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        _saturation = 1.0f;
        if ([self image]) [self setImage:[self image]];
    }
    return self;
}

- (void)setSaturation:(CGFloat)saturation {
    if (saturation < 0.0f) saturation = 0.0f;
    if (saturation > 1.0f) saturation = 1.0f;
    _saturation = saturation;
    if (self.image) [self _refreshImage:self.image forSuperclass:NO];
}

- (void)setImage:(UIImage *)image {
    [self _refreshImage:image forSuperclass:YES];
}

- (void)_refreshImage:(UIImage *)image forSuperclass:(BOOL)forSuperclass {
    UIImage *circularImage = image ? [self _preparedCircularImage:image] : nil;
    if (image) self.backgroundColor = nil;
    forSuperclass ? [super setImage:circularImage] : [self setImage:circularImage];
}

- (UIImage *)_preparedCircularImage:(UIImage *)image {
    CGSize size = image.size;
    CGFloat minValue = MIN(size.width, size.height);
    CGRect bounds = (CGRect){ CGPointZero, (CGSize){ minValue, minValue } };
    UIGraphicsBeginImageContextWithOptions(bounds.size, NO, image.scale);
    [[UIBezierPath bezierPathWithOvalInRect:bounds] addClip];
    [image drawAtPoint:(CGPoint){ (minValue - size.width) / 2, (minValue - size.height) / 2 }];
    if (self.saturation != 1.0f) {
        [[UIColor colorWithWhite:1.0 alpha:(1.0 - self.saturation)] set];
        UIRectFillUsingBlendMode(bounds, kCGBlendModeColor);
    }
    UIImage *preparedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return preparedImage;
}

// Override
// Quote From WWDC: This is going to be invoked on our view right before it renders into the canvas, and it's a last miniute chance for us to do any additional setup.
- (void)prepareForInterfaceBuilder {
    if (!self.image) self.image = [UIImage imageWithContentsOfFile:kYJCircularImageViewDefaultImagePath];
}

@end
