//
//  YJGroupedStyleTableViewController.h
//  YJKit
//
//  Created by huang-kun on 16/5/11.
//  Copyright © 2016年 huang-kun. All rights reserved.
//

#import "YJGroupedStyleTableViewController.h"
#import "NSObject+YJRuntimeSwizzling.h"
#import "NSArray+YJSequence.h"
#import "NSArray+YJCollection.h"
#import "YJUIMacros.h"

#define YJGSTVC_DEFAULT_TABLE_BACKGROUND_COLOR [UIColor colorWithRed:0.937 green:0.937 blue:0.957 alpha:1.00]
#define YJGSTVC_DEFAULT_ITEM_CELL_BACKGROUND_COLOR [UIColor whiteColor]
#define YJGSTVC_DEFAULT_LINE_SEPARATOR_COLOR [UIColor colorWithRed:0.784 green:0.780 blue:0.800 alpha:1.00]

@interface _YJGroupedStyleItemCell : UITableViewCell
@end

@implementation _YJGroupedStyleItemCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = YJGSTVC_DEFAULT_ITEM_CELL_BACKGROUND_COLOR;
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    return self;
}

@end


@interface _YJGroupedStyleGroupSeparatorCell : UITableViewCell
@end

@implementation _YJGroupedStyleGroupSeparatorCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = YJGSTVC_DEFAULT_TABLE_BACKGROUND_COLOR;
        self.backgroundColor = YJGSTVC_DEFAULT_TABLE_BACKGROUND_COLOR; // hide 1px separator space
    }
    return self;
}

@end


@interface _YJGroupedStyleLineSeparatorCell : UITableViewCell

@property (nonatomic) CGFloat leftIndentation;
@property (nonatomic, strong) UIColor *lineColor; // It's dangerous to name "separatorColor" if you override it's setter because it replaces system internal method -setSeparatorColor: for UITableViewCell
@property (nonatomic, strong) UIColor *compensatedColor;

@end

@implementation _YJGroupedStyleLineSeparatorCell {
    UIView *_indentView; // white space for left indentation
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _indentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 1)];
        [self.contentView addSubview:_indentView];
        
        [self setLineColor:YJGSTVC_DEFAULT_LINE_SEPARATOR_COLOR];
        [self setCompensatedColor:YJGSTVC_DEFAULT_ITEM_CELL_BACKGROUND_COLOR];
    }
    return self;
}

- (void)setLeftIndentation:(CGFloat)leftIndentation {
    _leftIndentation = leftIndentation;
    CGRect frame = _indentView.frame;
    frame.size.width = _leftIndentation;
    _indentView.frame = frame;
}

- (void)setLineColor:(UIColor *)lineColor {
    self.contentView.backgroundColor = lineColor;
    self.backgroundColor = lineColor;
}

- (UIColor *)lineColor {
    return self.contentView.backgroundColor;
}

- (void)setCompensatedColor:(UIColor *)compensatedColor {
    _indentView.backgroundColor = compensatedColor;
}

- (UIColor *)compensatedColor {
    return _indentView.backgroundColor;
}

@end


#define YJGSTVC_HEADER_CELL_REUSE_ID @"_YJGSTVC_HEADER_CELL_REUSE_ID"
#define YJGSTVC_ITEM_CELL_REUSE_ID @"_YJGSTVC_ITEM_CELL_REUSE_ID"
#define YJGSTVC_GROUP_SEPARATOR_CELL_REUSE_ID @"_YJGSTVC_GROUP_SEPARATOR_CELL_REUSE_ID"
#define YJGSTVC_LINE_SEPARATOR_CELL_REUSE_ID @"_YJGSTVC_LINE_SEPARATOR_CELL_REUSE_ID"

#define YJGSHeaderCell @"_YJGSHeaderCell"
#define YJGSItemCell @"_YJGSItemCell"

#define YJGSGroupSeparator @"_YJGSGroupSeparator"
#define YJGSLineSeparator @"_YJGSLineSeparator"

