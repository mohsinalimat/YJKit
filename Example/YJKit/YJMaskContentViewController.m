//
//  YJMaskContentViewController.m
//  YJKit
//
//  Created by huang-kun on 16/5/19.
//  Copyright © 2016年 huang-kun. All rights reserved.
//

#import "YJMaskContentViewController.h"
#import "UITextView+YJCategory.h"

@interface YJMaskContentViewController ()
@property (nonatomic, strong) UITextView *textView;
@end

@implementation YJMaskContentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(50, 30, 200, 20)];
    textField.placeholder = @"hello";
    [self.view addSubview:textField];
    
    UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(50,80,200,200)];
    textView.placeholder = @"hello";
    [self.view addSubview:textView];
    
    self.textView = textView;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissTextView1)];
    [self.view addGestureRecognizer:tap];
}

- (void)dismissTextView1 {
    //[self.textView resignFirstResponder];
    NSLog(@"hello");
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.view.backgroundColor = [UIColor lightGrayColor];
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

@end
