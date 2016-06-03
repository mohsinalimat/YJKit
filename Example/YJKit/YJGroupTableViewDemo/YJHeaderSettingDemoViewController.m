//
//  YJHeaderSettingDemoViewController.m
//  YJKit
//
//  Created by Jack Huang on 16/6/3.
//  Copyright © 2016年 huang-kun. All rights reserved.
//

#import "YJHeaderSettingDemoViewController.h"

@interface YJHeaderSettingDemoViewController ()

@end

@implementation YJHeaderSettingDemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Header Group";

    [self.tableView registerHeaderCellForClassName:@"YJHeaderDemoCell"];
    self.tableView.extraTopMargin = 65.0;

    self.tableView.lineSeparatorIndentationStyle = YJGroupedStyleTableViewSeparatorIndentationStyleFixedMinimumMargin;
    self.tableView.lineSeparatorThicknessLevel = YJGroupedStyleTableViewSeparatorThicknessLevelThicker;
    self.tableView.lineSeparatorColor = [UIColor colorWithRed:0.000 green:0.502 blue:1.000 alpha:1.00];
    
    self.tableView.supplementaryRegionHeight = 80.0;
    self.tableView.supplementaryRegionBackgroundColor = [UIColor colorWithRed:0.957 green:0.965 blue:0.875 alpha:1.00];
    
    self.tableView.itemCellHeight = 55.0;
    self.tableView.itemCellBackgroundColor = [UIColor colorWithRed:0.988 green:0.965 blue:0.902 alpha:1.00];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}

#pragma mark - YJGroupedStyleTableViewDelegate

- (void)tableView:(YJGroupedStyleTableView *)tableView didSelectHeaderCell:(__kindof UITableViewCell *)headerCell {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
