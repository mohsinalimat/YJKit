//
//  AVCaptureSession+YJCategory.m
//  YJKit
//
//  Created by huang-kun on 16/3/21.
//  Copyright © 2016年 huang-kun. All rights reserved.
//

#import "AVCaptureSession+YJCategory.h"
#import "UIDevice+YJCategory.h"

@implementation AVCaptureSession (YJCategory)

#pragma mark - properties

- (BOOL)support720p     { return [self canSetSessionPreset:AVCaptureSessionPreset1280x720]; }
- (BOOL)support1080p    { return [self canSetSessionPreset:AVCaptureSessionPreset1920x1080]; }
- (BOOL)support4K       { return UIDevice.systemVersion >= 9.0 ? [self canSetSessionPreset:AVCaptureSessionPreset3840x2160] : NO; }
- (BOOL)supportCIF      { return [self canSetSessionPreset:AVCaptureSessionPreset352x288]; }
- (BOOL)supportVGA      { return [self canSetSessionPreset:AVCaptureSessionPreset640x480]; }

- (BOOL)supportAspectRatio_16_9  { return self.support720p || self.support1080p || self.support4K; }
- (BOOL)supportAspectRatio_4_3   { return self.supportVGA; }

#pragma mark - methods

- (void)set720p     { self.sessionPreset = AVCaptureSessionPreset1280x720; }
- (void)set1080p    { self.sessionPreset = AVCaptureSessionPreset1920x1080; }
- (void)set4K       { if (UIDevice.systemVersion >= 9.0) self.sessionPreset = AVCaptureSessionPreset3840x2160; };
- (void)setCIF      { self.sessionPreset = AVCaptureSessionPreset352x288; };
- (void)setVGA      { self.sessionPreset = AVCaptureSessionPreset640x480; };

@end
