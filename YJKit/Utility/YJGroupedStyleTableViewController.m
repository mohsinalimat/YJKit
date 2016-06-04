//
//  YJGroupedStyleTableViewController.h
//  YJKit
//
//  Created by huang-kun on 16/5/11.
//  Copyright © 2016年 huang-kun. All rights reserved.
//

#import "YJGroupedStyleTableViewController.h"

#define YJGSTVC_DEFAULT_TABLE_BACKGROUND_COLOR [UIColor colorWithRed:0.937 green:0.937 blue:0.957 alpha:1.00]
#define YJGSTVC_DEFAULT_ITEM_CELL_BACKGROUND_COLOR [UIColor whiteColor]
#define YJGSTVC_DEFAULT_LINE_SEPARATOR_COLOR [UIColor colorWithRed:0.784 green:0.780 blue:0.800 alpha:1.00]
#define YJGSTVC_DEFAULT_SUPPLEMENTARY_TEXT_COLOR [UIColor colorWithRed:0.427 green:0.427 blue:0.447 alpha:1.00]

#define YJGSTVC_HEADER_CELL_REUSE_ID @"_YJGSTVC_HEADER_CELL_REUSE_ID"
#define YJGSTVC_ITEM_CELL_REUSE_ID @"_YJGSTVC_ITEM_CELL_REUSE_ID"
#define YJGSTVC_GROUP_SEPARATOR_CELL_REUSE_ID @"_YJGSTVC_GROUP_SEPARATOR_CELL_REUSE_ID"
#define YJGSTVC_LINE_SEPARATOR_CELL_REUSE_ID @"_YJGSTVC_LINE_SEPARATOR_CELL_REUSE_ID"

#define YJGSHeaderCell @"_YJGSHeaderCell"
#define YJGSItemCell @"_YJGSItemCell"
#define YJGSCustomItemCell @"_YJGSCustomItemCell"

#define YJGSGroupSeparator @"_YJGSGroupSeparator"
#define YJGSLineSeparator @"_YJGSLineSeparator"

#define YJGSLineSeparatorForSeparatingGroup @"_YJGSLineSeparatorForSeparatingGroup"
#define YJGSLineSeparatorForSeparatingItemCell @"_YJGSLineSeparatorForSeparatingItemCell"
#define YJGSLineSeparatorForSeparatingCustomItemCell @"_YJGSLineSeparatorForSeparatingCustomItemCell"

#define YJGSGroupSeparatorAsSectionHeader @"_YJGSGroupSeparatorAsSectionHeader"
#define YJGSGroupSeparatorAsSectionFooter @"_YJGSGroupSeparatorAsSectionFooter"


// --------------------------------------------
//             forward declaration
// --------------------------------------------

@interface YJGroupedStyleTableViewController ()
@property (nonatomic, copy) NSArray <NSString *> *mappedRows; // stored information for each row in one section
@end


// --------------------------------------------
//           YJGroupedStyleTableView
// --------------------------------------------

@interface YJGroupedStyleTableView ()
@property (nonatomic, copy, nullable) NSString *registeredClassNameForHeaderCell;
@property (nonatomic, copy, nullable) NSMutableDictionary <NSNumber *, NSString *> *registeredClassNamesForCustomCells;
@property (nonatomic) BOOL didRegisterHeaderCell;
@end

@implementation YJGroupedStyleTableView

@dynamic delegate;
@dynamic dataSource;

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    return [super initWithFrame:frame style:UITableViewStylePlain];
}

- (NSMutableDictionary <NSNumber *, NSString *> *)registeredClassNamesForCustomCells {
    if (!_registeredClassNamesForCustomCells) _registeredClassNamesForCustomCells = @{}.mutableCopy;
    return _registeredClassNamesForCustomCells;
}

- (void)registerHeaderCellForClassName:(NSString *)className {
    self.registeredClassNameForHeaderCell = className;
    if ([self yj_registerCellForClassName:className]) {
        self.didRegisterHeaderCell = YES;
    }
}

