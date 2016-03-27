//
//  YJViewController.m
//  YJKit
//
//  Created by huang-kun on 03/27/2016.
//  Copyright (c) 2016 huang-kun. All rights reserved.
//

#import "YJViewController.h"
#import "YJGeometryViewController.h"

@interface YJViewController ()

@end

@implementation YJViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    self.window.rootViewController = [[YJGeometryViewController alloc] init];
    [self.window makeKeyAndVisible];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
