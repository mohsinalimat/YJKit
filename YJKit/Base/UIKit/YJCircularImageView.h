//
//  YJCircularImageView.h
//  YJKit
//
//  Created by huang-kun on 16/4/28.
//  Copyright © 2016年 huang-kun. All rights reserved.
//

#import "YJMaskedImageView.h"

/**
 *  Display a circular image for UIImageView. The center of circle is the center of the image, and the radius of circle will be the length of the shortest border of the image rectangle.
 *
 *  The benefit for using the YJCircularImageView is getting circular image result both at runtime and design time (in the Interface Builder) by using Xcode 6+.
 *
 *  Usage:
 *
 *  - Drag out a UIImageView from Xcode object library in the Interface Builder.
 *  - Tap the Xcode Identity Inspector, select the UIImageView and Change it's class to YJCircularImageView.
 *  - Tap the Xcode Attributes Inspector, fill in the "image" blank with image name in "Image View" section.
 *
 *  Here is a tip to reveal the invisible YJCircularImageView without image content:
 *  - In the Interface Builder(.xib or .storyboard), go to Xcode menu bar -> Editor -> Canvas -> Show Bounds Rectangles.
 *
 */

IB_DESIGNABLE
@interface YJCircularImageView : YJMaskedImageView

/// The width of the circle around the image. Default is 0.0
@property (nonatomic, assign) IBInspectable CGFloat circleWidth;

/// The color of the circle around the image. Default is nil
@property (nonatomic, strong) IBInspectable UIColor *circleColor;
@end