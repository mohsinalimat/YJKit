//
//  YJRoundedCornerImageView.m
//  YJKit
//
//  Created by huang-kun on 16/4/28.
//  Copyright © 2016年 huang-kun. All rights reserved.
//

#import "YJRoundedCornerImageView.h"
#import "_YJRoundedCornerView.h"
#import "NSValue+YJGeometryExtension.h"
#import "NSObject+YJCodingExtension.h"

@implementation YJRoundedCornerImageView

// Add default rounded corner implementations
YJ_ROUNDED_CORNER_VIEW_DEFAULT_IMPLEMENTATION_FOR_YJMASKEDVIEW_SUBCLASS

/* init from code */
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

/* init from IB */
- (nullable instancetype)initWithCoder:(NSCoder *)decoder {
    self = [super initWithCoder:decoder];
    if (self) [self decodeIvarListWithCoder:decoder];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)coder {
    [self encodeIvarListWithCoder:coder];
    [super encodeWithCoder:coder];
}

- (void)setup {
    _cornerRadius = 10.0f;
}

@end
