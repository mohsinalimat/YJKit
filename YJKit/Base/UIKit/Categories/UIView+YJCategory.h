//
//  UIView+YJCategory.h
//  YJKit
//
//  Created by huang-kun on 16/3/21.
//  Copyright © 2016年 huang-kun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (YJCategory)

// Geometry

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

// Springs and Struts

CGFloat YJGridWidthInContainerWidth(CGFloat containerWidth, NSUInteger gridCount, CGFloat padding);
CGFloat YJGridHeightInContainerHeight(CGFloat containerHeight, NSUInteger gridCount, CGFloat padding);

CGFloat YJGridPaddingInContainerWidth(CGFloat containerWidth, CGFloat gridWidth, NSUInteger gridCount);
CGFloat YJGridPaddingInContainerHeight(CGFloat containerHeight, CGFloat gridHeight, NSUInteger gridCount);

CGFloat YJGridOffsetXAtIndex(NSUInteger index, CGFloat gridWidth, CGFloat padding);
CGFloat YJGridOffsetYAtIndex(NSUInteger index, CGFloat gridHeight, CGFloat padding);

NSUInteger YJGridCountInContainerWidth(CGFloat containerWidth, CGFloat gridWidth, CGFloat padding);
NSUInteger YJGridCountInContainerHeight(CGFloat containerHeight, CGFloat gridHeight, CGFloat padding);

@end
