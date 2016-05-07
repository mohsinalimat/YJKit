//
//  YJMaskedImageView.h
//  YJKit
//
//  Created by huang-kun on 16/5/5.
//  Copyright © 2016年 huang-kun. All rights reserved.
//

#import "YJLayerBasedMasking.h"

/**
 * This is an ABSTRACT class for displaying image with masked effect. For performance reason, it will not re-render the image for masking.
 */
@interface YJMaskedImageView : UIImageView <YJLayerBasedMasking>
@end
