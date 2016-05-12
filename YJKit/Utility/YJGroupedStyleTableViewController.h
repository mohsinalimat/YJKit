//
//  YJGroupedStyleTableViewController.h
//  YJKit
//
//  Created by huang-kun on 16/5/11.
//  Copyright © 2016年 huang-kun. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YJGroupedStyleTableViewController : UITableViewController

- (BOOL)shouldHideNavigationBar;

// table view
- (nullable UIColor *)backgroundColorForTableView;
- (nullable UIImage *)backgroundImageForTableView;

// register header cell
- (nullable NSString *)nibNameForRegisteringHeaderCell;
- (nullable Class)classForRegisteringHeaderCell;
- (NSString *)reuseIdentifierForHeaderCell;

// configure cells
- (void)configureHeaderCell:(__kindof UITableViewCell *)cell;
- (UITableViewCellStyle)styleForItemCell;

- (NSArray <NSArray <NSString *> *> *)titlesForGroupedCells;
- (nullable NSArray <NSString *> *)subtitlesForItemCells;

- (nullable NSArray <UIImage *> *)iconImagesForItemCells;
- (nullable NSArray <NSString *> *)iconImageNamesForItemCells;

- (nullable NSArray <NSString *> *)classNamesOfDestinationViewControllersForItemCells;
- (nullable NSArray <NSString *> *)storyboardIdentifiersOfDestinationViewControllersForItemCells;
- (NSString *)storyboardNameForControllerStoryboardIdentifier:(NSString *)storyboardID;

- (CGFloat)heightForItemCell;
- (CGFloat)heightForSeparator;

// push action
- (BOOL)canPushViewControllerFromItemCellAtIndexPath:(NSIndexPath *)indexPath;

@end

extern const NSInteger YJGroupedStyleTableViewControllerHeaderCellForFittingSizeCalculationTag;

NS_ASSUME_NONNULL_END