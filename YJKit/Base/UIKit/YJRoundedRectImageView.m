//
//  YJRoundedRectImageView.m
//  YJKit
//
//  Created by huang-kun on 16/4/28.
//  Copyright © 2016年 huang-kun. All rights reserved.
//

#import "YJRoundedRectImageView.h"
#import "UIDevice+YJCategory.h"

static const CGFloat kYJRoundedRectImageViewDefaultCornerRadius = 20.0f;

@implementation YJRoundedRectImageView

// init from code
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _cornerRadius = kYJRoundedRectImageViewDefaultCornerRadius;
    }
    return self;
}

// init from IB
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        _cornerRadius = kYJRoundedRectImageViewDefaultCornerRadius;
        if ([self image]) [self setImage:[self image]];
    }
    return self;
}

- (void)setCornerRadius:(CGFloat)cornerRadius {
    if (cornerRadius < 0.0f) cornerRadius = 0.0f;
    _cornerRadius = cornerRadius;
    if (self.image) [self _refreshImage:self.image];
}

- (void)setImage:(UIImage *)image {
    self.cornerRadius ? [self _refreshImage:image] : [super setImage:image];
}

- (void)_refreshImage:(UIImage *)image {
    UIImage *circularImage = image ? [self _preparedRoundedRectImage:image] : nil;
    if (image) self.backgroundColor = nil;
    [super setImage:circularImage];
}

- (UIImage *)_preparedRoundedRectImage:(UIImage *)image {
    CGSize size = image.size;
    CGRect bounds = (CGRect){ CGPointZero, (CGSize){ size.width, size.height } };
    UIGraphicsBeginImageContextWithOptions(bounds.size, NO, image.scale);
    [[UIBezierPath bezierPathWithRoundedRect:bounds cornerRadius:self.cornerRadius] addClip];
    [image drawAtPoint:CGPointZero];
    UIImage *roundedRectImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return roundedRectImage;
}

// Override
- (void)prepareForInterfaceBuilder {
    if (!self.image && UIDevice.systemVersion >= 8.0) {
        NSBundle *bundle = [NSBundle bundleForClass:[self class]];
        self.image = [UIImage imageNamed:@"yj_head_icon" inBundle:bundle compatibleWithTraitCollection:nil];
    }
}

@end
