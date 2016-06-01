//
//  YJGroupedStyleTableViewController.h
//  YJKit
//
//  Created by huang-kun on 16/5/11.
//  Copyright © 2016年 huang-kun. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class YJGroupedStyleTableView;

// --------------------------------------------------------------------
//                   YJGroupedStyleTableViewDataSource
// --------------------------------------------------------------------

@protocol YJGroupedStyleTableViewDataSource <UITableViewDataSource>

@required

/// The number of item cells in each section.
- (NSInteger)tableView:(YJGroupedStyleTableView *)tableView numberOfGroupedItemRowsInSection:(NSInteger)section;

@optional

/// The number of sections for YJGroupedStyleTableView.
- (NSInteger)numberOfSectionsInGroupedStyleTableView:(YJGroupedStyleTableView *)tableView;

@end

// --------------------------------------------------------------------
//                    YJGroupedStyleTableViewDelegate
// --------------------------------------------------------------------

@protocol YJGroupedStyleTableViewDelegate <UITableViewDelegate>

@required

/// Configure the item cell at index path. MUST implement this method to fill the data for each item cell presenting on screen.
/// @note The indexPath parameter has being converted.
- (void)tableView:(YJGroupedStyleTableView *)tableView configureItemCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath;

@optional

/// Configure the registered header cell if needed.
- (void)tableView:(YJGroupedStyleTableView *)tableView configureHeaderCell:(__kindof UITableViewCell *)headerCell;

/// Configure section header cell if needed.
/// @note the attributes parameter can be set to NSAttributedString.
/** @code
 - (void)tableView:(YJGroupedStyleTableView *)tableView configureSectionHeaderCell:(UITableViewCell *)cell inSection:(NSInteger)section withDefaultTextAttributes:(NSDictionary *)attributes {
     NSString *text = [NSString stringWithFormat:@"Header: %@", @(section)];
     cell.textLabel.attributedText = [[NSAttributedString alloc] initWithString:text attributes:attributes];
 }
 *  @endcode
 */
- (void)tableView:(YJGroupedStyleTableView *)tableView configureSectionHeaderCell:(UITableViewCell *)cell inSection:(NSInteger)section withDefaultTextAttributes:(NSDictionary *)attributes;

/// Configure section footer cell if needed.
/// @note the attributes parameter can be set to NSAttributedString.
/** @code
 - (void)tableView:(YJGroupedStyleTableView *)tableView configureSectionFooterCell:(UITableViewCell *)cell inSection:(NSInteger)section withDefaultTextAttributes:(NSDictionary *)attributes {
     NSString *text = [NSString stringWithFormat:@"Footer: %@", @(section)];
     cell.textLabel.attributedText = [[NSAttributedString alloc] initWithString:text attributes:attributes];
 }
 *  @endcode
 */
- (void)tableView:(YJGroupedStyleTableView *)tableView configureSectionFooterCell:(UITableViewCell *)cell inSection:(NSInteger)section withDefaultTextAttributes:(NSDictionary *)attributes;


// Implementing these methods instead of original methods from UITableViewDelegate if needed.

// WARNING: If you implementing any of the raw UITableViewDelegate method, you must convert the indexPath
// parameter first before using it. e.g. If you have the YJGroupedStyleTableViewController subclass, then call
// -[groupedTableViewController indexPathForGroupedItemConvertedFromRawIndexPath:indexPath] inside of the
// UITableViewDelegate raw method implementation to get the index path for item cell, then use the converted
// index path rather then default parameter for your implementation.

/// Select item cell at indexPath
/// @note The indexPath parameter has being converted.
- (void)tableView:(YJGroupedStyleTableView *)tableView didSelectGroupedItemRowAtIndexPath:(NSIndexPath *)indexPath;

@required

/// @remark Implementing this method instead of -tableView:shouldHighlightRowAtIndexPath:
/// @note The indexPath parameter has being converted.
- (BOOL)tableView:(YJGroupedStyleTableView *)tableView shouldHighlightGroupedItemRowAtIndexPath:(NSIndexPath *)indexPath;

@end

// --------------------------------------------------------------------
//                        YJGroupedStyleTableView
// --------------------------------------------------------------------

typedef NS_ENUM(NSInteger, YJGroupedStyleTableViewSeparatorIndentationStyle) {
    YJGroupedStyleTableViewSeparatorIndentationStyleAlignItemCellTitle, // always align the title of the item cell
    YJGroupedStyleTableViewSeparatorIndentationStyleFixedMinimumMargin, // always keep the fixed minimum distance as left margin
};

typedef NS_ENUM(NSInteger, YJGroupedStyleTableViewSeparatorDisplayMode) {
    YJGroupedStyleTableViewSeparatorDisplayModeDefault,   // show all separators
    YJGroupedStyleTableViewSeparatorDisplayModeHideGroup, // hide group separators
    YJGroupedStyleTableViewSeparatorDisplayModeHideAll,   // hide all separators
};

