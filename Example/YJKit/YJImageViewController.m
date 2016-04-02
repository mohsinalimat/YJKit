//
//  YJImageViewController.m
//  YJKit
//
//  Created by Jack Huang on 16/3/31.
//  Copyright © 2016年 Jack Huang. All rights reserved.
//

#import "YJImageViewController.h"
#import "UIImageView+YJCategory.h"
#import "UIImage+YJCategory.h"

@interface YJImageViewController ()

@end

@implementation YJImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    CGRect frame = self.view.bounds;
    frame.size.height -= 100;
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:frame];
    imageView.backgroundColor = [UIColor lightGrayColor];
    imageView.yj_contentMode = [self randomYJContentMode];
    imageView.image = [UIImage imageNamed:@"Octocat.png"];
    [self.view addSubview:imageView];
}

- (NSUInteger)randomYJContentMode {
    NSUInteger count = [self yjContentModes].count;
    NSUInteger index = arc4random_uniform((u_int32_t)count);
    return [[self yjContentModes][index] unsignedIntegerValue];
}

- (NSArray *)yjContentModes {
    return @[@0x00, @0x01, @0x02, @0x04, @0x08, @0x03, @0x09, @0x06, @0x0C, @0x10, @0x20, @(0x06 | 0x10), @(0x08 | 0x10), @(0x02 | 0x10), @(0x01 | 0x10)];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
