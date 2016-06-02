//
//  UITextView+YJCategory.h
//  YJKit
//
//  Created by huang-kun on 16/5/25.
//  Copyright © 2016年 huang-kun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextView (YJCategory)

/// Whether resign first responder when user tap the background (textView's superview). Default is NO.
@property (nonatomic) IBInspectable BOOL autoResignFirstResponder;

/// The placeholder text for displaying when text view has no content.
/// @note Setting the placeholder text is actually setting the textView.attributedText
@property (nonatomic, copy, nullable) IBInspectable NSString *placeholder;

/// The color for placeholder text, default is [UIColor lightGrayColor].
@property (nonatomic, strong, null_resettable) IBInspectable UIColor *placeholderColor;

@end
