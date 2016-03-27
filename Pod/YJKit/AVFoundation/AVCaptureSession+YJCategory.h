//
//  AVCaptureSession+YJCategory.h
//  YJKit
//
//  Created by Jack Huang on 16/3/21.
//  Copyright © 2016年 Jack Huang. All rights reserved.
//

@import AVFoundation;

NS_ASSUME_NONNULL_BEGIN

@interface AVCaptureSession (YJCategory)

// video output
@property (nonatomic, readonly) BOOL supportAspectRatio_16_9;    // Output Aspect Ratio 16:9
@property (nonatomic, readonly) BOOL supportAspectRatio_4_3;     // Output Aspect Ratio 4:3

@property (nonatomic, readonly) BOOL support720p;   // HD
@property (nonatomic, readonly) BOOL support1080p;  // Full HD
@property (nonatomic, readonly) BOOL support4K;     // UHD

@property (nonatomic, readonly) BOOL supportCIF; // CIF quality
@property (nonatomic, readonly) BOOL supportVGA; // threshold VGA quality

- (void)set720p;    // 1280x720
- (void)set1080p;   // 1920x1080
- (void)set4K;      // 3840x2160
- (void)setCIF;     // 352x288
- (void)setVGA;     // 640x480 (VGA threshold)

@end

NS_ASSUME_NONNULL_END