- (void)registerCustomItemCellForClassName:(NSString *)className inSection:(NSInteger)section {
    self.registeredClassNamesForCustomCells[@(section)] = className;
    [self yj_registerCellForClassName:className];
}

- (BOOL)yj_registerCellForClassName:(NSString *)className {
    if (!className.length) return NO;
    
    if ([self hasNibFileForClassNamed:className]) {
        [self registerNib:[UINib nibWithNibName:className bundle:nil] forCellReuseIdentifier:className];
        return YES;
    } else {
        [self registerClass:NSClassFromString(className) forCellReuseIdentifier:className];
        return YES;
    }
    return NO;
}

- (BOOL)hasNibFileForClassNamed:(NSString *)className {
    if (!className.length) return NO;
    NSString *path = [[NSBundle mainBundle] pathForResource:className ofType:@"nib"]; // not "xib" !
    return path.length ? YES : NO;
}

- (UIColor *)supplementaryRegionBackgroundColor {
    if (!_supplementaryRegionBackgroundColor) _supplementaryRegionBackgroundColor = YJGSTVC_DEFAULT_TABLE_BACKGROUND_COLOR;
    return _supplementaryRegionBackgroundColor;
}

- (CGFloat)supplementaryRegionHeight {
    if (!_supplementaryRegionHeight) _supplementaryRegionHeight = 36.0;
    return _supplementaryRegionHeight;
}

- (UIColor *)lineSeparatorColor {
    if (!_lineSeparatorColor) _lineSeparatorColor = YJGSTVC_DEFAULT_LINE_SEPARATOR_COLOR;
    return _lineSeparatorColor;
}

- (UIColor *)itemCellBackgroundColor {
    if (!_itemCellBackgroundColor) _itemCellBackgroundColor = YJGSTVC_DEFAULT_ITEM_CELL_BACKGROUND_COLOR;
    return _itemCellBackgroundColor;
}

// The index path parameter should be converted before calling.
- (nullable UITableViewCell *)cellForGroupedItemAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.delegate isKindOfClass:[YJGroupedStyleTableViewController class]]) {
        YJGroupedStyleTableViewController *gstvc = (YJGroupedStyleTableViewController *)self.delegate;
        
        NSString *itemCellInfo = [NSString stringWithFormat:@"%@:%@,%@", YJGSItemCell, @(indexPath.section), @(indexPath.row)];
        NSString *customItemCellInfo = [NSString stringWithFormat:@"%@:%@|%@,%@", YJGSCustomItemCell, self.registeredClassNamesForCustomCells[@(indexPath.section)], @(indexPath.section), @(indexPath.row)];
        
        // get item cell from converted index path
        if ([gstvc.mappedRows containsObject:itemCellInfo]) {
            NSUInteger index = [gstvc.mappedRows indexOfObject:itemCellInfo];
            NSIndexPath *rawIndexPath = [NSIndexPath indexPathForRow:index inSection:0];
            return [self cellForRowAtIndexPath:rawIndexPath];
        }
        // get custom item cell from converted index path
        else if ([gstvc.mappedRows containsObject:customItemCellInfo]) {
            NSUInteger index = [gstvc.mappedRows indexOfObject:customItemCellInfo];
            NSIndexPath *rawIndexPath = [NSIndexPath indexPathForRow:index inSection:0];
            return [self cellForRowAtIndexPath:rawIndexPath];
        }
    }
    return nil;
}

@end


// --------------------------------------------
//              Internal Cells
// --------------------------------------------

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


// --------------------------------------------
//      YJGroupedStyleTableViewController
// --------------------------------------------

static const CGFloat kYJGSTVCLastGroupSeparatorCellHeight = 999.0f;
static const CGFloat kYJGSTVCBottomSpaceFromLastCell = 50.0f;

@interface YJGroupedStyleTableViewController ()

