//
//  YJSemicircularCornerButton.m
//  YJKit
//
//  Created by huang-kun on 16/5/14.
//  Copyright © 2016年 huang-kun. All rights reserved.
//

#import "YJSemicircularCornerButton.h"

@implementation YJSemicircularCornerButton

@synthesize cornerRadius = _cornerRadius;

- (void)setCornerRadius:(CGFloat)cornerRadius {
    // ignore
}

- (void)layoutSubviews {
    _cornerRadius = CGRectGetHeight(self.bounds) / 2;
    [super layoutSubviews];
}

@end
