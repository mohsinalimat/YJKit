//
//  YJDefaultSettingDemoViewController.m
//  YJKit
//
//  Created by Jack Huang on 16/6/3.
//  Copyright © 2016年 huang-kun. All rights reserved.
//

#import "YJDefaultSettingDemoViewController.h"
#import "YJTargetDemoViewController.h"
#import "NSBundle+YJCategory.h"
#import "UIImage+YJCategory.h"

@interface YJDefaultSettingDemoViewController ()
@end

@implementation YJDefaultSettingDemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Default Group";
    self.iconBundle = [NSBundle bundleWithName:@"YJSettingIcons"];
    self.tableView.itemCellAccessoryType = UITableViewCellAccessoryDisclosureIndicator;
}

- (NSArray <NSArray <NSString *> *> *)icons {
    return @[ @[ @"like", @"mail", @"message" ],
              @[ @"money", @"shirt", @"shop" ] ];
}

#pragma mark - YJGroupedStyleTableViewDataSource

- (NSInteger)numberOfSectionsInGroupedStyleTableView:(YJGroupedStyleTableView *)tableView {
    return self.icons.count;
}

- (NSInteger)tableView:(YJGroupedStyleTableView *)tableView numberOfGroupedItemRowsInSection:(NSInteger)section {
    return self.icons[section].count;
}

#pragma mark - YJGroupedStyleTableViewDelegate

- (void)tableView:(YJGroupedStyleTableView *)tableView configureItemCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    cell.textLabel.text = self.icons[indexPath.section][indexPath.row];
    cell.imageView.image = [UIImage imageNamed:self.icons[indexPath.section][indexPath.row] scaledInBundle:self.iconBundle];
}

- (void)tableView:(YJGroupedStyleTableView *)tableView didSelectGroupedItemRowAtIndexPath:(NSIndexPath *)indexPath {
    YJTargetDemoViewController *targetVC = [YJTargetDemoViewController new];
    targetVC.view.backgroundColor = [UIColor whiteColor];
    targetVC.contentLabel.text = self.icons[indexPath.section][indexPath.row];
    [self.navigationController pushViewController:targetVC animated:YES];
}

@end
