//
//  YJViewController.m
//  YJKit
//
//  Created by huang-kun on 03/27/2016.
//  Copyright (c) 2016 huang-kun. All rights reserved.
//

#import "YJViewController.h"
#import "YJGeometryViewController.h"
#import "YJGridViewController.h"

@interface YJViewController () <UITableViewDelegate, UITableViewDataSource>
@end

@implementation YJViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.title = @"YJKitDemo";
    [(UITableView *)self.view reloadData];
}

- (NSArray <NSString *> *)controllerClassNames {
    return @[@"YJGridViewController",
             @"YJGeometryViewController",
             @"YJSavingImageToAlbumViewController",
             @"YJCircularImageViewController"
             ];
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
    return [self controllerClassNames].count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YJCell"];
    if (!cell) cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"YJCell"];
    cell.textLabel.text = [self controllerClassNames][indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *className = [self controllerClassNames][indexPath.row];
    Class controllerClass = NSClassFromString(className);
    UIViewController *controller = [[controllerClass alloc] init];
    controller.title = className;
    controller.view.backgroundColor = [UIColor whiteColor];
    controller.edgesForExtendedLayout = UIRectEdgeNone;
    [self.navigationController pushViewController:controller animated:YES];
}

@end
