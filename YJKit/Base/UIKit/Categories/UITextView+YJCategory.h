//
//  UITextView+YJCategory.h
//  YJKit
//
//  Created by huang-kun on 16/5/25.
//  Copyright © 2016年 huang-kun. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  The extension for UITextView class
 *
 *  1. Add placeholder support, just like -[UITextField placeholder]
 *  2. Automatic dismissing when user taps the background.
 */

@interface UITextView (YJCategory)

@property (nonatomic, copy, nullable) IBInspectable NSString *placeholder;
@property (nonatomic, strong, null_resettable) IBInspectable UIColor *placeholderColor; // default is [UIColor lightGrayColor]

@end
