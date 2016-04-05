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
@property (nonatomic, strong) NSTimer *timer;
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
    
//    static int i = 0;
//    [NSTimer scheduledTimerWithTimeInterval:1.0 repeats:YES timerHandler:^(NSTimer *timer) {
//        if (i > 4) {
//            i = 0;
//            [timer invalidate];
//        } else {
//            NSLog(@"i = %@ in %@", @(i), [self class]);
//        }
//        i++;
//    }];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.presentButton.center = self.view.center;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
//    [self.timer invalidate];
    [self removeAllObservedKeyPaths];
    NSLog(@"%@ dealloc", self.class);
}

@end