@property (nonatomic, strong) UIColor *backgroundColorForHeaderCell; // @dynamic
@property (nonatomic, strong) NSMutableDictionary <NSNumber *, NSNumber *> *heightsForCustomItemCells;
@property (nonatomic, assign) CGFloat heightForHeaderCell;
@property (nonatomic, assign) BOOL hasProvidedIconForItemCell;

@end

@implementation YJGroupedStyleTableViewController

@dynamic tableView;

- (instancetype)initWithStyle:(UITableViewStyle)style {
    return [super initWithStyle:UITableViewStylePlain];
}

- (void)loadView {
    YJGroupedStyleTableView *tableView = [[YJGroupedStyleTableView alloc] initWithFrame:[UIScreen mainScreen].bounds
                                                                                  style:UITableViewStylePlain];
    tableView.backgroundColor = YJGSTVC_DEFAULT_TABLE_BACKGROUND_COLOR;
    tableView.contentInset = (UIEdgeInsets){ 0, 0, kYJGSTVCBottomSpaceFromLastCell - kYJGSTVCLastGroupSeparatorCellHeight, 0 };
    
    tableView.lineSeparatorIndentationStyle = YJGroupedStyleTableViewSeparatorIndentationStyleAlignItemCellTitle;
    tableView.lineSeparatorThicknessLevel = YJGroupedStyleTableViewSeparatorThicknessLevelNormal;
    tableView.lineSeparatorDisplayMode = YJGroupedStyleTableViewSeparatorDisplayModeDefault;
    tableView.lineSeparatorColor = YJGSTVC_DEFAULT_LINE_SEPARATOR_COLOR;
    
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

- (void)mapDataFromDataSourceAfterTableViewLoaded {
    NSDictionary *registeredCustomCells = [self.tableView.registeredClassNamesForCustomCells copy];
    NSArray *registeredCustomSections = registeredCustomCells.allKeys;
    
    NSMutableArray *mappedRows = @[ YJGSHeaderCell,
                                    YJGSGroupSeparator,
                                    [NSString stringWithFormat:@"%@:%@,%@", YJGSGroupSeparator, YJGSGroupSeparatorAsSectionHeader, @0],
                                    [NSString stringWithFormat:@"%@:%@", YJGSLineSeparator, YJGSLineSeparatorForSeparatingGroup]
                                    ].mutableCopy;
    
    NSUInteger rowIdx = mappedRows.count;
    NSInteger sections = 1;
    
    if ([self.tableView.dataSource respondsToSelector:@selector(numberOfSectionsInGroupedStyleTableView:)]) {
        sections = [self.tableView.dataSource numberOfSectionsInGroupedStyleTableView:self.tableView];
    }
    
    for (NSUInteger i = 0; i < sections; ++i) {
        NSInteger rowsInSection = [self.tableView.dataSource tableView:self.tableView numberOfGroupedItemRowsInSection:i];
        for (NSUInteger j = 0; j < rowsInSection; ++j) {
            if ([registeredCustomSections containsObject:@(i)]) {
                mappedRows[rowIdx++] = [NSString stringWithFormat:@"%@:%@|%@,%@", YJGSCustomItemCell, registeredCustomCells[@(i)], @(i), @(j)];
                mappedRows[rowIdx++] = [NSString stringWithFormat:@"%@:%@", YJGSLineSeparator, YJGSLineSeparatorForSeparatingCustomItemCell];
            } else {
                mappedRows[rowIdx++] = [NSString stringWithFormat:@"%@:%@,%@", YJGSItemCell, @(i), @(j)];
                mappedRows[rowIdx++] = [NSString stringWithFormat:@"%@:%@", YJGSLineSeparator, YJGSLineSeparatorForSeparatingItemCell];
            }
        }
        mappedRows[rowIdx-1] = [NSString stringWithFormat:@"%@:%@", YJGSLineSeparator, YJGSLineSeparatorForSeparatingGroup];
        mappedRows[rowIdx++] = [NSString stringWithFormat:@"%@:%@,%@", YJGSGroupSeparator, YJGSGroupSeparatorAsSectionFooter, @(i)];
        mappedRows[rowIdx++] = [NSString stringWithFormat:@"%@:%@,%@", YJGSGroupSeparator, YJGSGroupSeparatorAsSectionHeader, @(i+1)];
        mappedRows[rowIdx++] = [NSString stringWithFormat:@"%@:%@", YJGSLineSeparator, YJGSLineSeparatorForSeparatingGroup];
    }
    [mappedRows removeLastObject]; // keep the last section header cell as the last big supplementary cell
    
    _mappedRows = [mappedRows copy];
}

- (nullable NSIndexPath *)indexPathForGroupedItemConvertedFromRawIndexPath:(NSIndexPath *)rawIndexPath {
    NSString *rowInfo = self.mappedRows[rawIndexPath.row];
    // get converted index path for item cell
    if ([rowInfo hasPrefix:YJGSItemCell]) {
        NSArray *indexPathComponents = [[rowInfo componentsSeparatedByString:@":"].lastObject componentsSeparatedByString:@","];
        NSInteger section = [indexPathComponents.firstObject integerValue];
        NSInteger row = [indexPathComponents.lastObject integerValue];
        return [NSIndexPath indexPathForRow:row inSection:section];
    }
    // get converted index path for custom item cell
    else if ([rowInfo hasPrefix:YJGSCustomItemCell]) {
        NSArray *indexPathComponents = [[rowInfo componentsSeparatedByString:@"|"].lastObject componentsSeparatedByString:@","];
        NSInteger section = [indexPathComponents.firstObject integerValue];
        NSInteger row = [indexPathComponents.lastObject integerValue];
        return [NSIndexPath indexPathForRow:row inSection:section];
    }
    return nil;
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
    [self mapDataFromDataSourceAfterTableViewLoaded];
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

- (NSMutableDictionary <NSNumber *, NSNumber *> *)heightsForCustomItemCells {
    if (!_heightsForCustomItemCells) _heightsForCustomItemCells = @{}.mutableCopy;
    return _heightsForCustomItemCells;
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
    
    NSArray *rowInfoComponents = [self.mappedRows[row] componentsSeparatedByString:@":"];
    NSString *typeInfo = rowInfoComponents.firstObject;
    NSString *detailInfo = rowInfoComponents.lastObject;

    UIColor *tableBGColor = tableView.supplementaryRegionBackgroundColor;
    UIColor *itemBGColor = tableView.itemCellBackgroundColor;
    
    // header cell
    if (row == 0) {
        NSString *className = tableView.registeredClassNameForHeaderCell;
        NSString *headerCellReuseID = className.length ? className : YJGSTVC_HEADER_CELL_REUSE_ID;
        if (tableView.didRegisterHeaderCell) {
            cell = [tableView dequeueReusableCellWithIdentifier:headerCellReuseID forIndexPath:indexPath];
            cell.backgroundColor = cell.contentView.backgroundColor;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            if ([tableView.delegate respondsToSelector:@selector(tableView:configureHeaderCell:)]) {
                [tableView.delegate tableView:tableView configureHeaderCell:cell];
            }
        } else {
            cell = [tableView dequeueReusableCellWithIdentifier:headerCellReuseID];
            if (!cell) {
                cell = [[_YJGroupedStyleGroupSeparatorCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:headerCellReuseID];
                cell.contentView.backgroundColor = tableBGColor;
                cell.backgroundColor = tableBGColor;
            }
        }
        self.backgroundColorForHeaderCell = cell.contentView.backgroundColor ?: (cell.backgroundColor ?: tableBGColor);
    }
    
    // item cell
    else if ([typeInfo isEqualToString:YJGSItemCell]) {
        // convert index path for item cell
        NSIndexPath *itemIndexPath = [self indexPathForGroupedItemConvertedFromRawIndexPath:indexPath];
        
        UITableViewCellStyle style = tableView.itemCellStyle;
        if ([tableView.dataSource respondsToSelector:@selector(tableView:groupedItemCellStyleInSection:)]) {
            style = [tableView.dataSource tableView:tableView groupedItemCellStyleInSection:itemIndexPath.section];
        }
        // generate item cell with different style
        NSString *itemCellReuseID = [NSString stringWithFormat:@"%@_%@", YJGSTVC_ITEM_CELL_REUSE_ID, @(style)];
        cell = [tableView dequeueReusableCellWithIdentifier:itemCellReuseID];
        if (!cell) cell = [[_YJGroupedStyleItemCell alloc] initWithStyle:style reuseIdentifier:itemCellReuseID];
        cell.accessoryType = tableView.itemCellAccessoryType;
        cell.contentView.backgroundColor = itemBGColor;
        cell.backgroundColor = itemBGColor;
        
        [tableView.delegate tableView:tableView configureItemCell:(id)cell atIndexPath:itemIndexPath];
        
        // check if item cell has icon image after configuration
        self.hasProvidedIconForItemCell = cell.imageView.image ? YES : NO;
    }
    
    // custom item cell
    else if ([typeInfo isEqualToString:YJGSCustomItemCell]) {
        NSArray *hybridComponents = [detailInfo componentsSeparatedByString:@"|"];
        NSString *className = hybridComponents.firstObject;
        NSArray *indexPathComponents = [hybridComponents.lastObject componentsSeparatedByString:@","];
        NSIndexPath *customItemIndexPath = [NSIndexPath indexPathForRow:[indexPathComponents.lastObject integerValue]
                                                              inSection:[indexPathComponents.firstObject integerValue]];
        
        cell = [tableView dequeueReusableCellWithIdentifier:className forIndexPath:indexPath];
        cell.backgroundColor = cell.contentView.backgroundColor;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if ([tableView.delegate respondsToSelector:@selector(tableView:configureCustomItemCell:atIndexPath:)]) {
            [tableView.delegate tableView:tableView configureCustomItemCell:cell atIndexPath:customItemIndexPath];
        }
    }
    
    // section header / footer
    else if ([typeInfo isEqualToString:YJGSGroupSeparator]) {
        NSInteger section = [[detailInfo componentsSeparatedByString:@","].lastObject integerValue];
        
        cell = [tableView dequeueReusableCellWithIdentifier:YJGSTVC_GROUP_SEPARATOR_CELL_REUSE_ID forIndexPath:indexPath];
        cell.contentView.backgroundColor = tableBGColor;
        cell.backgroundColor = tableBGColor;
        cell.textLabel.text = nil;
        cell.textLabel.attributedText = nil;
        cell.imageView.image = nil;
        
        // set default text attributes
        NSDictionary *attrs = @{ NSForegroundColorAttributeName : YJGSTVC_DEFAULT_SUPPLEMENTARY_TEXT_COLOR,
                                 NSFontAttributeName : [UIFont systemFontOfSize:[UIFont smallSystemFontSize]] };
        NSString *elementKind = nil;
        // section header
        if ([detailInfo hasPrefix:YJGSGroupSeparatorAsSectionHeader] && row != self.mappedRows.count - 1) {
            elementKind = YJGroupedStyleTableViewSupplementarySectionHeader;
        }
        // section footer
        else if ([detailInfo hasPrefix:YJGSGroupSeparatorAsSectionFooter]) {
            elementKind = YJGroupedStyleTableViewSupplementarySectionFooter;
        }
        // top line supplementary cell
        else {
            elementKind = YJGroupedStyleTableViewSupplementaryTopLine;
        }
        
        if (elementKind && [tableView.delegate respondsToSelector:@selector(tableView:configureSupplementaryCell:forElementOfKind:inSection:withDefaultTextAttributes:)]) {
            [tableView.delegate tableView:tableView configureSupplementaryCell:cell forElementOfKind:elementKind inSection:section withDefaultTextAttributes:attrs];
        }
    }
    
    // line separator cell
    else {
        cell = [tableView dequeueReusableCellWithIdentifier:YJGSTVC_LINE_SEPARATOR_CELL_REUSE_ID forIndexPath:indexPath];
        _YJGroupedStyleLineSeparatorCell *lineSeparator = (_YJGroupedStyleLineSeparatorCell *)cell;
        UIColor *specifiedLineColor = tableView.lineSeparatorColor;
        
        // line separator for separating item cell
        if ([detailInfo isEqualToString:YJGSLineSeparatorForSeparatingItemCell]) {
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
        else if ([detailInfo isEqualToString:YJGSLineSeparatorForSeparatingGroup]) {
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
        
        // line separator for separating custom item cell
        else {
            // set left indentation
            lineSeparator.leftIndentation = 0.0f;
            // set line separator color
            UIColor *separatorColor = specifiedLineColor;
            switch (tableView.lineSeparatorDisplayMode) {
                case YJGroupedStyleTableViewSeparatorDisplayModeDefault: break;
                case YJGroupedStyleTableViewSeparatorDisplayModeHideAll: separatorColor = tableBGColor; break;
                case YJGroupedStyleTableViewSeparatorDisplayModeHideGroup: break;
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
    NSString *typeInfo = [self.mappedRows[row] componentsSeparatedByString:@":"].firstObject;
    
    // header cell
    if (row == 0) {
        if (tableView.didRegisterHeaderCell) {
            if (self.heightForHeaderCell) {
                return self.heightForHeaderCell;
            }
            static UITableViewCell *cell = nil;
            if (!cell) {
                if ([tableView hasNibFileForClassNamed:tableView.registeredClassNameForHeaderCell]) {
                    cell = [[NSBundle mainBundle] loadNibNamed:tableView.registeredClassNameForHeaderCell owner:self options:nil].firstObject;
                } else {
                    cell = [NSClassFromString(tableView.registeredClassNameForHeaderCell) new];
                }
            }
            if (!cell) {
                self.heightForHeaderCell = tableView.extraTopMargin;
                return self.heightForHeaderCell;
            }
            cell.tag = YJGroupedStyleTableViewControllerHeaderCellTagForCompressedSizeCalculation;
            
            if ([tableView.delegate respondsToSelector:@selector(tableView:configureHeaderCell:)]) {
                [tableView.delegate tableView:tableView configureHeaderCell:cell];
            }
            self.heightForHeaderCell = tableView.extraTopMargin + [self cellHeightFittingInCompressedSizeForCell:cell];
            
            return self.heightForHeaderCell;
        } else {
            return tableView.extraTopMargin;
        }
    }
    
    // item cell
    else if ([typeInfo isEqualToString:YJGSItemCell]) {
        return tableView.itemCellHeight;
    }
    
    // custom item cell
    else if ([typeInfo isEqualToString:YJGSCustomItemCell]) {
#if CGFLOAT_IS_DOUBLE
        CGFloat cellHeight = [self.heightsForCustomItemCells[@(indexPath.section)] doubleValue];
#else
        CGFloat cellHeight = [self.heightsForCustomItemCells[@(indexPath.section)] floatValue];
#endif
        if (cellHeight) return cellHeight;
        
        NSString *detailInfo = [self.mappedRows[row] componentsSeparatedByString:@":"].lastObject;
        NSArray *hybridComponents = [detailInfo componentsSeparatedByString:@"|"];
        NSString *className = hybridComponents.firstObject;
        NSArray *indexPathComponents = [hybridComponents.lastObject componentsSeparatedByString:@","];
        NSIndexPath *customItemIndexPath = [NSIndexPath indexPathForRow:[indexPathComponents.lastObject integerValue]
                                                              inSection:[indexPathComponents.firstObject integerValue]];
        
        UITableViewCell *cell = nil;
        if ([tableView hasNibFileForClassNamed:className]) {
            cell = [[NSBundle mainBundle] loadNibNamed:className owner:self options:nil].firstObject;
        } else {
            cell = [NSClassFromString(className) new];
        }
        cell.tag = YJGroupedStyleTableViewControllerCustomItemCellTagForCompressedSizeCalculation;
        if ([tableView.delegate respondsToSelector:@selector(tableView:configureCustomItemCell:atIndexPath:)]) {
            [tableView.delegate tableView:tableView configureCustomItemCell:cell atIndexPath:customItemIndexPath];
        }
        cellHeight = [self cellHeightFittingInCompressedSizeForCell:cell];
        self.heightsForCustomItemCells[@(indexPath.section)] = @(cellHeight);
        
        return cellHeight;
    }
    
    // group sperator (supplementary region)
    else if ([typeInfo isEqualToString:YJGSGroupSeparator]) {
        // last big group sperator cell
        if (row == self.mappedRows.count - 1) {
            return kYJGSTVCLastGroupSeparatorCellHeight;
        } else {
            return tableView.supplementaryRegionHeight / 2;
        }
    }
    
    // line sperator
    else {
        switch (tableView.lineSeparatorThicknessLevel) {
            case YJGroupedStyleTableViewSeparatorThicknessLevelNormal: return 0.5;
            case YJGroupedStyleTableViewSeparatorThicknessLevelThicker: return 1.0;
        }
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
    NSIndexPath *itemIndexPath = [self indexPathForGroupedItemConvertedFromRawIndexPath:indexPath];
    // select item cell or custom item cell
    if (itemIndexPath && [tableView.delegate respondsToSelector:@selector(tableView:didSelectGroupedItemRowAtIndexPath:)]) {
        [tableView.delegate tableView:tableView didSelectGroupedItemRowAtIndexPath:itemIndexPath];
    }
    // select header cell
    else if (tableView.didRegisterHeaderCell && indexPath.section == 0 && indexPath.row == 0 &&
             [tableView.delegate respondsToSelector:@selector(tableView:didSelectHeaderCell:)]) {
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        if (cell) [tableView.delegate tableView:tableView didSelectHeaderCell:cell];
    }
}

- (BOOL)tableView:(YJGroupedStyleTableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath {
    NSIndexPath *itemIndexPath = [self indexPathForGroupedItemConvertedFromRawIndexPath:indexPath];
    // can select item cell or custom item cell
    if (itemIndexPath && [tableView.delegate respondsToSelector:@selector(tableView:shouldHighlightGroupedItemRowAtIndexPath:)]) {
        return [tableView.delegate tableView:tableView shouldHighlightGroupedItemRowAtIndexPath:itemIndexPath];
    }
    // can select header cell if has
    else if (tableView.didRegisterHeaderCell && indexPath.section == 0 && indexPath.row == 0) {
        return YES;
    }
    // forbid others
    return NO;
}

#pragma mark - YJGroupedStyleTableViewDataSource

- (NSInteger)numberOfSectionsInGroupedStyleTableView:(UITableView *)tableView { return 1; }
- (NSInteger)tableView:(YJGroupedStyleTableView *)tableView numberOfGroupedItemRowsInSection:(NSInteger)section { return 0; }

#pragma mark - YJGroupedStyleTableViewDelegate

- (void)tableView:(YJGroupedStyleTableView *)tableView configureItemCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {}
- (BOOL)tableView:(YJGroupedStyleTableView *)tableView shouldHighlightGroupedItemRowAtIndexPath:(NSIndexPath *)indexPath { return YES; } // this implementation is required by YJGroupedStyleTableViewController itself.

@end

NSString *const YJGroupedStyleTableViewSupplementarySectionHeader = @"_YJGroupedStyleTableViewSupplementarySectionHeader";
NSString *const YJGroupedStyleTableViewSupplementarySectionFooter = @"_YJGroupedStyleTableViewSupplementarySectionFooter";
NSString *const YJGroupedStyleTableViewSupplementaryTopLine = @"_YJGroupedStyleTableViewSupplementaryTopLine";

NSInteger const YJGroupedStyleTableViewControllerHeaderCellTagForCompressedSizeCalculation = __LINE__;
NSInteger const YJGroupedStyleTableViewControllerCustomItemCellTagForCompressedSizeCalculation = __LINE__;
