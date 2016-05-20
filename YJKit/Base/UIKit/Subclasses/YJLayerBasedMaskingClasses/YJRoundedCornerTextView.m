//
//  YJRoundedCornerTextView.m
//  YJKit
//
//  Created by huang-kun on 16/5/20.
//  Copyright © 2016年 huang-kun. All rights reserved.
//

#import "YJRoundedCornerTextView.h"
#import "_YJLayerBasedMasking.h"
#import "_YJRoundedCornerView.h"
#import "YJObjcMacros.h"
#import "NSObject+YJCategory_KVO.h"

@implementation YJRoundedCornerTextView

// Add default YJLayerBasedMasking implementations
YJ_LAYER_BASED_MASKING_PROTOCOL_DEFAULT_IMPLEMENTATION_FOR_UIVIEW_SUBCLASS

// Add default rounded corner implementations
YJ_ROUNDED_CORNER_VIEW_DEFAULT_IMPLEMENTATION_FOR_UIVIEW_SUBCLASS_WITH_EXTRA_INIT(

    self.textContainerInset = UIEdgeInsetsMake(10, 10, 10, 10);
    [self observingProperties];
)

- (void)observingProperties {
    @weakify(self)
    [self addObservedKeyPath:@"cornerRadius" handleChanges:^(id object, id _Nullable oldValue, id _Nullable newValue){
        @strongify(self)
        CGFloat inset = 0.0;
#if CGFLOAT_IS_DOUBLE
        inset = [newValue doubleValue] / 2;
#else 
        inset = [newValue floatValue] / 2;
#endif
        self.textContainerInset = UIEdgeInsetsMake(inset, inset, inset, inset);
    }];
}

- (void)dealloc {
    [self removeObservedKeyPath:@"cornerRadius"];
}

@end
