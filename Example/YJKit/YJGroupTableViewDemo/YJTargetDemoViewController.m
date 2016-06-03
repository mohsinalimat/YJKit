//
//  YJTargetDemoViewController.m
//  YJKit
//
//  Created by Jack Huang on 16/6/3.
//  Copyright © 2016年 huang-kun. All rights reserved.
//

#import "YJTargetDemoViewController.h"

@interface YJTargetDemoViewController ()

@end

@implementation YJTargetDemoViewController

-(void)viewDidLoad {
    [super viewDidLoad];
    
    self.contentLabel = [UILabel new];
    [self.view addSubview:self.contentLabel];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    
    [self.contentLabel sizeToFit];
    self.contentLabel.center = self.view.center;
}

@end
