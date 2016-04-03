//
//  YJBlockViewController.m
//  YJKit
//
//  Created by huang-kun on 16/4/1.
//  Copyright © 2016年 huang-kun. All rights reserved.
//

#import "YJBlockViewController.h"

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
    [button addActionForControlEvents:UIControlEventTouchUpInside actionHandler:^(UIControl *sender) {
        @strongify(self)
        YJBlockViewController *bvc = [[YJBlockViewController alloc] init];
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:bvc];
        @weakify(bvc)
        bvc.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Dismiss" style:UIBarButtonItemStyleDone actionHandler:^(UIBarButtonItem * _Nonnull barButtonItem) {
            @strongify(bvc)
            [bvc dismissViewControllerAnimated:YES completion:nil];
        }];
        [self presentViewController:nav animated:YES completion:nil];
    }];
    
    [button addObserverForKeyPath:@"hidden" valueChangeHandler:^(id object, id oldValue, id newValue) {
        NSLog(@"hidden changed");
    }];
    
    [button addObserverForKeyPath:@"hidden" valueChangeHandler:^(id object, id oldValue, id newValue) {
        NSLog(@"hidden changed again");
    }];
    
    button.hidden = YES;
    button.hidden = NO;
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.presentButton.center = self.view.center;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    // Dispose of any resources that can be recreated.
    [self.presentButton removeObserverForKeyPath:@"hidden"];
}

- (void)dealloc {
    NSLog(@"%@ dealloc", self.class);
}

@end
