//
//  YJImageViewController.m
//  YJKit
//
//  Created by Jack Huang on 16/3/31.
//  Copyright © 2016年 huang-kun. All rights reserved.
//

#import "YJImageViewController.h"
#import "UIImageView+YJCategory.h"

@interface YJImageViewController ()

@end

@implementation YJImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    imageView.yj_contentMode = YJViewContentModeScaleAspectFit | YJViewContentModeTop;
    imageView.image = [UIImage imageNamed:@"Octocat.png"];
    [self.view addSubview:imageView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
