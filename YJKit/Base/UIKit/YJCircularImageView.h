//
//  YJCircularImageView.h
//  YJKit
//
//  Created by huang-kun on 16/4/28.
//  Copyright © 2016年 huang-kun. All rights reserved.
//

#import <UIKit/UIKit.h>

#ifndef kYJCircularImageViewDefaultImagePath
#define kYJCircularImageViewDefaultImagePath @""
#endif

/**
 *  Display a circular image for UIImageView. The center of circle is the center of the image, and the radius of circle will be the length of the shortest border of the image rectangle.
 *
 *  The benefit for using the YJCircularImageView is getting circular image result both at runtime and design time (in the Interface Builder) by using Xcode 6+.
 *
 *  Usage:
 *
 *  - Drag out a UIImageView from Xcode object library in the Interface Builder.
 *  - Tap the Xcode Identity Inspector, select the UIImageView and Change it's class to YJCircularImageView.
 *  - Tap the Xcode Attributes Inspector, fill in the "image" blank with image name.
 *
 *  Here is a tip to reveal the invisible YJCircularImageView without image content:
 *  - In the Interface Builder(.xib or .storyboard), go to Xcode menu bar -> Editor -> Canvas -> Show Bounds Rectangles.
 *
 *  #define kYJCircularImageViewDefaultImagePath for loading default image at design time.
 */

IB_DESIGNABLE
@interface YJCircularImageView : UIImageView

/// The saturation of the image with range (0.0 ~ 1.0), default is 1.0
@property (nonatomic) IBInspectable CGFloat saturation;

@end