#define YJGSLineSeparatingGroup @"_YJGSLineSeparatingGroup"
#define YJGSLineSeparatingItemCell @"_YJGSLineSeparatingItemCell"

static const CGFloat kYJGSTVCLastGroupSeparatorCellHeight = 999.0f;
static const CGFloat kYJGSTVCBottomSpaceFromLastCell = 50.0f;

@interface YJGroupedStyleTableViewController ()

@property (nonatomic, copy) NSArray <NSString *> *mappedRows; // stored information for each row in one section
@property (nonatomic, strong) UIColor *backgroundColorForHeaderCell; // @dynamic
@property (nonatomic, assign) CGFloat heightForHeaderCell;
@property (nonatomic, assign) BOOL didRegisterHeaderCell;
@property (nonatomic, assign) BOOL hasProvidedIconForItemCell;

@end

@implementation YJGroupedStyleTableViewController

@dynamic tableView;

- (instancetype)initWithStyle:(UITableViewStyle)style {
    self = [super initWithStyle:UITableViewStylePlain];
    if (self) [self _mapDataFromYJGroupedStyleTableViewDataSource];
    return self;
}

- (void)loadView {
    YJGroupedStyleTableView *tableView = [[YJGroupedStyleTableView alloc] initWithFrame:kUIScreenBounds style:UITableViewStylePlain];
    
    tableView.backgroundColor = YJGSTVC_DEFAULT_TABLE_BACKGROUND_COLOR;
    tableView.contentInset = (UIEdgeInsets){ 0, 0, kYJGSTVCBottomSpaceFromLastCell - kYJGSTVCLastGroupSeparatorCellHeight, 0 };
    
    tableView.lineSeparatorIndentationStyle = YJGroupedStyleTableViewSeparatorIndentationStyleAlignItemCellTitle;
    tableView.lineSeparatorDisplayMode = YJGroupedStyleTableViewSeparatorDisplayModeDefault;
    tableView.lineSeparatorColor = YJGSTVC_DEFAULT_LINE_SEPARATOR_COLOR;
    
    tableView.supplementaryRegionVerticalSpace = 40.0;
    
    tableView.itemCellStyle = UITableViewCellStyleDefault;
    tableView.itemCellAccessoryType = UITableViewCellAccessoryNone;
    tableView.itemCellBackgroundColor = YJGSTVC_DEFAULT_ITEM_CELL_BACKGROUND_COLOR;
    tableView.itemCellHeight = 44.0f;
    
    // hide default separators
    tableView.separatorColor = [UIColor clearColor];
    tableView.separatorInset = UIEdgeInsetsMake(0, 9999, 0, 0);
    
    tableView.delegate = (id)self;
    tableView.dataSource = (id)self;
    
    self.view = tableView;
}

#pragma mark - Mapping

- (void)_mapDataFromYJGroupedStyleTableViewDataSource {
    NSMutableArray *mappedRows = @[ YJGSHeaderCell, YJGSGroupSeparator, YJGSLineSeparator ].mutableCopy;
    NSUInteger row = 3; // row for each UITableViewCell
    NSInteger sections = 1;
    
    if ([self.tableView.dataSource respondsToSelector:@selector(numberOfSectionsInGroupedStyleTableView:)]) {
        sections = [self.tableView.dataSource numberOfSectionsInGroupedStyleTableView:self.tableView];
    }
    
    for (NSUInteger i = 0; i < sections; ++i) {
        NSInteger rowsInSection = [self.tableView.dataSource tableView:self.tableView numberOfGroupedItemRowsInSection:i];
        for (NSUInteger j = 0; j < rowsInSection; ++j) {
            mappedRows[row++] = [NSString stringWithFormat:@"%@:%@,%@", YJGSItemCell, @(i), @(j)];
            mappedRows[row++] = [NSString stringWithFormat:@"%@:%@", YJGSLineSeparator, YJGSLineSeparatingItemCell];
        }
        mappedRows[row-1] = [NSString stringWithFormat:@"%@:%@", YJGSLineSeparator, YJGSLineSeparatingGroup];
        mappedRows[row++] = [NSString stringWithFormat:@"%@:%@", YJGSGroupSeparator, @(i)];
        mappedRows[row++] = [NSString stringWithFormat:@"%@:%@", YJGSLineSeparator, YJGSLineSeparatingGroup];
    }
    [mappedRows removeLastObject];
    
    _mappedRows = [mappedRows copy];
}

