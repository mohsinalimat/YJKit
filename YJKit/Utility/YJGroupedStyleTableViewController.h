//
//  YJGroupedStyleTableViewController.h
//  YJKit
//
//  Created by huang-kun on 16/5/11.
//  Copyright © 2016年 huang-kun. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

UIKIT_EXTERN NSString *const YJGroupedStyleTableViewSupplementarySectionHeader;
UIKIT_EXTERN NSString *const YJGroupedStyleTableViewSupplementarySectionFooter;
UIKIT_EXTERN NSString *const YJGroupedStyleTableViewSupplementaryTopLine;  // at the top-line of table view.

/// If you register a header cell, the configuration process for header cell can be performed for both
/// size calculation and final displaying. This tag is for specifying the cell is only for size calculation,
/// which means this tagged cell is not going to be displayed on screen eventually.
UIKIT_EXTERN NSInteger const YJGroupedStyleTableViewControllerHeaderCellTagForCompressedSizeCalculation;
UIKIT_EXTERN NSInteger const YJGroupedStyleTableViewControllerCustomItemCellTagForCompressedSizeCalculation;

@class YJGroupedStyleTableView;

// --------------------------------------------------------------------
//                   YJGroupedStyleTableViewDataSource
// --------------------------------------------------------------------

/**
 * Implementing YJGroupedStyleTableViewDataSource methods instead of their original version from UITableViewDataSource.
 */
@protocol YJGroupedStyleTableViewDataSource <UITableViewDataSource>

@required

/// The number of item cells in each section.
- (NSInteger)tableView:(YJGroupedStyleTableView *)tableView numberOfGroupedItemRowsInSection:(NSInteger)section;

@optional

/// The number of sections for YJGroupedStyleTableView.
- (NSInteger)numberOfSectionsInGroupedStyleTableView:(YJGroupedStyleTableView *)tableView;

/// The UITableViewCellStyle for cells at specified section.
/// @note If you implement this method, the itemCellStyle property for YJGroupedStyleTableView will be ignored.
- (UITableViewCellStyle)tableView:(YJGroupedStyleTableView *)tableView groupedItemCellStyleInSection:(NSInteger)section;

@end


// --------------------------------------------------------------------
//                    YJGroupedStyleTableViewDelegate
// --------------------------------------------------------------------

/**
 * Implementing YJGroupedStyleTableViewDelegate methods instead of their original version from UITableViewDelegate if needed.
 */
@protocol YJGroupedStyleTableViewDelegate <UITableViewDelegate>

@required

/// Configure the item cell at index path. MUST implement this method to fill the data for each item cell presenting on screen.
/// @note The indexPath parameter has being converted.
- (void)tableView:(YJGroupedStyleTableView *)tableView configureItemCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath;


@optional

/// Configure the registered header cell if needed.
/// @note If the headerCell parameter is tagged with YJGroupedStyleTableViewControllerHeaderCellTagForCompressedSizeCalculation,
/// which means this headerCell is not going to be displayed on screen.
/**
 * @code
 - (void)tableView:(YJGroupedStyleTableView *)tableView configureHeaderCell:(__kindof UITableViewCell *)headerCell {
     MyHeaderCell *cell = (MyHeaderCell *)headerCell;
     if (cell.tag != YJGroupedStyleTableViewControllerHeaderCellTagForCompressedSizeCalculation) {
         // This cell will be displayed on screen. You can set targer/action pair if needed.
     } else {
         // This cell is only for size calculation, and will never be shown on screen.
     }
 }
 * @endcode
 */
- (void)tableView:(YJGroupedStyleTableView *)tableView configureHeaderCell:(__kindof UITableViewCell *)headerCell;


/// Configure the registered custom item cell for specific section if needed.
/// @note If the customItemCell parameter is tagged with YJGroupedStyleTableViewControllerCustomItemCellTagForCompressedSizeCalculation,
/// which means this customItemCell is not going to be displayed on screen.
- (void)tableView:(YJGroupedStyleTableView *)tableView configureCustomItemCell:(__kindof UITableViewCell *)customItemCell atIndexPath:(NSIndexPath *)indexPath;


