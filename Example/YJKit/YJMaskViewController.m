//
//  YJMaskViewController.m
//  YJKit
//
//  Created by huang-kun on 16/4/28.
//  Copyright © 2016年 huang-kun. All rights reserved.
//

#import "YJMaskViewController.h"
#import "NSTimer+YJCategory.h"

@interface YJMaskViewController ()
@property (nonatomic, weak) NSTimer *timer;
@end

@implementation YJMaskViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 repeats:YES timerHandler:^(NSTimer * _Nonnull timer) {
        self.view.backgroundColor = (self.view.backgroundColor == [UIColor whiteColor]) ? [UIColor lightGrayColor] : [UIColor whiteColor];
    }];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.timer invalidate];
}

- (void)dealloc {
    NSLog(@"%@ dealloc", self.class);
}

@end
