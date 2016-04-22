//
//  YJSavingImageToAlbumViewController.m
//  YJKit
//
//  Created by huang-kun on 16/4/22.
//  Copyright © 2016年 huang-kun. All rights reserved.
//

#import "YJSavingImageToAlbumViewController.h"
#import "UIControl+YJCategory.h"
#import "UIAlertView+YJCategory.h"
#import "UIActionSheet+YJCategory.h"
#import "YJPhotoLibrary.h"
#import "UIDevice+YJCategory.h"
#import "UIImageView+YJCategory.h"
#import "YJObjcMacros.h"

@interface YJSavingImageToAlbumViewController ()
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIButton *saveButton;
@end

@implementation YJSavingImageToAlbumViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIImage *demoImage = [UIImage imageNamed:@"Octocat.png"];
    
    self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0,0,150,200)];
    self.imageView.backgroundColor = [UIColor lightGrayColor];
    // Make image both aspect fit and align bottom of image view, which is not allowed by setting imageView.contentMode
    self.imageView.yj_contentMode = YJViewContentModeScaleAspectFit | YJViewContentModeBottom;
    self.imageView.image = demoImage;
    [self.view addSubview:self.imageView];
    
    self.saveButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.saveButton setTitle:@"Tap to save" forState:UIControlStateNormal];
    [self.saveButton sizeToFit];
    [self.view addSubview:self.saveButton];
    
    // Using block-based APIs for nesting code
    @weakify(self)
    [self.saveButton addActionForControlEvents:UIControlEventTouchUpInside actionHandler:^(UIControl * _Nonnull sender) {
        UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Do you want to save the image to photo album ?" cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Save", nil];
        [actionSheet setActionHandler:^(UIActionSheet * _Nonnull actionSheet, NSInteger buttonIndex, NSString * _Nonnull buttonTitle) {
            if (actionSheet.firstOtherButtonIndex == buttonIndex) {
                // Save image to album
                [[YJPhotoLibrary sharedLibrary] saveImage:demoImage metadata:nil success:^{
                    [[[UIAlertView alloc] initWithTitle:@"Well Done" message:@"The image has been saved to the photo album under your app's name." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
                } failure:^(NSError * _Nonnull error) {
                    // If you deny the photo access, saving will be failed.
                    if (YJPhotoLibrary.authorizationStatus != YJPhotoLibraryAuthorizationStatusAuthorized) {
                        // For iOS 8 above, you can jump to setting and get photo access directly.
                        if (UIDevice.systemVersion > 8.0) {
                            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Failed" message:@"You do not have photo access. Tap the Setting button and turn on the photo switch if you'd like to save the image to photo album." cancelButtonTitle:@"Cancel" otherButtonTitles:@"Setting", nil];
                            [alert setActionHandler:^(UIAlertView * _Nonnull alertView, NSInteger buttonIndex, NSString * _Nonnull buttonTitle) {
                                if (alertView.firstOtherButtonIndex == buttonIndex) {
                                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
                                }
                            }];
                            [alert show];
                        } else {
                            [[[UIAlertView alloc] initWithTitle:@"Failed" message:@"You do not have photo access. Please go to Settings App -> Privacy -> Photo -> turn on the switch of your app if you'd like to save the image to photo album." cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
                        }
                    } else {
                        NSLog(@"Failed to save image with error: %@", error);
                    }
                }];
            }
        }];
        @strongify(self)
        [actionSheet showInView:self.view];
    }];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    CGPoint center = self.view.center;
    center.y -= 100;
    self.imageView.center = center;
    center.y += 200;
    self.saveButton.center = center;
}

- (void)dealloc {
    NSLog(@"%@ dealloc", self.class);
}

@end