/// Configure supplementary cell if needed.
/// @note the elementKind can be one of these: YJGroupedStyleTableViewSupplementarySectionHeader, YJGroupedStyleTableViewSupplementarySectionFooter, YJGroupedStyleTableViewSupplementaryTopLine.
/// @note the attributes parameter can be set to NSAttributedString.
/** @code
 - (void)tableView:(YJGroupedStyleTableView *)tableView configureSupplementaryCell:(UITableViewCell *)cell forElementOfKind:(NSString *)elementKind inSection:(NSInteger)section withDefaultTextAttributes:(NSDictionary *)attributes {
     // configure section header
     if (elementKind == YJGroupedStyleTableViewSupplementarySectionHeader) {
         NSString *text = [NSString stringWithFormat:@"Header: %@", @(section)];
         cell.textLabel.attributedText = [[NSAttributedString alloc] initWithString:text attributes:attributes];
     }
 }
 *  @endcode
 */
- (void)tableView:(YJGroupedStyleTableView *)tableView configureSupplementaryCell:(UITableViewCell *)cell forElementOfKind:(NSString *)elementKind inSection:(NSInteger)section withDefaultTextAttributes:(NSDictionary *)attributes;


/// Select item cell or custom item cell at indexPath
/// @note The indexPath parameter has being converted.
- (void)tableView:(YJGroupedStyleTableView *)tableView didSelectGroupedItemRowAtIndexPath:(NSIndexPath *)indexPath;


/// Select header cell.
- (void)tableView:(YJGroupedStyleTableView *)tableView didSelectHeaderCell:(__kindof UITableViewCell *)headerCell;


/// @warning For grouped style table view, implementing -tableView:shouldHighlightRowAtIndexPath: directly from UITableViewDelegate will get unexpected behavior. If you do need so, then implement this method instead.
/// @note The indexPath parameter has being converted.
- (BOOL)tableView:(YJGroupedStyleTableView *)tableView shouldHighlightGroupedItemRowAtIndexPath:(NSIndexPath *)indexPath;

@end


// --------------------------------------------------------------------
//                        YJGroupedStyleTableView
// --------------------------------------------------------------------

typedef NS_ENUM(NSInteger, YJGroupedStyleTableViewSeparatorDisplayMode) {
    YJGroupedStyleTableViewSeparatorDisplayModeDefault,   // show all separators
    YJGroupedStyleTableViewSeparatorDisplayModeHideGroup, // hide group separators
    YJGroupedStyleTableViewSeparatorDisplayModeHideAll,   // hide all separators
};

typedef NS_ENUM(NSInteger, YJGroupedStyleTableViewSeparatorIndentationStyle) {
    YJGroupedStyleTableViewSeparatorIndentationStyleAlignItemCellTitle, // always align the title of the item cell
    YJGroupedStyleTableViewSeparatorIndentationStyleFixedMinimumMargin, // always keep the fixed minimum distance as left margin
};

typedef NS_ENUM(NSInteger, YJGroupedStyleTableViewSeparatorThicknessLevel) {
    YJGroupedStyleTableViewSeparatorThicknessLevelNormal,
    YJGroupedStyleTableViewSeparatorThicknessLevelThicker,
};

@interface YJGroupedStyleTableView : UITableView

@property (nonatomic, weak, nullable) id <YJGroupedStyleTableViewDelegate> delegate;
@property (nonatomic, weak, nullable) id <YJGroupedStyleTableViewDataSource> dataSource;


// Register nib or cell class

/// Register header cell class. If it contains a .xib file, it will register the nib instead.
/// @note The cell class must be a subclass of UITableViewCell. It will be displayed on top of the table view.
/// @warning If the cell class contains a nib file, the nib file name MUST be the same as it's class name. e.g. "MyCell.h", "MyCell.m", "MyCell.xib".
/// @warning It's not necessary to provide a reuse id for cell. If you want to provide a reuse id (normally set in IB), make sure the reuse id is also the same as cell's class name. However if you provide a different name for reuse id, an exception will be thrown.
- (void)registerHeaderCellForClassName:(NSString *)className;

