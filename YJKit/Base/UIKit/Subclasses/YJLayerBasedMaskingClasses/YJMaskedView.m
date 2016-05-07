//
//  YJMaskedView.m
//  YJKit
//
//  Created by huang-kun on 16/5/6.
//  Copyright © 2016年 huang-kun. All rights reserved.
//

#import "YJMaskedView.h"
#import "_YJLayerBasedMasking.h"
#import "YJDebugMacros.h"

@implementation YJMaskedView

// Add default YJLayerBasedMasking implementations
YJ_LAYER_BASED_MASKING_PROTOCOL_DEFAULT_IMPLEMENTATION_FOR_YJMASKEDVIEW_SUBCLASS

#if YJ_DEBUG
- (void)dealloc {
    NSLog(@"%@ dealloc", self.class);
}
#endif

@end
