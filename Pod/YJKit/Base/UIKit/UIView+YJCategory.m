//
//  UIView+YJCategory.m
//  YJKit
//
//  Created by Jack Huang on 16/3/21.
//  Copyright © 2016年 Jack Huang. All rights reserved.
//

#import "UIView+YJCategory.h"
#import "UIScreen+YJCategory.h"

@implementation UIView (YJCategory)

#pragma mark - Geometry

#pragma mark * Setter

- (void)setTop:(CGFloat)top {
    CGRect frame = self.frame;
    frame.origin.y = top;
    self.frame = frame;
}

- (void)setLeft:(CGFloat)left {
    CGRect frame = self.frame;
    frame.origin.x = left;
    self.frame = frame;
}

- (void)setBottom:(CGFloat)bottom {
    CGRect frame = self.frame;
    frame.origin.y = bottom - frame.size.height;
    self.frame = frame;
}

- (void)setRight:(CGFloat)right {
    CGRect frame = self.frame;
    frame.origin.x = right - frame.size.width;
    self.frame = frame;
}

- (void)setCenterX:(CGFloat)centerX {
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}

- (void)setCenterY:(CGFloat)centerY {
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}

- (void)setOrigin:(CGPoint)origin {
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

- (void)setSize:(CGSize)size {
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (void)setTopInPixel:(CGFloat)topInPixel {
    self.top = topInPixel / kYJScreenScale;
}

- (void)setLeftInPixel:(CGFloat)leftInPixel {
    self.left = leftInPixel / kYJScreenScale;
}

- (void)setBottomInPixel:(CGFloat)bottomInPixel {
    self.bottom = bottomInPixel / kYJScreenScale;
}

- (void)setRightInPixel:(CGFloat)rightInPixel {
    self.right = rightInPixel / kYJScreenScale;
}

- (void)setCenterXInPixel:(CGFloat)centerXInPixel {
    self.centerX = centerXInPixel / kYJScreenScale;
}

- (void)setCenterYInPixel:(CGFloat)centerYInPixel {
    self.centerY = centerYInPixel / kYJScreenScale;
}

- (void)setOriginInPixel:(CGPoint)originInPixel {
    self.origin = (CGPoint){ originInPixel.x / kYJScreenScale, originInPixel.y / kYJScreenScale };
}

- (void)setSizeInPixel:(CGSize)sizeInPixel {
    self.size = (CGSize){ sizeInPixel.width / kYJScreenScale, sizeInPixel.height / kYJScreenScale };
}

#pragma mark * Getter

- (CGFloat)top { return self.frame.origin.y; }
- (CGFloat)left { return self.frame.origin.x; }
- (CGFloat)bottom { return self.frame.origin.y + self.frame.size.height; }
- (CGFloat)right { return self.frame.origin.x + self.frame.size.width; }
- (CGFloat)centerX { return self.center.x; }
- (CGFloat)centerY { return self.center.y; }
- (CGPoint)origin { return self.frame.origin; }
- (CGSize)size { return self.frame.size; }

- (CGFloat)topInPixel { return self.top * kYJScreenScale; }
- (CGFloat)leftInPixel { return self.left * kYJScreenScale; }
- (CGFloat)bottomInPixel { return self.bottom * kYJScreenScale; }
- (CGFloat)rightInPixel { return self.right * kYJScreenScale; }
- (CGFloat)centerXInPixel { return self.centerX * kYJScreenScale; }
- (CGFloat)centerYInPixel { return self.centerY * kYJScreenScale; }
- (CGPoint)originInPixel { return (CGPoint){ self.origin.x * kYJScreenScale, self.origin.y * kYJScreenScale }; }
- (CGSize)sizeInPixel { return (CGSize){ self.size.width * kYJScreenScale, self.size.height * kYJScreenScale }; }

#pragma mark - Springs & Struts

CGFloat YJGridLengthInContainerLength(CGFloat containerLength, NSUInteger gridCount, CGFloat padding) {
    return containerLength / gridCount - padding * (gridCount + 1) / gridCount;
}

CGFloat YJGridWidthInContainerWidth(CGFloat containerWidth, NSUInteger gridCount, CGFloat padding) {
    return YJGridLengthInContainerLength(containerWidth, gridCount, padding);
}

CGFloat YJGridHeightInContainerHeight(CGFloat containerHeight, NSUInteger gridCount, CGFloat padding) {
    return YJGridLengthInContainerLength(containerHeight, gridCount, padding);
}

CGFloat YJGridOffsetAtIndex(NSUInteger index, CGFloat gridLength, CGFloat padding) {
    return padding + index * (gridLength + padding);
}

CGFloat YJGridOffsetXAtIndex(NSUInteger index, CGFloat gridWidth, CGFloat padding) {
    return YJGridOffsetAtIndex(index, gridWidth, padding);
}

CGFloat YJGridOffsetYAtIndex(NSUInteger index, CGFloat gridHeight, CGFloat padding) {
    return YJGridOffsetAtIndex(index, gridHeight, padding);
}

NSUInteger YJGridCountInContainerLength(CGFloat containerLength, CGFloat gridLength, CGFloat padding) {
    return (containerLength + padding) / (gridLength + padding);
}

NSUInteger YJGridCountInContainerWidth(CGFloat containerWidth, CGFloat gridWidth, CGFloat padding) {
    return YJGridCountInContainerLength(containerWidth, gridWidth, padding);
}

NSUInteger YJGridCountInContainerHeight(CGFloat containerHeight, CGFloat gridHeight, CGFloat padding) {
    return YJGridCountInContainerLength(containerHeight, gridHeight, padding);
}

CGFloat YJGridPaddingInContainerLength(CGFloat containerLength, CGFloat gridLength, NSUInteger gridCount) {
    return (containerLength - gridLength * gridCount) / (gridCount + 1);
}

CGFloat YJGridPaddingInContainerWidth(CGFloat containerWidth, CGFloat gridWidth, NSUInteger gridCount) {
    return YJGridPaddingInContainerLength(containerWidth, gridWidth, gridCount);
}

CGFloat YJGridPaddingInContainerHeight(CGFloat containerHeight, CGFloat gridHeight, NSUInteger gridCount) {
    return YJGridPaddingInContainerLength(containerHeight, gridHeight, gridCount);
}

@end
