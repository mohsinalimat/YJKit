//
//  YJViewController.m
//  YJKit
//
//  Created by huang-kun on 03/27/2016.
//  Copyright (c) 2016 huang-kun. All rights reserved.
//

#import "YJViewController.h"

@interface YJViewController () <UITableViewDelegate, UITableViewDataSource>
@end

@implementation YJViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"YJKitDemo";
    [(UITableView *)self.view reloadData];
}

- (NSArray <NSString *> *)listNames {
    return @[@"Alignment and scaling",
             @"Image displaying and saving",
             @"Rounded corner views",
             @"Rounded corner views with content",
             @"Layer blending demo",
             @"Static Table View"];
}

- (NSArray <NSString *> *)classNamesForControllers {
    return @[@"YJGeometryViewController",
             @"YJSavingImageToAlbumViewController",
             @"YJMaskViewController",
             @"YJMaskContentViewController",
             @"YJMaskTableViewController",
             @"YJStaticTableViewController"];
}

- (void)loadView {
    UITableView *tableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];
    tableView.backgroundColor = [UIColor whiteColor];
    tableView.dataSource = self;
    tableView.delegate = self;
    self.view = tableView;
}

#pragma mark - table view

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self classNamesForControllers].count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YJDemoListCell"];
    if (!cell) cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"YJDemoListCell"];
    cell.textLabel.font = [UIFont systemFontOfSize:14.0];
    cell.textLabel.text = [self listNames][indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *className = [self classNamesForControllers][indexPath.row];
    Class controllerClass = NSClassFromString(className);
    UIViewController *controller = [[controllerClass alloc] init];
    controller.view.backgroundColor = [UIColor whiteColor];
    controller.edgesForExtendedLayout = UIRectEdgeNone;
    [self.navigationController pushViewController:controller animated:YES];
}

@end
