//
//  YJRoundedCornerButton.h
//  YJKit
//
//  Created by huang-kun on 16/5/7.
//  Copyright © 2016年 huang-kun. All rights reserved.
//

#import "YJLayerBasedMasking.h"
#import "YJTitleIndents.h"

IB_DESIGNABLE
@interface YJRoundedCornerButton : UIButton <YJLayerBasedMasking>

/// The radius to use when showing rounded corners for view. Default is 10.0f
@property (nonatomic, assign) IBInspectable CGFloat cornerRadius;

/// The width of border around the view. Default is 0.0
@property (nonatomic, assign) IBInspectable CGFloat borderWidth;

/// The color of border around the view. Default is tint color.
@property (nonatomic, strong) IBInspectable UIColor *borderColor;

/// The indentation style for making indentation space of the title to extend it's intrinsic content size.
#if TARGET_INTERFACE_BUILDER
@property (nonatomic, assign) IBInspectable NSInteger titleIndentationStyle;
#else
@property (nonatomic, assign) YJTitleIndentationStyle titleIndentationStyle;
#endif

/// The indentation value for the title;
@property (nonatomic, readonly) YJTitleIndents titleIndents;

@end
