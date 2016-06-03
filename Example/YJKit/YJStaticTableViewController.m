//
//  YJStaticTableViewController.m
//  YJKit
//
//  Created by huang-kun on 16/5/17.
//  Copyright © 2016年 huang-kun. All rights reserved.
//

#import "YJStaticTableViewController.h"
#import "YJStaticHeaderCell.h"

@interface YJStaticTableViewController ()
@end

@implementation YJStaticTableViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [self.tableView registerHeaderCellForClassName:@"YJStaticHeaderCell"];
    
    [self.tableView registerCustomItemCellForClassName:@"YJStaticHeaderCell" inSection:0];
    [self.tableView registerCustomItemCellForClassName:@"YJStaticHeaderCell" inSection:3];
    
    self.tableView.itemCellStyle = UITableViewCellStyleSubtitle;
//    self.tableView.lineSeparatorDisplayMode = YJGroupedStyleTableViewSeparatorDisplayModeHideAll;
    
    self.tableView.lineSeparatorColor = [UIColor redColor];
}

- (NSArray <NSArray <NSString *> *> *)groupedTitles {
    return @[ @[ @""/*Custom Cell*/],
              @[ @"hello", @"world" ],
              @[ @"and", @"you" ],
              @[ @"hello", @"hi" ],
              @[ @"haha", @"hoho" ],
              @[ @"haha", @"hoho" ],
              @[ @"haha", @"hoho" ],
              @[ @"haha", @"hoho" ],
              @[ @"1", @"2", @"3", @"4" ],
              @[ @"hi" ] ];
}

- (NSInteger)numberOfSectionsInGroupedStyleTableView:(YJGroupedStyleTableView *)tableView {
    return self.groupedTitles.count;
}

- (NSInteger)tableView:(YJGroupedStyleTableView *)tableView numberOfGroupedItemRowsInSection:(NSInteger)section {
    return self.groupedTitles[section].count;
}

- (void)tableView:(YJGroupedStyleTableView *)tableView configureItemCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    cell.textLabel.text = self.groupedTitles[indexPath.section][indexPath.row];
    cell.detailTextLabel.text = self.groupedTitles[indexPath.section][indexPath.row];
}

- (void)tableView:(YJGroupedStyleTableView *)tableView configureSupplementaryCell:(UITableViewCell *)cell forElementOfKind:(NSString *)elementKind inSection:(NSInteger)section withDefaultTextAttributes:(NSDictionary *)attributes {
    // configure section header
    if (elementKind == YJGroupedStyleTableViewSupplementaryTopLine) {
        NSString *text = [NSString stringWithFormat:@"top: %@", @(section)];
        cell.textLabel.attributedText = [[NSAttributedString alloc] initWithString:text attributes:attributes];
    }
}

- (void)tableView:(YJGroupedStyleTableView *)tableView didSelectGroupedItemRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView cellForGroupedItemAtIndexPath:indexPath];
    NSLog(@"%@", cell);
}

- (void)tableView:(YJGroupedStyleTableView *)tableView didSelectHeaderCell:(__kindof UITableViewCell *)headerCell {
    NSLog(@"%@", headerCell);
}

- (void)tableView:(YJGroupedStyleTableView *)tableView configureCustomItemCell:(__kindof UITableViewCell *)customItemCell atIndexPath:(NSIndexPath *)indexPath {
    YJStaticHeaderCell *cell = (YJStaticHeaderCell *)customItemCell;
    cell.label.text = [NSString stringWithFormat:@"%@, %@", @(indexPath.section), @(indexPath.row)];
}

- (UITableViewCellStyle)tableView:(YJGroupedStyleTableView *)tableView groupedItemCellStyleInSection:(NSInteger)section {
    if (section == 5) {
        return UITableViewCellStyleValue1;
    } else if (section == 1) {
        return UITableViewCellStyleSubtitle;
    }
    return UITableViewCellStyleDefault;
}

@end