- (nullable NSIndexPath *)indexPathForGroupedItemCellFromRawIndexPath:(NSIndexPath *)rawIndexPath {
    if (![self.mappedRows[rawIndexPath.row] hasPrefix:YJGSItemCell]) return nil;
    NSArray *indexPathInfo = [[self.mappedRows[rawIndexPath.row] componentsSeparatedByString:@":"].lastObject componentsSeparatedByString:@","];
    return [NSIndexPath indexPathForRow:[indexPathInfo.lastObject integerValue] inSection:[indexPathInfo.firstObject integerValue]];
}

#pragma mark - Life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // registering group separator
    [self.tableView registerClass:[_YJGroupedStyleGroupSeparatorCell class] forCellReuseIdentifier:YJGSTVC_GROUP_SEPARATOR_CELL_REUSE_ID];
    // registering line separator
    [self.tableView registerClass:[_YJGroupedStyleLineSeparatorCell class] forCellReuseIdentifier:YJGSTVC_LINE_SEPARATOR_CELL_REUSE_ID];
    // set table view below status bar
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.extendedLayoutIncludesOpaqueBars = NO;
    self.automaticallyAdjustsScrollViewInsets = NO;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (self.shouldHideNavigationBar) {
        [self.navigationController setNavigationBarHidden:YES animated:animated];
    }
}

#pragma mark - Accessors

// make table view's background color as same as the header cell,
// so when user pulls down the table view, the color looks uniformed.
- (void)setBackgroundColorForHeaderCell:(UIColor *)backgroundColorForHeaderCell {
    self.tableView.backgroundColor = backgroundColorForHeaderCell;
    self.tableView.superview.backgroundColor = backgroundColorForHeaderCell;
}

- (UIColor *)backgroundColorForHeaderCell {
    return self.tableView.backgroundColor;
}

- (void)setClassNameForRegisteringHeaderCell:(NSString *)classNameForRegisteringHeaderCell {
    _classNameForRegisteringHeaderCell = classNameForRegisteringHeaderCell;
    
    // registering header cell
    NSString *className = _classNameForRegisteringHeaderCell;
    if (className.length) {
        if (self.hasNibFileForHeaderCellClass) {
            [self.tableView registerNib:[UINib nibWithNibName:className bundle:nil] forCellReuseIdentifier:className];
            self.didRegisterHeaderCell = YES;
        } else {
            [self.tableView registerClass:NSClassFromString(className) forCellReuseIdentifier:className];
            self.didRegisterHeaderCell = YES;
        }
    }
}

- (BOOL)hasNibFileForHeaderCellClass {
    if (!_classNameForRegisteringHeaderCell.length) return NO;
    NSString *path = [[NSBundle mainBundle] pathForResource:_classNameForRegisteringHeaderCell ofType:@"nib"]; // not "xib" !
    return path.length ? YES : NO;
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.mappedRows.count;
}

