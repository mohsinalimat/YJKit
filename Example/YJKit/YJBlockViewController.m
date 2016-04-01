//
//  YJBlockViewController.m
//  YJKit
//
//  Created by Jack Huang on 16/4/1.
//  Copyright © 2016年 huang-kun. All rights reserved.
//

#import "YJBlockViewController.h"
#import "UIControl+YJCategory.h"
#import "YJMacros.h"

@interface YJBlockViewController ()

@end

@implementation YJBlockViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    [button setTitle:@"button" forState:UIControlStateNormal];
    [button sizeToFit];
    button.center = self.view.center;
    [self.view addSubview:button];
    
    @weakify(self)
    [button addActionForControlEvents:UIControlEventTouchUpInside actionBlock:^(UIControl *sender) {
        @strongify(self)
        NSLog(@"Button Title: %@", [(UIButton *)sender titleForState:UIControlStateNormal]);
        NSLog(@"%@", self.class);
    }];
    
    [button addActionForControlEvents:UIControlEventTouchDown actionBlock:^(UIControl *sender) {
        @strongify(self)
        NSLog(@"2 - Button Title: %@", [(UIButton *)sender titleForState:UIControlStateNormal]);
        NSLog(@"2 - %@", self.class);
    }];
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
