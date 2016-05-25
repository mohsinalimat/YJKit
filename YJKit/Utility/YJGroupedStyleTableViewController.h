//
//  YJGroupedStyleTableViewController.h
//  YJKit
//
//  Created by huang-kun on 16/5/11.
//  Copyright © 2016年 huang-kun. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

// YJGroupedStyleTableView

@interface YJGroupedStyleTableView : UITableView

- (nullable UITableViewCell *)cellForGroupedItemAtRow:(NSInteger)row inSection:(NSInteger)section;

@end

// YJGroupedStyleTableViewController

typedef NS_ENUM(NSInteger, YJGroupedStyleTableViewCellIndentationStyle) {
    YJGroupedStyleTableViewCellIndentationStyleAlignTitle,
    YJGroupedStyleTableViewCellIndentationStyleFixedMargin,
};

typedef NS_ENUM(NSInteger, YJGroupedStyleTableViewSeparatorStyle) {
    YJGroupedStyleTableViewSeparatorStyleDefault,   // draw all separators
    YJGroupedStyleTableViewSeparatorStyleHideGroup, // hide group separators
    YJGroupedStyleTableViewSeparatorStyleHideAll,   // hide all separators
};

/**
    *  This is an ABSTRACT table view controller class for providing a grouped style table view.
    *
    *  The reason for using this class instead of UITableViewController with a UITableViewStyleGrouped style is it can provide much detail customizations such as translucent navigation bar; new color for cell separators and group background; custom height for group space; convenient separator indentation and its custom appearance; easy to fill-in light-weight data informations for cell displaying and destination controller class name for pushing onto screen when user tap the cell.
    *
    *  Only need to make a subclass of YJGroupedStyleTableViewController and override some of these methods if needed to provide the informations you want to customize.
    *
    *  @code

    // Providing titles for cell content (Required)

    - (NSArray <NSArray <NSString *> *> *)titlesForGroupedCells {
        return @[  @[ @"First item in group A" ],
                   @[ @"First item in group B", @"Second item in group B", @"Third item in group B" ],
                   @[ @"First item in group C", @"Second item in group C" ] ];
    }

    // Providing subtitles for cell content (Optional)

    - (nullable NSArray *)subtitlesForItemCells {
        return @[   @[ @"group A - item 1" ],
                    @[ @"group B - item 1", @"group B - item 2", @"group B - item 3" ],
                    @[ @"group C - item 1", @"group C - item 2" ] ];
    }

    // or you can make it plain array without nesting, but must keep the correct order.

    - (nullable NSArray *)subtitlesForItemCells {
        return @[@"group A - item 1",
                 @"group B - item 1",
                 @"group B - item 2",
                 @"group B - item 3",
                 @"group C - item 1",
                 @"group C - item 2" ];
    }

    // To summarize, only -titlesForGroupedCells MUST return nesting array for grouping data to each section, and the rest of informations can be compatible with both nesting and plain array.

    // These methods can return either nested array or plain array

    - (nullable NSArray *)subtitlesForItemCells; // Array of NSString, Default nil
    - (nullable NSArray *)iconImagesForItemCells; // Array of UIImage, Default nil
    - (nullable NSArray *)iconImageNamesForItemCells; // Array of NSString, Default nil
    - (nullable NSArray *)classNamesOfDestinationViewControllersForItemCells; // Array of NSString, Default nil
    - (nullable NSArray *)storyboardIdentifiersOfDestinationViewControllersForItemCells; // Array of NSString, Default nil

    *  @endcode
 */
@interface YJGroupedStyleTableViewController : UITableViewController

// the table view property
@property (nonatomic, strong, null_resettable) YJGroupedStyleTableView *tableView;

// custom navigation bar
- (BOOL)shouldHideNavigationBar; // Default NO

// custom table view
- (UIColor *)backgroundColorForTableView; // Default is the same color as Settings App table view background color.
- (CGFloat)topEdgeInsetForTableView; // Default 0.0f, If navigation bar is displaying, the table view will below (not underneath) the navigation bar.

// custom line separator
- (YJGroupedStyleTableViewSeparatorStyle)lineSeparatorStyleForTableView;
- (UIColor *)lineSeparatorColorForTableView; // Default is the same color as Settings App separator color.

// custom group separator
- (void)configureGroupSeparatorCell:(UITableViewCell *)cell; // Default do nothing

// custom header cell
- (nullable NSString *)reuseIdentifierForHeaderCell; // Default nil
- (nullable NSString *)nibNameForRegisteringHeaderCell; // Default nil
- (nullable Class)classForRegisteringHeaderCell; // Default nil
- (nullable NSString *)classNameForRegisteringHeaderCell; // Default nil
- (void)configureHeaderCell:(__kindof UITableViewCell *)cell; // Default do nothing

// custom item cells
- (UITableViewCellStyle)styleForItemCell; // Default UITableViewCellStyleDefault
- (YJGroupedStyleTableViewCellIndentationStyle)indentationStyleForItemCell; // Default YJGroupedStyleTableViewCellIndentationStyleAlignTitle
- (UIColor *)backgroundColorForItemCell; // Default [UIColor whiteColor];
- (void)configureItemCell:(UITableViewCell *)cell forRow:(NSInteger)row inSection:(NSInteger)section; // Default do nothing

// custom content for item cells
- (NSArray <NSArray <NSString *> *> *)titlesForGroupedCells; // Default example placeholder
- (nullable NSArray *)subtitlesForItemCells; // Default nil

- (nullable NSArray *)iconImagesForItemCells; // Array of UIImage, Default nil
- (nullable NSArray *)iconImageNamesForItemCells; // Array of NSString, Default nil

- (nullable NSArray *)classNamesOfDestinationViewControllersForItemCells; // Array of NSString, Default nil
- (nullable NSArray *)storyboardIdentifiersOfDestinationViewControllersForItemCells; // Array of NSString, Default nil
- (nullable NSString *)storyboardNameForControllerStoryboardIdentifier:(NSString *)storyboardID; // Array of NSString, Default @"Main"

- (CGFloat)heightForItemCell; // Default 44.0f
- (CGFloat)heightForVerticalSpaceBetweenGroups; // Default 40.0f

// tap action
- (void)tableView:(YJGroupedStyleTableView *)tableView didSelectItemCellAtRow:(NSInteger)row inSection:(NSInteger)section; // Default do nothing

// push action
- (BOOL)canPushDestinationViewControllerFromItemCellForRow:(NSInteger)row inSection:(NSInteger)section; // Default YES
- (void)configureDestinationViewControllerBeforePushing:(__kindof UIViewController *)viewController forRow:(NSInteger)row inSection:(NSInteger)section; // Default do nothing

@end

FOUNDATION_EXPORT NSInteger const YJGroupedStyleTableViewControllerHeaderCellForCompressedSizeCalculation;

NS_ASSUME_NONNULL_END