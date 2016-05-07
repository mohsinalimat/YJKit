//
//  YJRoundedCornerView.h
//  YJKit
//
//  Created by huang-kun on 16/5/6.
//  Copyright © 2016年 huang-kun. All rights reserved.
//

#import "YJMaskedView.h"

IB_DESIGNABLE
@interface YJRoundedCornerView : YJMaskedView

/// The radius to use when showing rounded corners for view. Default is 10.0f
@property (nonatomic, assign) IBInspectable CGFloat cornerRadius;

/// The width of border around the view. Default is 0.0
@property (nonatomic, assign) IBInspectable CGFloat borderWidth;

/// The color of border around the view. Default is nil
@property (nonatomic, strong) IBInspectable UIColor *borderColor;

@end
