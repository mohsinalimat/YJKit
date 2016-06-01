//
//  YJStaticTableViewController.m
//  YJKit
//
//  Created by huang-kun on 16/5/17.
//  Copyright © 2016年 huang-kun. All rights reserved.
//

#import "YJStaticTableViewController.h"

@interface YJStaticTableViewController ()
@end

@implementation YJStaticTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.classNameForRegisteringHeaderCell = @"YJStaticHeaderCell";
    self.shouldHideNavigationBar = YES;
    
    self.tableView.lineSeparatorColor = [UIColor redColor];
}

- (NSArray <NSArray <NSString *> *> *)titlesForGroupedCells {
    return @[ @[ @"hello", @"world" ],
              @[ @"and", @"you" ],
              @[ @"1", @"2", @"3", @"4" ],
              @[ @"hi" ]
              ];
}

- (NSInteger)numberOfSectionsInGroupedStyleTableView:(YJGroupedStyleTableView *)tableView {
    return self.titlesForGroupedCells.count;
}

- (NSInteger)tableView:(YJGroupedStyleTableView *)tableView numberOfGroupedItemRowsInSection:(NSInteger)section {
    return self.titlesForGroupedCells[section].count;
}

- (void)tableView:(YJGroupedStyleTableView *)tableView configureItemCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    NSArray *titles = self.titlesForGroupedCells[indexPath.section];
    NSString *title = titles[indexPath.row];
    cell.textLabel.text = title;
}

- (void)tableView:(YJGroupedStyleTableView *)tableView configureSectionHeaderCell:(UITableViewCell *)cell inSection:(NSInteger)section withDefaultTextAttributes:(NSDictionary *)attributes {
    NSString *text = [NSString stringWithFormat:@"Header: %@", @(section)];
    cell.textLabel.attributedText = [[NSAttributedString alloc] initWithString:text attributes:attributes];
}

- (void)tableView:(YJGroupedStyleTableView *)tableView configureSectionFooterCell:(UITableViewCell *)cell inSection:(NSInteger)section withDefaultTextAttributes:(NSDictionary *)attributes {
    NSString *text = [NSString stringWithFormat:@"Footer: %@", @(section)];
    cell.textLabel.attributedText = [[NSAttributedString alloc] initWithString:text attributes:attributes];
}

- (void)tableView:(YJGroupedStyleTableView *)tableView didSelectGroupedItemRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView cellForGroupedItemAtIndexPath:indexPath];
    NSLog(@"%@", cell);
}

@end