/// Register custom item cell class for specified section. If it contains a .xib file, it will register the nib instead.
/// @note The cell class must be a subclass of UITableViewCell. It will be displayed on top of the table view.
/// @warning If the cell class contains a nib file, the nib file name MUST be the same as it's class name. e.g. "MyCell.h", "MyCell.m", "MyCell.xib".
/// @warning It's not necessary to provide a reuse id for cell. If you want to provide a reuse id (normally set in IB), make sure the reuse id is also the same as cell's class name. However if you provide a different name for reuse id, an exception will be thrown.
- (void)registerCustomItemCellForClassName:(NSString *)className inSection:(NSInteger)section;

/// This value will be applied on top of table view for extra inset. Default is 0.
@property (nonatomic) CGFloat extraTopMargin;


// Customize separator

/// The separator display option of table view. Default is YJGroupedStyleTableViewSeparatorDisplayModeDefault.
/// @remark Do not set tableView.separatorStyle directly.
@property (nonatomic) YJGroupedStyleTableViewSeparatorDisplayMode lineSeparatorDisplayMode;

/// The indentation for separator. Default is YJGroupedStyleTableViewSeparatorIndentationStyleAlignItemCellTitle.
/// @discussion If you provide icon image for each item cell, the item cell's title will be shifted to the right and makes room for icon image. So the .AlignItemCellTitle option will make sure the separator will always align the title of the item cell, and the .FixedMinimumMargin option will make sure the separator has fixed indentation, which means it will align the icon image if has one, or align the title if cell does not has icon image.
/// @remark Do not set tableView.separatorStyle directly.
/// @note This property is not effective for custom item cell.
@property (nonatomic) YJGroupedStyleTableViewSeparatorIndentationStyle lineSeparatorIndentationStyle;

/// The thickness of the separator. Default is Normal.
@property (nonatomic) YJGroupedStyleTableViewSeparatorThicknessLevel lineSeparatorThicknessLevel;

/// The separator color.
@property (nonatomic, strong, null_resettable) UIColor *lineSeparatorColor;


// Customize supplementary region between sections

/// The background color for supplementary region between sections, same meaning as tableView.backgroundColor.
/// @remark Do not set tableView.backgroundColor directly, Using this instead.
@property (nonatomic, strong, null_resettable) UIColor *supplementaryRegionBackgroundColor;

/// The vertical distance between each section.
@property (nonatomic) CGFloat supplementaryRegionHeight;


// Customize item cell

/// The style of all item cell. Default is UITableViewCellStyleDefault.
/// @note If you implement -tableView:groupedItemCellStyleInSection:
/// from YJGroupedStyleTableViewDataSource, this property will be ignored.
/// @note This property is not effective for custom item cell.
@property (nonatomic) UITableViewCellStyle itemCellStyle;

/// The accessory type for item cell. Default is UITableViewCellAccessoryNone.
/// @note This property is not effective for custom item cell.
@property (nonatomic) UITableViewCellAccessoryType itemCellAccessoryType;

/// The background color for item cell.
/// @remark Using this property instead of set cell.contentView.backgroundColor directly.
/// @note This property is not effective for custom item cell.
@property (nonatomic, strong, null_resettable) UIColor *itemCellBackgroundColor;

/// The height for each item cell.
/// @note This property is not effective for custom item cell.
@property (nonatomic) CGFloat itemCellHeight;


// Get item cell by specifying item indexPath

/// Get a item cell for specified section and row.
/// @remark Using this method instead of -[UITableView cellForRowAtIndexPath:]
/// @note MUST use the converted index path as a vaild parameter.
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


// WARNING: If you implementing any of the raw UITableViewDelegate method, you must convert the indexPath
// parameter first before using it. e.g. If you have the YJGroupedStyleTableViewController subclass, then call
// -[groupedTableViewController indexPathForGroupedItemConvertedFromRawIndexPath:indexPath] inside of the
// UITableViewDelegate raw method implementation to get the index path for item cell, then use the converted
// index path rather then default parameter for your implementation.

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

NS_ASSUME_NONNULL_END