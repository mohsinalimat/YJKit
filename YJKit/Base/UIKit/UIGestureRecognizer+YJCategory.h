//
//  UIGestureRecognizer+YJCategory.h
//  YJKit
//
//  Created by huang-kun on 16/4/1.
//  Copyright © 2016年 huang-kun. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIGestureRecognizer (YJCategory)

/**
 *  Initializes an allocated gesture-recognizer object with action block.
 *  @param actionHandler The block of code will be executed when the gesture is recognized.
 *  @return An initialized instance of a concrete UIGestureRecognizer subclass or nil if an error occurred in the attempt to initialize the object.
 *  @code
 UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithActionHandler:^(UIGestureRecognizer * _Nonnull gestureRecognizer) {
    NSLog(@"Tap location: %@", NSStringFromCGPoint([gestureRecognizer locationInView:gestureRecognizer.view]));
 }];
 *  @endcode
 */
- (instancetype)initWithActionHandler:(nullable void(^)(UIGestureRecognizer *gestureRecognizer))actionHandler;

/**
 *  Initializes an allocated gesture-recognizer object with action block.
 *  @param tag           The unique descriptive string associated with the action block.
 *  @param actionHandler The block of code will be executed when the gesture is recognized.
 *  @return An initialized instance of a concrete UIGestureRecognizer subclass or nil if an error occurred in the attempt to initialize the object.
 *  @code
 UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithActionTaged:@"handleSingleTap" actionHandler:^(UIGestureRecognizer * _Nonnull gestureRecognizer) {
     NSLog(@"Tap location: %@", NSStringFromCGPoint([gestureRecognizer locationInView:gestureRecognizer.view]));
 }];
 *  @endcode
 */
- (instancetype)initWithActionTaged:(NSString *)tag actionHandler:(nullable void(^)(UIGestureRecognizer *gestureRecognizer))actionHandler;

/**
 *  Adds an action block to a gesture-recognizer object.
 *  @discussion You may call this method multiple times to specify multiple action handler blocks.
 *  @param actionHandler The block of code will be executed when the gesture is recognized.
 *  @code
 [tap addActionHandler:^(UIGestureRecognizer * _Nonnull gestureRecognizer) {
    NSLog(@"Tap location: %@", NSStringFromCGPoint([gestureRecognizer locationInView:gestureRecognizer.view]));
 }];
 *  @endcode
 */
- (void)addActionHandler:(void(^)(UIGestureRecognizer *gestureRecognizer))actionHandler;

/**
 *  Adds an action block to a gesture-recognizer object.
 *  @discussion You may call this method multiple times to specify multiple action handler blocks.
 *  @param tag           The unique descriptive string associated with the action block.
 *  @param actionHandler The block of code will be executed when the gesture is recognized.
 *  @code
 [tap addActionTaged:@"handleSingleTap" actionHandler:^(UIGestureRecognizer * _Nonnull gestureRecognizer) {
    NSLog(@"Tap location: %@", NSStringFromCGPoint([gestureRecognizer locationInView:gestureRecognizer.view]));
 }];
 *  @endcode
 */
- (void)addActionTaged:(NSString *)tag actionHandler:(void(^)(UIGestureRecognizer *gestureRecognizer))actionHandler;

/**
 *  Remove the action block specified with the tag.
 *  @param tag The unique descriptive string associated with the action block.
 *  @code
 [tap removeActionForTag:@"handleSingleTap"];
 *  @endcode
 */
- (void)removeActionForTag:(NSString *)tag;

/**
 *  Remove all action blocks associated with the gesture.
 */
- (void)removeAllActions;

/**
 *  Returns all the tags associated with each action block added in gesture.
 */
- (nullable NSArray *)actionTags;

@end

NS_ASSUME_NONNULL_END