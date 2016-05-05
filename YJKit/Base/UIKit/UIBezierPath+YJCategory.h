//
//  UIBezierPath+YJCategory.h
//  YJKit
//
//  Created by huang-kun on 16/5/5.
//  Copyright © 2016年 huang-kun. All rights reserved.
//

#import <UIKit/UIKit.h>

//NS_ASSUME_NONNULL_BEGIN

@interface UIBezierPath (YJCategory)

/**
 * @brief Create a circular mask UIBezierPath object, the mask region is between the circle path and outer square path.
 * @param framePathPtr The UIBezierPath pointer for getting result of the outer frame path. Nullable.
 * @param circularPathPtr The UIBezierPath pointer for getting result of circle path, Nullable.
 * @return A circular mask UIBezierPath object.
 */
+ (instancetype)bezierPathWithCircleMaskShapeInSize:(CGSize)size outerFramePath:(UIBezierPath **)framePathPtr innerCircularPath:(UIBezierPath **)circularPathPtr;

/**
 * @brief Create a rounded rect mask UIBezierPath object, the mask region is between the rounded rect path and outer frame path.
 * @param cornerRadius The radius to use when calculating rounded corners.
 * @param framePathPtr The UIBezierPath pointer for getting result of the outer square path. Nullable.
 * @param roundedPathPtr The UIBezierPath pointer for getting result of inner rounded rect path, Nullable.
 * @return A rounded rect mask UIBezierPath object.
 */
+ (instancetype)bezierPathWithRoundedCornerMaskShapeInSize:(CGSize)size cornerRadius:(CGFloat)cornerRadius outerFramePath:(UIBezierPath **)framePathPtr innerRoundedPath:(UIBezierPath **)roundedPathPtr;

@end

//NS_ASSUME_NONNULL_END