- (UITableViewCell *)tableView:(YJGroupedStyleTableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger row = indexPath.row;
    UITableViewCell *cell = nil;
    
    UIColor *tableBGColor = tableView.supplementaryRegionBackgroundColor;
    UIColor *itemBGColor = tableView.itemCellBackgroundColor;
    
    // header cell
    if (row == 0) {
        NSString *className = self.classNameForRegisteringHeaderCell;
        NSString *headerCellReuseID = className.length ? className : YJGSTVC_HEADER_CELL_REUSE_ID;
        if (self.didRegisterHeaderCell) {
            cell = [tableView dequeueReusableCellWithIdentifier:headerCellReuseID forIndexPath:indexPath];
            cell.backgroundColor = cell.contentView.backgroundColor;
            if ([tableView.delegate respondsToSelector:@selector(tableView:configureHeaderCell:)]) {
                [tableView.delegate tableView:tableView configureHeaderCell:cell];
            }
        } else {
            cell = [tableView dequeueReusableCellWithIdentifier:headerCellReuseID];
            if (!cell) {
                cell = [[_YJGroupedStyleGroupSeparatorCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:headerCellReuseID];
                cell.contentView.backgroundColor = tableBGColor;
                cell.backgroundColor = tableBGColor;
                if ([tableView.delegate respondsToSelector:@selector(tableView:configureSectionBackgroundCell:inSection:)]) {
                    [tableView.delegate tableView:tableView configureSectionBackgroundCell:cell inSection:-1];
                }
            }
        }
        self.backgroundColorForHeaderCell = cell.contentView.backgroundColor ?: (cell.backgroundColor ?: tableBGColor);
    }
    
    // item cell
    else if ([self.mappedRows[row] hasPrefix:YJGSItemCell]) {
        cell = [tableView dequeueReusableCellWithIdentifier:YJGSTVC_ITEM_CELL_REUSE_ID];
        if (!cell) cell = [[_YJGroupedStyleItemCell alloc] initWithStyle:tableView.itemCellStyle reuseIdentifier:YJGSTVC_ITEM_CELL_REUSE_ID];
        cell.accessoryType = tableView.itemCellAccessoryType;
        cell.contentView.backgroundColor = itemBGColor;
        cell.backgroundColor = itemBGColor;
        
        NSIndexPath *itemIndexPath = [self indexPathForGroupedItemCellFromRawIndexPath:indexPath];
        [tableView.delegate tableView:tableView configureItemCell:(id)cell atIndexPath:itemIndexPath];
        
        // check if item cell has icon image after configuration
        self.hasProvidedIconForItemCell = cell.imageView.image ? YES : NO;
    }
    
    // group separator cell (i.e. section)
    else if ([self.mappedRows[row] hasPrefix:YJGSGroupSeparator]) {
        cell = [tableView dequeueReusableCellWithIdentifier:YJGSTVC_GROUP_SEPARATOR_CELL_REUSE_ID forIndexPath:indexPath];
        cell.contentView.backgroundColor = tableBGColor;
        cell.backgroundColor = tableBGColor;
        if ([tableView.delegate respondsToSelector:@selector(tableView:configureSectionBackgroundCell:inSection:)]) {
            NSInteger section = [[self.mappedRows[row] componentsSeparatedByString:@":"].lastObject integerValue];
            [tableView.delegate tableView:tableView configureSectionBackgroundCell:cell inSection:section];
        }
    }
    
    // line separator cell
    else {
        cell = [tableView dequeueReusableCellWithIdentifier:YJGSTVC_LINE_SEPARATOR_CELL_REUSE_ID forIndexPath:indexPath];
        _YJGroupedStyleLineSeparatorCell *lineSeparator = (_YJGroupedStyleLineSeparatorCell *)cell;
        UIColor *specifiedLineColor = tableView.lineSeparatorColor;
        
        // line separator for separating item cell
        if ([[self.mappedRows[row] componentsSeparatedByString:@":"].lastObject isEqualToString:YJGSLineSeparatingItemCell]) {
            // set left indentation
            CGFloat indent = 0.0f;
            switch (tableView.lineSeparatorIndentationStyle) {
                case YJGroupedStyleTableViewSeparatorIndentationStyleAlignItemCellTitle:
                    indent = self.hasProvidedIconForItemCell ? 54.0f : 16.0f;
                    break;
                case YJGroupedStyleTableViewSeparatorIndentationStyleFixedMinimumMargin:
                    indent = 16.0f;
                    break;
            }
            lineSeparator.leftIndentation = indent;
            // set line separator color
            UIColor *separatorColor = specifiedLineColor;
            switch (tableView.lineSeparatorDisplayMode) {
                case YJGroupedStyleTableViewSeparatorDisplayModeDefault: break;
                case YJGroupedStyleTableViewSeparatorDisplayModeHideAll: separatorColor = itemBGColor; break;
                case YJGroupedStyleTableViewSeparatorDisplayModeHideGroup: break;
            }
            lineSeparator.lineColor = separatorColor;
            lineSeparator.compensatedColor = itemBGColor;
        }
        
        // line separator for separating group
        else {
            // set left indentation
            lineSeparator.leftIndentation = 0.0f;
            // set line separator color
            UIColor *separatorColor = specifiedLineColor;
            switch (tableView.lineSeparatorDisplayMode) {
                case YJGroupedStyleTableViewSeparatorDisplayModeDefault: break;
                case YJGroupedStyleTableViewSeparatorDisplayModeHideAll: separatorColor = tableBGColor; break;
                case YJGroupedStyleTableViewSeparatorDisplayModeHideGroup: separatorColor = tableBGColor; break;
            }
            lineSeparator.lineColor = separatorColor;
            lineSeparator.compensatedColor = tableBGColor;
        }
    }
    
    // hide default separator
    cell.separatorInset = UIEdgeInsetsMake(0, 9999, 0, 0);
    cell.indentationWidth = -9999;
    cell.indentationLevel = 1;
    
    // returns
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(YJGroupedStyleTableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger row = indexPath.row;
    
    // header cell
    if (row == 0) {
        if (self.didRegisterHeaderCell) {
            if (self.heightForHeaderCell) return self.heightForHeaderCell;
            UITableViewCell *cell = nil;
            
            if (self.hasNibFileForHeaderCellClass) {
                cell = [[NSBundle mainBundle] loadNibNamed:self.classNameForRegisteringHeaderCell owner:self options:nil].firstObject;
            } else {
                cell = [NSClassFromString(self.classNameForRegisteringHeaderCell) new];
            }
            
            cell.tag = YJGroupedStyleTableViewControllerHeaderCellTagForCompressedSizeCalculation;
            if ([tableView.delegate respondsToSelector:@selector(tableView:configureHeaderCell:)]) {
                [tableView.delegate tableView:tableView configureHeaderCell:cell];
            }
            self.heightForHeaderCell = [self cellHeightFittingInCompressedSizeForCell:cell];
            
            return self.heightForHeaderCell;
        } else {
            return self.shouldHideNavigationBar ? kUIStatusBarHeight + kUINavigationBarHeight : kUIStatusBarHeight;
        }
    }
    
    // item cell
    else if ([self.mappedRows[row] hasPrefix:YJGSItemCell]) {
        return tableView.itemCellHeight;
    }
    
    // group sperator
    else if ([self.mappedRows[row] hasPrefix:YJGSGroupSeparator]) {
        // last big group sperator cell
        if (row == self.mappedRows.count - 1) {
            return kYJGSTVCLastGroupSeparatorCellHeight;
        } else {
            return tableView.supplementaryRegionVerticalSpace;
        }
    }
    
    // line sperator
    else {
        return 1.0f;
    }
}

- (CGFloat)cellHeightFittingInCompressedSizeForCell:(UITableViewCell *)cell {
    UIView *contentView = cell.contentView;
    CGFloat cellWidth = self.tableView.frame.size.width;
    NSArray *constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:[contentView(==w)]" options:0 metrics:@{ @"w":@(cellWidth) } views:NSDictionaryOfVariableBindings(contentView)];
    [contentView addConstraints:constraints];
    CGSize cellSize = [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    if (!cellSize.height) cellSize = [cell systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    [contentView removeConstraints:constraints];
    return cellSize.height;
}

- (void)tableView:(YJGroupedStyleTableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSIndexPath *itemIndexPath = [self indexPathForGroupedItemCellFromRawIndexPath:indexPath];
    if (itemIndexPath && [tableView.delegate respondsToSelector:@selector(tableView:didSelectGroupedItemRowAtIndexPath:)]) {
        [tableView.delegate tableView:tableView didSelectGroupedItemRowAtIndexPath:itemIndexPath];
    }
}

- (BOOL)tableView:(YJGroupedStyleTableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath {
    NSIndexPath *itemIndexPath = [self indexPathForGroupedItemCellFromRawIndexPath:indexPath];
    if (itemIndexPath && [tableView.delegate respondsToSelector:@selector(tableView:shouldHighlightGroupedItemRowAtIndexPath:)]) {
        return [tableView.delegate tableView:tableView shouldHighlightGroupedItemRowAtIndexPath:itemIndexPath];
    }
    return NO;
}

#pragma mark - YJGroupedStyleTableViewDataSource

- (NSInteger)numberOfSectionsInGroupedStyleTableView:(UITableView *)tableView { return 1; }
- (NSInteger)tableView:(YJGroupedStyleTableView *)tableView numberOfGroupedItemRowsInSection:(NSInteger)section { return 0; }

#pragma mark - YJGroupedStyleTableViewDelegate

- (void)tableView:(YJGroupedStyleTableView *)tableView configureItemCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {}
- (BOOL)tableView:(YJGroupedStyleTableView *)tableView shouldHighlightGroupedItemRowAtIndexPath:(NSIndexPath *)indexPath { return YES; }

@end


NSInteger const YJGroupedStyleTableViewControllerHeaderCellTagForCompressedSizeCalculation = __LINE__;


@implementation UITableView (YJGroupedStyle)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self swizzleInstanceMethodForSelector:@selector(reloadData) toSelector:@selector(yj_reloadData)];
    });
}

- (void)yj_reloadData {
    if ([self.delegate respondsToSelector:@selector(_mapDataFromYJGroupedStyleTableViewDataSource)]) {
        [(id)self.delegate _mapDataFromYJGroupedStyleTableViewDataSource];
    }
    [self yj_reloadData];
}

@end


@implementation YJGroupedStyleTableView

@dynamic delegate;
@dynamic dataSource;

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    return [super initWithFrame:frame style:UITableViewStylePlain];
}

