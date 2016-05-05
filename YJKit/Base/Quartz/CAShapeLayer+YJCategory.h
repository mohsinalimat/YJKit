//
//  CAShapeLayer+YJCategory.h
//  YJKit
//
//  Created by huang-kun on 16/5/5.
//  Copyright © 2016年 huang-kun. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

NS_ASSUME_NONNULL_BEGIN

@interface CAShapeLayer (YJCategory)

/**
 * @brief Create a mask layer based on the specific UIBezierPath object.
 * @param bezierPath The UIBezierPath for the mask region.
 * @param fillColor The color for filling the mask layer.
 * @return A mask layer based on the specific UIBezierPath object.
 */
+ (instancetype)maskLayerForBezierPath:(UIBezierPath *)bezierPath fillColor:(CGColorRef)fillColor;

/**
 * @brief Create a mask layer based on the specific UIBezierPath object. The masked part is the region which between the frameBezierPath and shapeBezierPath.
 * @param frameBezierPath The UIBezierPath for outer frame of the mask layer.
 * @param shapeBezierPath The UIBezierPath for single inner shape of the mask layer.
 * @param fillColor The color for filling the mask layer.
 * @param strokeWidth The inner shape line width.
 * @param strokeColor The inner shape line color.
 * @return A mask layer based on the specific UIBezierPath object.
 */
+ (instancetype)maskLayerForFrameBezierPath:(UIBezierPath *)frameBezierPath shapeBezierPath:(UIBezierPath *)shapeBezierPath fillColor:(CGColorRef)fillColor strokeWidth:(CGFloat)strokeWidth strokeColor:(CGColorRef)strokeColor;

/**
 * @brief Create a circular mask layer.
 * @param size The CGSize for sizing the layer.
 * @param fillColor The color for filling the mask layer.
 * @return A circular mask layer.
 */
+ (instancetype)circularMaskLayerInSize:(CGSize)size fillColor:(CGColorRef)fillColor;

/**
 * @brief Create a circular mask layer.
 * @param size The CGSize for sizing the layer.
 * @param fillColor The color for filling the mask layer.
 * @param strokeWidth The circular line width.
 * @param strokeColor The circular line color.
 * @return A circular mask layer.
 */
+ (instancetype)circularMaskLayerInSize:(CGSize)size fillColor:(CGColorRef)fillColor strokeWidth:(CGFloat)strokeWidth strokeColor:(CGColorRef)strokeColor;

/**
 * @brief Create a rounded rect mask layer.
 * @param size The CGSize for sizing the layer.
 * @param fillColor The color for filling the mask layer.
 * @return A rounded rect mask layer.
 */
+ (instancetype)roundedRectMaskLayerInSize:(CGSize)size cornerRadius:(CGFloat)cornerRadius fillColor:(CGColorRef)fillColor;

/**
 * @brief Create a rounded rect mask layer.
 * @param size The CGSize for sizing the layer.
 * @param fillColor The color for filling the mask layer.
 * @param strokeWidth The rounded rect line width.
 * @param strokeColor The rounded rect line color.
 * @return A rounded rect mask layer.
 */
+ (instancetype)roundedRectMaskLayerInSize:(CGSize)size cornerRadius:(CGFloat)cornerRadius fillColor:(CGColorRef)fillColor strokeWidth:(CGFloat)strokeWidth strokeColor:(CGColorRef)strokeColor;

@end

NS_ASSUME_NONNULL_END
