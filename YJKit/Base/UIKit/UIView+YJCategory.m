//
//  UIView+YJCategory.m
//  YJKit
//
//  Created by huang-kun on 16/3/21.
//  Copyright © 2016年 huang-kun. All rights reserved.
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
    self.top = topInPixel / kScreenScale;
}

- (void)setLeftInPixel:(CGFloat)leftInPixel {
    self.left = leftInPixel / kScreenScale;
}

- (void)setBottomInPixel:(CGFloat)bottomInPixel {
    self.bottom = bottomInPixel / kScreenScale;
}

- (void)setRightInPixel:(CGFloat)rightInPixel {
    self.right = rightInPixel / kScreenScale;
}

- (void)setCenterXInPixel:(CGFloat)centerXInPixel {
    self.centerX = centerXInPixel / kScreenScale;
}

- (void)setCenterYInPixel:(CGFloat)centerYInPixel {
    self.centerY = centerYInPixel / kScreenScale;
}

- (void)setOriginInPixel:(CGPoint)originInPixel {
    self.origin = (CGPoint){ originInPixel.x / kScreenScale, originInPixel.y / kScreenScale };
}

- (void)setSizeInPixel:(CGSize)sizeInPixel {
    self.size = (CGSize){ sizeInPixel.width / kScreenScale, sizeInPixel.height / kScreenScale };
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

- (CGFloat)topInPixel { return self.top * kScreenScale; }
- (CGFloat)leftInPixel { return self.left * kScreenScale; }
- (CGFloat)bottomInPixel { return self.bottom * kScreenScale; }
- (CGFloat)rightInPixel { return self.right * kScreenScale; }
- (CGFloat)centerXInPixel { return self.centerX * kScreenScale; }
- (CGFloat)centerYInPixel { return self.centerY * kScreenScale; }
- (CGPoint)originInPixel { return (CGPoint){ self.origin.x * kScreenScale, self.origin.y * kScreenScale }; }
- (CGSize)sizeInPixel { return (CGSize){ self.size.width * kScreenScale, self.size.height * kScreenScale }; }

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
