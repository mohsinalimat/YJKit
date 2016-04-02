//
//  YJBlockViewController.m
//  YJKit
//
//  Created by huang-kun on 16/4/1.
//  Copyright © 2016年 huang-kun. All rights reserved.
//

#import "YJBlockViewController.h"
#import "UIControl+YJCategory.h"
#import "UIGestureRecognizer+YJCategory.h"
#import "UIBarButtonItem+YJCategory.h"
#import "UIAlertView+YJCategory.h"

#import "YJMacros.h"

@interface YJBlockViewController ()
@property (nonatomic, strong) UIButton *presentButton;
@end

@implementation YJBlockViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    [button setTitle:@"Present" forState:UIControlStateNormal];
    [button sizeToFit];
    button.center = self.view.center;
    [self.view addSubview:button];
    self.presentButton = button;
    
    @weakify(self)
    [button addActionForControlEvents:UIControlEventTouchUpInside actionBlock:^(UIControl *sender) {
        @strongify(self)
        YJBlockViewController *bvc = [[YJBlockViewController alloc] init];
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:bvc];
        @weakify(bvc)
        bvc.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Dismiss" style:UIBarButtonItemStyleDone actionBlock:^(UIBarButtonItem * _Nonnull barButtonItem) {
            @strongify(bvc)
            [bvc dismissViewControllerAnimated:YES completion:nil];
        }];
        [self presentViewController:nav animated:YES completion:nil];
    }];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.presentButton.center = self.view.center;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    NSLog(@"%@ dealloc", self.class);
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