- (UIColor *)supplementaryRegionBackgroundColor {
    if (!_supplementaryRegionBackgroundColor) _supplementaryRegionBackgroundColor = YJGSTVC_DEFAULT_TABLE_BACKGROUND_COLOR;
    return _supplementaryRegionBackgroundColor;
}

- (UIColor *)lineSeparatorColor {
    if (!_lineSeparatorColor) _lineSeparatorColor = YJGSTVC_DEFAULT_LINE_SEPARATOR_COLOR;
    return _lineSeparatorColor;
}

- (UIColor *)itemCellBackgroundColor {
    if (!_itemCellBackgroundColor) _itemCellBackgroundColor = YJGSTVC_DEFAULT_ITEM_CELL_BACKGROUND_COLOR;
    return _itemCellBackgroundColor;
}

- (nullable UITableViewCell *)cellForGroupedItemAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.delegate isKindOfClass:[YJGroupedStyleTableViewController class]]) {
        YJGroupedStyleTableViewController *gstvc = (YJGroupedStyleTableViewController *)self.delegate;
        NSString *info = [NSString stringWithFormat:@"%@:%@,%@", YJGSItemCell, @(indexPath.section), @(indexPath.row)];
        if ([gstvc.mappedRows containsObject:info]) {
            NSUInteger index = [gstvc.mappedRows indexOfObject:info];
            NSIndexPath *rawIndexPath = [NSIndexPath indexPathForRow:index inSection:0];
            return [self cellForRowAtIndexPath:rawIndexPath];
        }
    }
    return nil;
}

@end
