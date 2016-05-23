//
//  YJRoundedCornerTextView.h
//  YJKit
//
//  Created by huang-kun on 16/5/20.
//  Copyright © 2016年 huang-kun. All rights reserved.
//

#import "YJLayerBasedMasking.h"
#import "YJContentIndents.h"

IB_DESIGNABLE
@interface YJRoundedCornerTextView : UITextView <YJLayerBasedMasking>

/// The radius to use when showing rounded corners for view. Default is 10.0f
@property (nonatomic, assign) IBInspectable CGFloat cornerRadius;

/// The width of border around the view. Default is 0.0
@property (nonatomic, assign) IBInspectable CGFloat borderWidth;

/// The color of border around the view. Default is tint color.
@property (nonatomic, strong) IBInspectable UIColor *borderColor;

@end
