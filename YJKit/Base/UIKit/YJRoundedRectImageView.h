//
//  YJRoundedRectImageView.h
//  YJKit
//
//  Created by huang-kun on 16/4/28.
//  Copyright © 2016年 huang-kun. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  Display a rounded rectangle image for UIImageView.
 *
 *  The benefit for using the YJRoundedRectImageView is getting rounded rectangle image result both at runtime and design time (in the Interface Builder) by using Xcode 6+.
 *
 *  Usage:
 *
 *  - Drag out a UIImageView from Xcode object library in the Interface Builder.
 *  - Tap the Xcode Identity Inspector, select the UIImageView and Change it's class to YJRoundedRectImageView.
 *  - Tap the Xcode Attributes Inspector, fill in the "image" blank with image name in "Image View" section. Also fill the "Corner Radius" blank to specifiy the corner radius of the image rectangle in "Rounded Rect Image View" section.
 *
 *  Here is a tip to reveal the invisible YJRoundedRectImageView without image content:
 *  - In the Interface Builder(.xib or .storyboard), go to Xcode menu bar -> Editor -> Canvas -> Show Bounds Rectangles.
 *
 */

IB_DESIGNABLE
@interface YJRoundedRectImageView : UIImageView

/// The radius to use when drawing rounded corners for the image content. Default is 0.0
@property (nonatomic) IBInspectable CGFloat cornerRadius;

@end
