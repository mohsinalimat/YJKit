//
//  YJTitleIndents.h
//  YJKit
//
//  Created by huang-kun on 16/5/14.
//  Copyright © 2016年 huang-kun. All rights reserved.
//

#ifndef YJTitleIndents_h
#define YJTitleIndents_h

#import <UIKit/UIGeometry.h>

typedef struct YJTitleIndents {
    CGFloat top, left, bottom, right;
} YJTitleIndents;

typedef NS_ENUM(NSInteger, YJTitleIndentationStyle) {
    YJTitleIndentationStyleNone,
    YJTitleIndentationStyleDefault,
    YJTitleIndentationStyleLarge,
};

UIKIT_STATIC_INLINE YJTitleIndents YJTitleIndentsMake(CGFloat top, CGFloat left, CGFloat bottom, CGFloat right) {
    YJTitleIndents indents = { top, left, bottom, right };
    return indents;
}

UIKIT_STATIC_INLINE BOOL YJTitleIndentsEqualToTitleIndents(YJTitleIndents indents1, YJTitleIndents indents2) {
    return indents1.top == indents2.top &&
            indents1.left == indents2.left &&
            indents1.bottom == indents2.bottom &&
            indents1.right == indents2.right;
}

UIKIT_EXTERN const YJTitleIndents YJTitleIndentsZero;

UIKIT_EXTERN NSString *NSStringFromYJTitleIndents(YJTitleIndents indents);

#endif /* YJTitleIndents_h */
