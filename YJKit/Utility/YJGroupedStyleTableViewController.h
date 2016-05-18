//
//  YJGroupedStyleTableViewController.h
//  YJKit
//
//  Created by huang-kun on 16/5/11.
//  Copyright © 2016年 huang-kun. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, YJGroupedStyleTableViewCellIndentationStyle) {
    YJGroupedStyleTableViewCellIndentationStyleAlignTitle,
    YJGroupedStyleTableViewCellIndentationStyleFixedMargin,
};

typedef NS_ENUM(NSInteger, YJGroupedStyleTableViewSeparatorStyle) {
    YJGroupedStyleTableViewSeparatorStyleDefault,   // draw all separators
    YJGroupedStyleTableViewSeparatorStyleHideGroup, // hide group separators
    YJGroupedStyleTableViewSeparatorStyleHideAll,   // hide all separators
};

@interface YJGroupedStyleTableViewController : UITableViewController

// navigation bar
- (BOOL)shouldHideNavigationBar; // Default NO

// table view
- (nullable UIColor *)backgroundColorForTableView; // Default light Gray color
- (CGFloat)topEdgeInsetForTableView; // Default 0.0f, If navigation bar is displaying, the table view will below (not underneath) the navigation bar.
- (YJGroupedStyleTableViewSeparatorStyle)separatorStyleForTableView;

// register header cell
- (nullable NSString *)reuseIdentifierForHeaderCell; // Default nil
- (nullable NSString *)nibNameForRegisteringHeaderCell; // Default nil
- (nullable Class)classForRegisteringHeaderCell; // Default nil
- (nullable NSString *)classNameForRegisteringHeaderCell; // Default nil

// configure cells
- (UITableViewCellStyle)styleForItemCell; // Default UITableViewCellStyleDefault
- (YJGroupedStyleTableViewCellIndentationStyle)indentationStyleForItemCell; // Default YJGroupedStyleTableViewCellIndentationStyleAlignTitle

- (void)configureHeaderCell:(__kindof UITableViewCell *)cell; // Default do nothing
- (void)configureItemCell:(UITableViewCell *)cell forRow:(NSInteger)row inSection:(NSInteger)section; // Default do nothing
- (void)configureGroupSeparatorCell:(UITableViewCell *)cell; // Default do nothing

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
- (BOOL)canPushDestinationViewControllerFromItemCellForRow:(NSInteger)row inSection:(NSInteger)section; // Default YES
- (void)configureDestinationViewControllerBeforePushing:(__kindof UIViewController *)viewController forRow:(NSInteger)row inSection:(NSInteger)section; // Default do nothing

@end

FOUNDATION_EXPORT NSInteger const YJGroupedStyleTableViewControllerHeaderCellForCompressedSizeCalculation;

NS_ASSUME_NONNULL_END