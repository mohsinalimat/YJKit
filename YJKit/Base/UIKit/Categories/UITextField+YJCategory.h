//
//  UITextField+YJCategory.h
//  YJKit
//
//  Created by huang-kun on 16/5/25.
//  Copyright © 2016年 huang-kun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextField (YJCategory)

/// Whether resign first responder when user tap the background (textField's superview). Default is NO.
@property (nonatomic) IBInspectable BOOL autoResignFirstResponder;

@end
