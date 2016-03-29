//
//  UIView+YJCategory.h
//  YJKit
//
//  Created by Jack Huang on 16/3/21.
//  Copyright © 2016年 Jack Huang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (YJCategory)

@property (nonatomic) CGFloat top;      // self.frame.origin.x
@property (nonatomic) CGFloat left;     // self.frame.origin.y
@property (nonatomic) CGFloat bottom;   // self.frame.origin.y + self.frame.size.height
@property (nonatomic) CGFloat right;    // self.frame.origin.x + self.frame.size.width
@property (nonatomic) CGFloat centerX;  // self.center.x
@property (nonatomic) CGFloat centerY;  // self.center.y
@property (nonatomic) CGPoint origin;   // self.frame.origin
@property (nonatomic) CGSize size;      // self.frame.size

@property (nonatomic) CGFloat topInPixel;
@property (nonatomic) CGFloat leftInPixel;
@property (nonatomic) CGFloat bottomInPixel;
@property (nonatomic) CGFloat rightInPixel;
@property (nonatomic) CGFloat centerXInPixel;
@property (nonatomic) CGFloat centerYInPixel;
@property (nonatomic) CGPoint originInPixel;
@property (nonatomic) CGSize sizeInPixel;

@end
