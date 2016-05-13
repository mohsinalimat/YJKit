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
- (UIEdgeInsets)separatorInsetsForTableView;

// register header cell
- (nullable NSString *)reuseIdentifierForHeaderCell;
- (nullable NSString *)nibNameForRegisteringHeaderCell;
- (nullable Class)classForRegisteringHeaderCell;

// configure cells
- (void)configureHeaderCell:(__kindof UITableViewCell *)cell;
- (void)configureItemCell:(UITableViewCell *)cell atItemRow:(NSUInteger)itemRow;
- (void)configureSeparatorCell:(UITableViewCell *)cell;

- (UITableViewCellStyle)styleForItemCell;

- (NSArray <NSArray <NSString *> *> *)titlesForGroupedCells;
- (nullable NSArray <NSString *> *)subtitlesForItemCells;

- (nullable NSArray <UIImage *> *)iconImagesForItemCells;
- (nullable NSArray <NSString *> *)iconImageNamesForItemCells;

- (nullable NSArray <NSString *> *)classNamesOfDestinationViewControllersForItemCells;
- (nullable NSArray <NSString *> *)storyboardIdentifiersOfDestinationViewControllersForItemCells;
- (nullable NSString *)storyboardNameForControllerStoryboardIdentifier:(NSString *)storyboardID;

- (CGFloat)heightForItemCell;
- (CGFloat)heightForVerticalSpaceBetweenGroups;

// push action
- (BOOL)canPushDestinationViewControllerFromItemCellAtItemRow:(NSUInteger)itemRow;
- (void)configureDestinationViewControllerBeforePushing:(__kindof UIViewController *)viewController atItemRow:(NSUInteger)itemRow;

@end

extern const NSInteger YJGroupedStyleTableViewControllerHeaderCellForFittingSizeCalculationTag;

NS_ASSUME_NONNULL_END