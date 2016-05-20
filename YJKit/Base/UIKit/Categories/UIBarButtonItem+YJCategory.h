//
//  UIBarButtonItem+YJCategory.h
//  YJKit
//
//  Created by huang-kun on 16/4/1.
//  Copyright © 2016年 huang-kun. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^YJBarButtonItemActionHandler)(UIBarButtonItem *barButtonItem);

@interface UIBarButtonItem (YJCategory)

/**
*  Initializes a new item using the specified image and other properties.
*
*  @param image         The item’s image. If nil an image is not displayed. 
                        The images displayed on the bar are derived from this image. If this image is too large to fit on the bar, it is scaled to fit. Typically, the size of a toolbar and navigation bar image is 20 x 20 points. The alpha values in the source image are used to create the images—opaque values are ignored.
*  @param style         The style of the item. One of the constants defined in UIBarButtonItemStyle.
*  @param actionHandler The action block will be performed when this item is selected.
*
*  @return Newly initialized item with the specified properties.
*/
- (instancetype)initWithImage:(nullable UIImage *)image
                        style:(UIBarButtonItemStyle)style
                actionHandler:(nullable void(^)(UIBarButtonItem *sender))actionHandler;

/**
 *  Initializes a new item using the specified images and other properties.
 *
 *  @param image                The item’s image. If nil an image is not displayed.
 *  @param landscapeImagePhone  The image to be used for the item in landscape bars in the UIUserInterfaceIdiomPhone idiom.
 *  @param style                The style of the item. One of the constants defined in UIBarButtonItemStyle.
 *  @param actionHandler        The action block will be performed when this item is selected.
 *
 *  @return A new item initialized to use using the specified images and other properties
 */
- (instancetype)initWithImage:(nullable UIImage *)image
          landscapeImagePhone:(nullable UIImage *)landscapeImagePhone
                        style:(UIBarButtonItemStyle)style
                actionHandler:(nullable void(^)(UIBarButtonItem *sender))actionHandler;

/**
 *  Initializes a new item using the specified title and other properties.
 *
 *  @param title         The item’s title. If nil a title is not displayed.
 *  @param style         The style of the item. One of the constants defined in UIBarButtonItemStyle.
 *  @param actionHandler The action block will be performed when this item is selected.
 *
 *  @return Newly initialized item with the specified properties.
 */
- (instancetype)initWithTitle:(nullable NSString *)title
                        style:(UIBarButtonItemStyle)style
                actionHandler:(nullable void(^)(UIBarButtonItem *sender))actionHandler;

/**
 *  Initializes a new item containing the specified system item.
 *
 *  @param systemItem    The system item to use as the first item on the bar. One of the constants defined in UIBarButtonSystemItem.
 *  @param actionHandler The action block will be performed when this item is selected.
 *
 *  @return A newly initialized item containing the specified system item.
 */
- (instancetype)initWithBarButtonSystemItem:(UIBarButtonSystemItem)systemItem
                              actionHandler:(nullable void(^)(UIBarButtonItem *sender))actionHandler;

/**
 *  The action block defining a block of code will be executed when the user taps this bar button item.
 */
@property (nullable, nonatomic, copy) YJBarButtonItemActionHandler actionHandler;

@end

NS_ASSUME_NONNULL_END
