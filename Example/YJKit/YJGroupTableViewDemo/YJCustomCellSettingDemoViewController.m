//
//  YJCustomCellSettingDemoViewController.m
//  YJKit
//
//  Created by Jack Huang on 16/6/3.
//  Copyright © 2016年 huang-kun. All rights reserved.
//

#import "YJCustomCellSettingDemoViewController.h"
#import "UIImage+YJCategory.h"

@interface YJCustomCellSettingDemoViewController ()

@end

@implementation YJCustomCellSettingDemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Custom Cell Group";
    [self.tableView registerCustomItemCellForClassName:@"YJCustomDemoCell" inSection:0];
    self.tableView.itemCellAccessoryType = UITableViewCellAccessoryNone;
}

// override it to change section structure.
- (NSArray <NSArray <NSString *> *> *)icons {
    return @[ @[ @"" ], // first section is preserved for a custom cell
              @[ @"like", @"mail" ],
              @[ @"message", @"money" ],
              @[ @"shirt", @"shop" ] ];
}

#pragma mark - YJGroupedStyleTableViewDataSource

- (UITableViewCellStyle)tableView:(YJGroupedStyleTableView *)tableView groupedItemCellStyleInSection:(NSInteger)section {
    switch (section) {
        case 0: return UITableViewCellStyleDefault;
        case 1: return UITableViewCellStyleSubtitle;
        case 2: case 3: return UITableViewCellStyleValue1;
    }
    return UITableViewCellStyleDefault;
}

#pragma mark - YJGroupedStyleTableViewDelegate

- (BOOL)tableView:(YJGroupedStyleTableView *)tableView shouldHighlightGroupedItemRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1) return NO;
    return YES;
}

- (void)tableView:(YJGroupedStyleTableView *)tableView configureItemCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    cell.imageView.image = [UIImage imageNamed:self.icons[indexPath.section][indexPath.row] scaledInBundle:self.iconBundle];
    cell.textLabel.text = self.icons[indexPath.section][indexPath.row];
    cell.detailTextLabel.text = self.icons[indexPath.section][indexPath.row];
    
    switch (indexPath.section) {
        case 2: cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator; break;
        case 3: cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton; break;
        case 1: {
            if (![cell.contentView.subviews.lastObject isKindOfClass:[UISwitch class]]) {
                UISwitch *switcher = [UISwitch new];
                switcher.center = (CGPoint){ cell.contentView.bounds.size.width - switcher.bounds.size.width,
                                             cell.contentView.bounds.size.height / 2 };
                [cell.contentView addSubview:switcher];
            }
        }
    }
}

// If you implemented one of the raw UITableViewDelegate method with indexPath parameter, you
// should convert the indexPath first, then use the converted indexPath, not the method parameter.
// For any method from YJGroupedStyleTableViewDataSource / Delegate, the indexPath parameter is converted.
- (void)tableView:(UITableView *)tableView didHighlightRowAtIndexPath:(NSIndexPath *)indexPath {
    NSIndexPath *itemIndexPath = [self indexPathForGroupedItemConvertedFromRawIndexPath:indexPath];
    NSLog(@"The item at section %@ row %@ is highlighted.", @(itemIndexPath.section), @(itemIndexPath.row));
}

@end
