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

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
//        self.borderWidth = 1.0f;
        _cornerRadius = CGRectGetHeight(frame) / 2;
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
//        self.borderWidth = 1.0f;
        _cornerRadius = CGRectGetHeight(self.bounds) / 2;
    }
    return self;
}

- (void)setFrame:(CGRect)frame {
    self.cornerRadius = CGRectGetHeight(frame) / 2;
    [super setFrame:frame];
}

- (void)setCornerRadius:(CGFloat)cornerRadius {
    // ignore
}

@end
