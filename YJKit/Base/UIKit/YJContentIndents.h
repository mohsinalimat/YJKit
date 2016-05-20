//
//  YJContentIndents.h
//  YJKit
//
//  Created by huang-kun on 16/5/14.
//  Copyright © 2016年 huang-kun. All rights reserved.
//

#ifndef YJContentIndents_h
#define YJContentIndents_h

#import <UIKit/UIGeometry.h>

typedef struct YJContentIndents {
    CGFloat top, left, bottom, right;
} YJContentIndents;

typedef NS_ENUM(NSInteger, YJContentIndentationStyle) {
    YJContentIndentationStyleNone,
    YJContentIndentationStyleDefault,
    YJContentIndentationStyleLarge,
};

UIKIT_STATIC_INLINE YJContentIndents YJContentIndentsMake(CGFloat top, CGFloat left, CGFloat bottom, CGFloat right) {
    YJContentIndents indents = { top, left, bottom, right };
    return indents;
}

UIKIT_STATIC_INLINE BOOL YJContentIndentsEqualToTitleIndents(YJContentIndents indents1, YJContentIndents indents2) {
    return indents1.top == indents2.top &&
            indents1.left == indents2.left &&
            indents1.bottom == indents2.bottom &&
            indents1.right == indents2.right;
}

UIKIT_EXTERN const YJContentIndents YJContentIndentsZero;

UIKIT_EXTERN NSString *NSStringFromYJContentIndents(YJContentIndents indents);

#endif /* YJContentIndents_h */
