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

// navigation bar
- (BOOL)shouldHideNavigationBar; // Default YES
- (BOOL)shouldMaskNavigationBarBackgroundColor; // Default YES
- (BOOL)shouldHideNavigationBarShadow; // Default YES
- (BOOL)shouldTranslucentNavigationBar; // Default YES

// table view
- (nullable UIColor *)backgroundColorForTableView; // Default light Gray color
- (UIEdgeInsets)separatorInsetsForTableView; // Default (0,5,0,0)

// register header cell
- (nullable NSString *)reuseIdentifierForHeaderCell; // Default nil
- (nullable NSString *)nibNameForRegisteringHeaderCell; // Default nil
- (nullable Class)classForRegisteringHeaderCell; // Default nil

// configure cells
- (void)configureHeaderCell:(__kindof UITableViewCell *)cell; // Default do nothing
- (void)configureItemCell:(UITableViewCell *)cell atItemRow:(NSUInteger)itemRow; // Default do nothing
- (void)configureSeparatorCell:(UITableViewCell *)cell; // Default do nothing

- (UITableViewCellStyle)styleForItemCell; // Default UITableViewCellStyleDefault

- (NSArray <NSArray <NSString *> *> *)titlesForGroupedCells; // Default example placeholder
- (nullable NSArray <NSString *> *)subtitlesForItemCells; // Default nil

- (nullable NSArray <UIImage *> *)iconImagesForItemCells; // Default nil
- (nullable NSArray <NSString *> *)iconImageNamesForItemCells; // Default nil

- (nullable NSArray <NSString *> *)classNamesOfDestinationViewControllersForItemCells; // Default nil
- (nullable NSArray <NSString *> *)storyboardIdentifiersOfDestinationViewControllersForItemCells; // Default nil
- (nullable NSString *)storyboardNameForControllerStoryboardIdentifier:(NSString *)storyboardID; // Default @"Main"

- (CGFloat)heightForItemCell; // Default 44.0f
- (CGFloat)heightForVerticalSpaceBetweenGroups; // Default 8.0f

// push action
- (BOOL)canPushDestinationViewControllerFromItemCellAtItemRow:(NSUInteger)itemRow; // Default NO
- (void)configureDestinationViewControllerBeforePushing:(__kindof UIViewController *)viewController atItemRow:(NSUInteger)itemRow; // Default do nothing

@end

FOUNDATION_EXPORT NSInteger const YJGroupedStyleTableViewControllerHeaderCellForFittingSizeCalculationTag;

NS_ASSUME_NONNULL_END