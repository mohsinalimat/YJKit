//
//  YJRoundedCornerView.m
//  YJKit
//
//  Created by huang-kun on 16/5/6.
//  Copyright © 2016年 huang-kun. All rights reserved.
//

#import "YJRoundedCornerView.h"
#import "_YJRoundedCornerView.h"
#import "NSCoder+YJCategory.h"
#import "RGBColor.h"

@implementation YJRoundedCornerView

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
    if (self) {
        _borderWidth = [decoder decodeCGFloatForKey:@"borderWidth"];
        _borderColor = [UIColor colorWithRGBColor:[decoder decodeRGBColorForKey:@"borderColor"]];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)coder {
    [coder encodeCGFloat:_borderWidth forKey:@"borderWidth"];
    [coder encodeRGBColor:[_borderColor RGBColor] forKey:@"borderColor"];
    [super encodeWithCoder:coder];
}

- (void)setup {
    _cornerRadius = 10.0f;
}

@end