@interface YJGroupedStyleTableView : UITableView

@property (nonatomic, weak, nullable) id <YJGroupedStyleTableViewDelegate> delegate;
@property (nonatomic, weak, nullable) id <YJGroupedStyleTableViewDataSource> dataSource;

// Customize separator

/// The separator display option of table view. Default is YJGroupedStyleTableViewSeparatorDisplayModeDefault.
/// @remark Do not set tableView.separatorStyle directly.
@property (nonatomic) YJGroupedStyleTableViewSeparatorDisplayMode lineSeparatorDisplayMode;

/// The indentation for separator. Default is YJGroupedStyleTableViewSeparatorIndentationStyleAlignItemCellTitle.
/// @discussion If you provide icon image for each item cell, the item cell's title will be shifted to the right and makes room for icon image. So the .AlignItemCellTitle option will make sure the separator will always align the title of the item cell, and the .FixedMinimumMargin option will make sure the separator has fixed indentation, which means it will align the icon image if has one, or align the title if cell does not has icon image.
/// @remark Do not set tableView.separatorStyle directly.
@property (nonatomic) YJGroupedStyleTableViewSeparatorIndentationStyle lineSeparatorIndentationStyle;

/// The separator color.
@property (nonatomic, strong, null_resettable) UIColor *lineSeparatorColor;

// Customize supplementary region between sections

/// The background color for supplementary region between sections, same meaning as tableView.backgroundColor.
/// @remark Do not set tableView.backgroundColor directly, Using this instead.
@property (nonatomic, strong, null_resettable) UIColor *supplementaryRegionBackgroundColor;

/// The vertical distance between each section.
@property (nonatomic) CGFloat supplementaryRegionHeight;

// Customize item cell

/// The style of item cell. Default is UITableViewCellStyleDefault.
@property (nonatomic) UITableViewCellStyle itemCellStyle;

/// The accessory type for item cell. Default is UITableViewCellAccessoryNone.
@property (nonatomic) UITableViewCellAccessoryType itemCellAccessoryType;

/// The background color for item cell.
/// @remark Using this property instead of set cell.contentView.backgroundColor directly.
@property (nonatomic, strong, null_resettable) UIColor *itemCellBackgroundColor;

/// The height for each item cell.
@property (nonatomic) CGFloat itemCellHeight;

// Get item cell by specifying item indexPath

/// Get a item cell for specified section and row.
/// @remark Using this method instead of -[UITableView cellForRowAtIndexPath:]
/// @note The indexPath parameter has being converted.
- (nullable UITableViewCell *)cellForGroupedItemAtIndexPath:(NSIndexPath *)indexPath;

@end

// --------------------------------------------------------------------
//                    YJGroupedStyleTableViewController
// --------------------------------------------------------------------

/**
 *  This is an ABSTRACT table view controller class for providing a custom grouped style table view.
 */
@interface YJGroupedStyleTableViewController : UITableViewController <YJGroupedStyleTableViewDataSource, YJGroupedStyleTableViewDelegate>

/// The custom grouped style table view.
@property (nonatomic, strong, null_resettable) YJGroupedStyleTableView *tableView;

/// Should hide navigation bar for table view displaying. Default is NO.
@property (nonatomic) BOOL shouldHideNavigationBar;

/// The class name for registering header cell.
/// @warning If the header cell class contains a nib file, the nib file name MUST be the same as it's class name. e.g. "MyHeaderCell.h", "MyHeaderCell.m", "MyHeaderCell.xib"
/// @warning It's not necessary to provide a reuse id for header cell. If you want to provide a reuse id (normally set in IB), make the reuse id as same as header cell's class name. However if you provide a different name for reuse id, an exception will be thrown.
@property (nonatomic, copy) NSString *classNameForRegisteringHeaderCell;

/// Get NSIndexPath for item cell from raw index path object;
/// @warning If you implementing one of the UITableViewDelegate method, convert the indexPath before use it.
/**
 @code
 - (void)tableView:(UITableView *)tableView didHighlightRowAtIndexPath:(NSIndexPath *)indexPath {
     NSIndexPath *itemIndexPath = [self indexPathForGroupedItemConvertedFromRawIndexPath:indexPath];
     // use converted itemIndexPath rather than raw indexPath parameter ...
 }
 @endcode
 */
- (nullable NSIndexPath *)indexPathForGroupedItemConvertedFromRawIndexPath:(NSIndexPath *)rawIndexPath;

@end

FOUNDATION_EXTERN NSInteger const YJGroupedStyleTableViewControllerHeaderCellTagForCompressedSizeCalculation;

NS_ASSUME_NONNULL_END