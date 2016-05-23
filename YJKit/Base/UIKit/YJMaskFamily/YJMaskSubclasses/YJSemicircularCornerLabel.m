//
//  YJSemicircularCornerLabel.m
//  YJKit
//
//  Created by huang-kun on 16/5/19.
//  Copyright © 2016年 huang-kun. All rights reserved.
//

#import "YJSemicircularCornerLabel.h"

@implementation YJSemicircularCornerLabel

@synthesize cornerRadius = _cornerRadius;

- (void)setCornerRadius:(CGFloat)cornerRadius {
    // ignore
}

- (void)layoutSubviews {
    _cornerRadius = CGRectGetHeight(self.bounds) / 2;
    [super layoutSubviews];
}

@end
