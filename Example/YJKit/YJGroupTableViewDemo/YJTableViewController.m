//
//  YJTableViewController.m
//  YJKit
//
//  Created by Jack Huang on 16/6/3.
//  Copyright © 2016年 huang-kun. All rights reserved.
//

#import "YJTableViewController.h"

@interface YJTableViewController ()

@end

@implementation YJTableViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.title = @"GroupTable";
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}

#pragma mark - Table view

- (NSArray <NSString *> *)classNames {
    return @[ @"YJDefaultSettingDemoViewController",
              @"YJHeaderSettingDemoViewController",
              @"YJCustomCellSettingDemoViewController" ];
}

- (NSArray <NSString *> *)titles {
    return @[ @"Default Setting List Demo",
              @"Table List with header",
              @"Table List with a custom cell" ];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.titles.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YJDemoListCell"];
    if (!cell) cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"YJDemoListCell"];
    cell.textLabel.font = [UIFont systemFontOfSize:14.0];
    cell.textLabel.text = [self titles][indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *className = self.classNames[indexPath.row];
    Class controllerClass = NSClassFromString(className);
    UIViewController *controller = [[controllerClass alloc] init];
    controller.view.backgroundColor = [UIColor whiteColor];
    controller.edgesForExtendedLayout = UIRectEdgeNone;
    [self.navigationController pushViewController:controller animated:YES];
}

@end
