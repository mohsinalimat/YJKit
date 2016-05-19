//
//  YJGroupedStyleTableViewController.h
//  YJKit
//
//  Created by huang-kun on 16/5/11.
//  Copyright © 2016年 huang-kun. All rights reserved.
//

#import "YJGroupedStyleTableViewController.h"
#import "NSObject+YJCategory_Swizzling.h"
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
    return self.backgroundColor;
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

@property (nonatomic, copy) NSArray *mappedRows; // @"section,row" or null
@property (nonatomic, copy) NSArray <NSNumber *> *itemRows; // Rows for item cells
@property (nonatomic, copy) NSDictionary <NSNumber *, NSString *> *itemTitles;
@property (nonatomic, copy, nullable) NSDictionary <NSNumber *, NSString *> *itemSubtitles;
@property (nonatomic, copy, nullable) NSDictionary <NSNumber *, UIImage *> *itemIconImages;
@property (nonatomic, copy, nullable) NSDictionary <NSNumber *, NSString *> *itemIconImageNames;
@property (nonatomic, copy, nullable) NSDictionary <NSNumber *, NSString *> *classNamesForDestinationViewControllers;
@property (nonatomic, copy, nullable) NSDictionary <NSNumber *, NSString *> *storyboardIdentifiersForDestinationViewControllers;

@property (nonatomic, strong) NSData *frozenNavBar;
@property (nonatomic, strong) NSMutableArray *navBarBGSubviews;

@property (nonatomic, strong) UIColor *backgroundColorForHeaderCell; // @dynamic
@property (nonatomic, assign) CGFloat heightForHeaderCell;
@property (nonatomic, assign) BOOL shouldAnimateNavigationBar;
@property (nonatomic, assign) BOOL didRegisterHeaderCell;
@end

@implementation YJGroupedStyleTableViewController

- (instancetype)initWithStyle:(UITableViewStyle)style {
    self = [super initWithStyle:UITableViewStylePlain];
    if (self) [self fetchRequiredDataForLoadingGroupedCells];
    return self;
}

#pragma mark - Mapping

- (nullable NSDictionary *)itemCellContentsFromList:(NSArray *)list {
    
    if (!_itemRows) {
        NSMutableDictionary <NSNumber *, NSString *> *titles = @{}.mutableCopy;
        NSMutableArray *mappedRows = @[ YJGSHeaderCell, YJGSGroupSeparator, YJGSLineSeparator].mutableCopy;
        NSUInteger row = 3; // row for each UITableViewCell
        NSArray *groups = [self titlesForGroupedCells];
        for (NSUInteger i = 0; i < groups.count; ++i) {
            NSArray *group = groups[i];
            NSAssert([group isKindOfClass:[NSArray class]], @"The titles for %@ item cells must be nested as a group, e.g. @[ @[ @\"Item 1\", @\"Item 2\", ... ] ].", self.class);
            for (NSUInteger j = 0; j < group.count; ++j) {
                NSString *title = group[j];
                titles[@(row)] = title;
                mappedRows[row++] = [NSString stringWithFormat:@"%@:%@,%@", YJGSItemCell, @(i), @(j)];
                mappedRows[row++] = [NSString stringWithFormat:@"%@:%@", YJGSLineSeparator, YJGSLineSeparatingItemCell];
            }
            mappedRows[row-1] = [NSString stringWithFormat:@"%@:%@", YJGSLineSeparator, YJGSLineSeparatingGroup];
            mappedRows[row++] = YJGSGroupSeparator;
            mappedRows[row++] = [NSString stringWithFormat:@"%@:%@", YJGSLineSeparator, YJGSLineSeparatingGroup];
        }
        [mappedRows removeLastObject];
        
        _mappedRows = [mappedRows copy];
        _itemTitles = [titles copy];
        _itemRows = [[titles allKeys] sorted:^BOOL(NSNumber * _Nonnull obj1, NSNumber * _Nonnull obj2) {
            return obj1.unsignedIntegerValue < obj2.unsignedIntegerValue;
        }];
    }
    
    if (!list.count) return nil;
    
    NSArray *flattenList = [list flatten];
    NSAssert(_itemRows.count == flattenList.count, @"%@ - Grouped cell itemRows has different count with given list. \nitemRows:%@, \nlist:%@", self.class, _itemRows, flattenList);
    NSMutableDictionary *contents = [NSMutableDictionary dictionaryWithCapacity:flattenList.count];
    for (NSUInteger i = 0; i < flattenList.count; ++i) {
        contents[_itemRows[i]] = flattenList[i];
    }
    return [contents copy];
}

- (void)fetchRequiredDataForLoadingGroupedCells {
    
    self.itemSubtitles = [self itemCellContentsFromList:[self subtitlesForItemCells]];
    self.itemIconImages = [self itemCellContentsFromList:[self iconImagesForItemCells]];
    self.itemIconImageNames = [self itemCellContentsFromList:[self iconImageNamesForItemCells]];
    self.classNamesForDestinationViewControllers = [self itemCellContentsFromList:[self classNamesOfDestinationViewControllersForItemCells]];
    self.storyboardIdentifiersForDestinationViewControllers = [self itemCellContentsFromList:[self storyboardIdentifiersOfDestinationViewControllersForItemCells]];
    
    self.tableView.backgroundColor = [self backgroundColorForTableView];
    
    // hide default separators
    self.tableView.separatorColor = [UIColor clearColor];
    self.tableView.separatorInset = UIEdgeInsetsMake(0, 9999, 0, 0);
    
    UIEdgeInsets insets = UIEdgeInsetsZero;
    insets.top = [self topEdgeInsetForTableView];
    insets.bottom = kYJGSTVCBottomSpaceFromLastCell - kYJGSTVCLastGroupSeparatorCellHeight;
    self.tableView.contentInset = insets;
    
    self.edgesForExtendedLayout = [self shouldHideNavigationBar] ? UIRectEdgeNone : UIRectEdgeTop;
    self.extendedLayoutIncludesOpaqueBars = YES;
}

- (NSUInteger)totalCellCount {
    return self.mappedRows.count;
}

- (void)getMappedItemRow:(NSInteger *)rowPtr inSection:(NSInteger *)sectionPtr forIndexPath:(NSIndexPath *)indexPath {
    NSString *info = self.mappedRows[indexPath.row];
    if ([info hasPrefix:YJGSItemCell]) {
        NSArray <NSString *> *components = [[info componentsSeparatedByString:@":"].lastObject componentsSeparatedByString:@","];
        NSInteger row = components.lastObject.integerValue;
        NSInteger section = components.firstObject.integerValue;
        if (rowPtr) *rowPtr = row;
        if (sectionPtr) *sectionPtr = section;
    }
}

#pragma mark - Life cycle

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    self.itemIconImages = nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // registering group separator
    [self.tableView registerClass:[_YJGroupedStyleGroupSeparatorCell class] forCellReuseIdentifier:YJGSTVC_GROUP_SEPARATOR_CELL_REUSE_ID];
    // registering line separator
    [self.tableView registerClass:[_YJGroupedStyleLineSeparatorCell class] forCellReuseIdentifier:YJGSTVC_LINE_SEPARATOR_CELL_REUSE_ID];
    // registering header cell
    NSString *nibName = [self nibNameForRegisteringHeaderCell];
    Class HCClass = [self classForRegisteringHeaderCell];
    if (!HCClass && [self classNameForRegisteringHeaderCell].length) {
        HCClass = NSClassFromString([self classNameForRegisteringHeaderCell]);
    }
    if (nibName.length) {
        [self.tableView registerNib:[UINib nibWithNibName:nibName bundle:nil]
             forCellReuseIdentifier:[self reuseIdentifierForHeaderCell] ?: YJGSTVC_HEADER_CELL_REUSE_ID];
        self.didRegisterHeaderCell = YES;
    } else if (HCClass) {
        [self.tableView registerClass:HCClass
               forCellReuseIdentifier:[self reuseIdentifierForHeaderCell] ?: YJGSTVC_HEADER_CELL_REUSE_ID];
        self.didRegisterHeaderCell = YES;
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self removeDropBackViewFromNavBarIfPossible];
    [self saveOriginalNavigationBar];
    [self setNavigationBarTranslucentIfPossible:NO];
    
    if ([self shouldHideNavigationBar]) {
        [self.navigationController setNavigationBarHidden:YES animated:self.shouldAnimateNavigationBar];
        [self updateNavigationBarAnimationState];
    } else {
        [self hideNavigationBarShadowIfPossible];
    }
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self setNavigationBarTranslucentIfPossible:YES];
    if ([self shouldMaskNavigationBarBackgroundColor]) {
        self.navigationController.navigationBar.barTintColor = self.backgroundColorForHeaderCell;
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    if ([self shouldHideNavigationBar]) {
        [self.navigationController setNavigationBarHidden:NO animated:YES];
        [self updateNavigationBarAnimationState];
    }
    
    [self restoreOriginalNavigationBar];
    [self addDropBackViewToNavBarIfNeeded];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
    if ([self shouldHideNavigationBar]) {
        [self updateNavigationBarAnimationState];
    }
}

#pragma mark - Update status bar and navigation bar

- (void)updateNavigationBarAnimationState {
    self.shouldAnimateNavigationBar = (self.navigationController.viewControllers.count == 1) ? NO : YES;
}

// hide 1px shadow image
- (void)hideNavigationBarShadowIfPossible {
    if ([self shouldHideNavigationBarShadow]) {
        UIImage *emptyShadow = [UIImage new];
        self.navigationController.navigationBar.shadowImage = emptyShadow;
        [self.navigationController.navigationBar setBackgroundImage:emptyShadow forBarMetrics:UIBarMetricsDefault];
    }
}

- (void)setNavigationBarTranslucentIfPossible:(BOOL)translucent {
    if ([self shouldTranslucentNavigationBar]) {
        self.navigationController.navigationBar.translucent = [self shouldOpaqueNavBarIfNeeded] ? NO : translucent;
    }
}

// save nav bar
- (void)saveOriginalNavigationBar {
    if (!self.frozenNavBar) {
        self.frozenNavBar = [NSKeyedArchiver archivedDataWithRootObject:self.navigationController.navigationBar];
    }
}

// restore nav bar
- (void)restoreOriginalNavigationBar {
    if (!self.frozenNavBar) return;
    if ([self.sourceViewController respondsToSelector:@selector(shouldHideNavigationBar)]) {
        if ([(id)self.sourceViewController shouldHideNavigationBar]) {
            return;
        }
    }
    
    UINavigationBar *navBar = self.navigationController.navigationBar;
    UINavigationBar *frozenNavBar = [NSKeyedUnarchiver unarchiveObjectWithData:self.frozenNavBar];
    navBar.translucent = frozenNavBar.translucent;
    navBar.tintColor = frozenNavBar.tintColor;
    navBar.barTintColor = frozenNavBar.barTintColor;
    navBar.shadowImage = frozenNavBar.shadowImage;
}

// remove back drop view from subviews of navigation back ground if possible
- (void)removeDropBackViewFromNavBarIfPossible {
    // check if pusher has shown nav bar
    BOOL isNavBarShownBeforePushIn = YES;
    
    if ([self.sourceViewController respondsToSelector:@selector(shouldHideNavigationBar)]) {
        isNavBarShownBeforePushIn = ![(id)self.sourceViewController shouldHideNavigationBar];
    }
    if (!isNavBarShownBeforePushIn) return;
    // remove back drop view
    if (![self shouldHideNavigationBar] && [self shouldMaskNavigationBarBackgroundColor] && [self shouldTranslucentNavigationBar]) {
        NSArray *bgViews = [self.navigationController.navigationBar.subviews.firstObject subviews];
        if (bgViews.count > 1) {
            for (UIView *subview in bgViews) {
                if (![subview isKindOfClass:[UIImageView class]]) {
                    [self.navBarBGSubviews addObject:subview]; //
                    [subview removeFromSuperview];
                }
            }
        }
    }
}

// reset back drop view back to nav bar if needed
- (void)addDropBackViewToNavBarIfNeeded {
    if (!self.navBarBGSubviews.count) return;
    UIView *bgView = self.navigationController.navigationBar.subviews.firstObject;
    for (UIView *subview in self.navBarBGSubviews) {
        if (![bgView.subviews containsObject:subview]) {
            [bgView addSubview:subview];
        }
    }
}

#pragma mark - Accessors

- (void)setBackgroundColorForHeaderCell:(UIColor *)backgroundColorForHeaderCell {
    self.tableView.backgroundColor = backgroundColorForHeaderCell;
    self.tableView.superview.backgroundColor = backgroundColorForHeaderCell;
    if ([self shouldMaskNavigationBarBackgroundColor]) {
        self.navigationController.navigationBar.barTintColor = backgroundColorForHeaderCell;
    }
}

- (UIColor *)backgroundColorForHeaderCell {
    return self.tableView.backgroundColor;
}

- (NSDictionary <NSNumber *, UIImage *> *)itemIconImages {
    if (!_itemIconImages) _itemIconImages = [self itemCellContentsFromList:[self iconImagesForItemCells]];
    return _itemIconImages;
}

- (NSMutableArray *)navBarBGSubviews {
    if (!_navBarBGSubviews) _navBarBGSubviews = @[].mutableCopy;
    return _navBarBGSubviews;
}

- (UIViewController *)sourceViewController {
    NSArray *viewControllers = self.navigationController.viewControllers;
    NSUInteger count = viewControllers.count;
    return count >= 2 ? viewControllers[count-2] : (count == 1 ? viewControllers.firstObject : nil);
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.totalCellCount;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger row = indexPath.row;
    BOOL isItemRow = [self.itemRows containsObject:@(row)] ? YES : NO;
    UITableViewCell *cell = nil;
    UIColor *tableBGColor = [self backgroundColorForTableView] ?: YJGSTVC_DEFAULT_TABLE_BACKGROUND_COLOR;
    UIColor *itemBGColor = [self backgroundColorForItemCell] ?: YJGSTVC_DEFAULT_ITEM_CELL_BACKGROUND_COLOR;
    // header cell
    if (row == 0) {
        NSString *headerCellReuseID = [self reuseIdentifierForHeaderCell] ?: YJGSTVC_HEADER_CELL_REUSE_ID;
        if (self.didRegisterHeaderCell) {
            cell = [tableView dequeueReusableCellWithIdentifier:headerCellReuseID forIndexPath:indexPath];
            cell.backgroundColor = cell.contentView.backgroundColor;
            [self configureHeaderCell:cell];
        } else {
            cell = [tableView dequeueReusableCellWithIdentifier:headerCellReuseID];
            if (!cell) {
                cell = [[_YJGroupedStyleGroupSeparatorCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:headerCellReuseID];
                cell.contentView.backgroundColor = tableBGColor;
                cell.backgroundColor = tableBGColor;
                [self configureGroupSeparatorCell:cell];
            }
        }
        self.backgroundColorForHeaderCell = cell.contentView.backgroundColor ?: (cell.backgroundColor ?: [self backgroundColorForTableView]);
    }
    // item cell
    else if (isItemRow) {
        cell = [tableView dequeueReusableCellWithIdentifier:YJGSTVC_ITEM_CELL_REUSE_ID];
        if (!cell) cell = [[_YJGroupedStyleItemCell alloc] initWithStyle:[self styleForItemCell] reuseIdentifier:YJGSTVC_ITEM_CELL_REUSE_ID];
        cell.accessoryType = [self hasDestinationViewControllerForItemCellAtIndexPath:indexPath] ? UITableViewCellAccessoryDisclosureIndicator : UITableViewCellAccessoryNone;
        cell.contentView.backgroundColor = itemBGColor;
        cell.backgroundColor = itemBGColor;
        [self configureItemCell:(id)cell atIndexPath:indexPath];
    }
    // group separator cell
    else if ([self.mappedRows[row] hasPrefix:YJGSGroupSeparator]) {
        cell = [tableView dequeueReusableCellWithIdentifier:YJGSTVC_GROUP_SEPARATOR_CELL_REUSE_ID forIndexPath:indexPath];
        cell.contentView.backgroundColor = tableBGColor;
        cell.backgroundColor = tableBGColor;
        [self configureGroupSeparatorCell:cell];
    }
    // line separator cell
    else {
        cell = [tableView dequeueReusableCellWithIdentifier:YJGSTVC_LINE_SEPARATOR_CELL_REUSE_ID forIndexPath:indexPath];
        _YJGroupedStyleLineSeparatorCell *lineSeparator = (_YJGroupedStyleLineSeparatorCell *)cell;
        UIColor *specifiedLineColor = [self lineSeparatorColorForTableView] ?: YJGSTVC_DEFAULT_LINE_SEPARATOR_COLOR;
        // line separator for separating item cell
        if ([[self.mappedRows[row] componentsSeparatedByString:@":"].lastObject isEqualToString:YJGSLineSeparatingItemCell]) {
            // set left indentation
            CGFloat indent = 0.0f;
            BOOL hasIcon = (self.iconImagesForItemCells.count || self.iconImageNamesForItemCells.count) ? YES : NO;
            switch ([self indentationStyleForItemCell]) {
                case YJGroupedStyleTableViewCellIndentationStyleAlignTitle: indent = hasIcon ? 54.0f : 16.0f; break;
                case YJGroupedStyleTableViewCellIndentationStyleFixedMargin: indent = 16.0f; break;
            }
            lineSeparator.leftIndentation = indent;
            // set line separator color
            UIColor *separatorColor = specifiedLineColor;
            switch ([self lineSeparatorStyleForTableView]) {
                case YJGroupedStyleTableViewSeparatorStyleDefault: break;
                case YJGroupedStyleTableViewSeparatorStyleHideAll: separatorColor = itemBGColor; break;
                case YJGroupedStyleTableViewSeparatorStyleHideGroup: break;
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
            switch ([self lineSeparatorStyleForTableView]) {
                case YJGroupedStyleTableViewSeparatorStyleDefault: break;
                case YJGroupedStyleTableViewSeparatorStyleHideAll: separatorColor = tableBGColor; break;
                case YJGroupedStyleTableViewSeparatorStyleHideGroup: separatorColor = tableBGColor; break;
            }
            lineSeparator.lineColor = separatorColor;
            lineSeparator.compensatedColor = [self backgroundColorForTableView];
        }
    }
    // hide default separator
    cell.separatorInset = UIEdgeInsetsMake(0, 9999, 0, 0);
    cell.indentationWidth = -9999;
    cell.indentationLevel = 1;
    // returns
    return cell;
}

- (void)configureItemCell:(_YJGroupedStyleItemCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    NSInteger row = indexPath.row;
    cell.textLabel.text = self.itemTitles[@(row)];
    cell.detailTextLabel.text = self.itemSubtitles[@(row)];
    UIImage *image = self.itemIconImages[@(row)];
    NSString *imageName = self.itemIconImageNames[@(row)];
    if (!image && imageName.length) image = [UIImage imageNamed:imageName];
    if (image) cell.imageView.image = image;
    
    NSInteger itemRow, section;
    [self getMappedItemRow:&itemRow inSection:&section forIndexPath:indexPath];
    [self configureItemCell:cell forRow:itemRow inSection:section];
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger row = indexPath.row;
    // header cell
    if (row == 0) {
        if (self.didRegisterHeaderCell) {
            if (self.heightForHeaderCell) return self.heightForHeaderCell;
            UITableViewCell *cell = nil;
            if ([self nibNameForRegisteringHeaderCell].length) {
                cell = [[NSBundle mainBundle] loadNibNamed:[self nibNameForRegisteringHeaderCell] owner:self options:nil].firstObject;
            } else {
                Class HCClass = [self classForRegisteringHeaderCell];
                if (!HCClass && [self classNameForRegisteringHeaderCell].length) {
                    HCClass = NSClassFromString([self classNameForRegisteringHeaderCell]);
                }
                cell = [HCClass new];
                if (!cell) return 0.0f;
            }
            cell.tag = YJGroupedStyleTableViewControllerHeaderCellForCompressedSizeCalculation;
            [self configureHeaderCell:cell];
            self.heightForHeaderCell = [self cellHeightFittingInCompressedSizeForCell:cell];
            return self.heightForHeaderCell;
        } else {
            return [self shouldHideNavigationBar] ? kUIStatusBarHeight + kUINavigationBarHeight : kUIStatusBarHeight;
        }
    }
    // item cell
    else if ([self.itemRows containsObject:@(row)]) {
        return [self heightForItemCell];
    }
    // group sperator
    else if ([self.mappedRows[row] hasPrefix:YJGSGroupSeparator]) {
        // last big group sperator cell
        if (row == self.totalCellCount - 1) {
            return kYJGSTVCLastGroupSeparatorCellHeight;
        } else {
            return [self heightForVerticalSpaceBetweenGroups];
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger row = indexPath.row;
    if (![self.itemRows containsObject:@(row)]) return;
    
    NSInteger itemRow, section;
    [self getMappedItemRow:&itemRow inSection:&section forIndexPath:indexPath];
    if (![self canPushDestinationViewControllerFromItemCellForRow:itemRow inSection:section]) return;
    
    UIViewController *vc = nil;
    // vc from storyboard id
    NSString *storyboardID = self.storyboardIdentifiersForDestinationViewControllers[@(row)];
    if (storyboardID.length) {
        NSString *storyboardName = [self storyboardNameForControllerStoryboardIdentifier:storyboardID] ?: @"Main";
        vc = [[UIStoryboard storyboardWithName:storyboardName bundle:nil] instantiateViewControllerWithIdentifier:storyboardID];
    }
    // vc from code
    if (!vc) {
        NSString *className = self.classNamesForDestinationViewControllers[@(row)];
        if (className.length) {
            Class VCClass = NSClassFromString(className);
            if (VCClass) vc = [VCClass new];
        }
    }
    if (!vc) return;
    
    vc.hidesBottomBarWhenPushed = YES;
    [self configureDestinationViewControllerBeforePushing:vc forRow:itemRow inSection:section];
    
    [self setNavigationBarTranslucentIfPossible:NO];
    [self.navigationController pushViewController:vc animated:YES];
}

- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger itemRow, section;
    [self getMappedItemRow:&itemRow inSection:&section forIndexPath:indexPath];
    
    if (indexPath.row == 0 ||
        ![self.itemRows containsObject:@(indexPath.row)] ||
        ![self hasDestinationViewControllerForItemCellAtIndexPath:indexPath] ||
        ![self canPushDestinationViewControllerFromItemCellForRow:itemRow inSection:section]) {
        return NO;
    }
    return YES;
}

- (BOOL)hasDestinationViewControllerForItemCellAtIndexPath:(NSIndexPath *)indexPath {
    return self.classNamesForDestinationViewControllers[@(indexPath.row)].length ||
    self.storyboardIdentifiersForDestinationViewControllers[@(indexPath.row)].length;
}

// WARNING: Using legacy cell layout due to delegate implementation of tableView:accessoryTypeForRowWithIndexPath: in <XXX: 0x14db2d40>.  Please remove your implementation of this method and set the cell properties accessoryType and/or editingAccessoryType to move to the new cell layout behavior.  This method will no longer be called in a future release.

//- (UITableViewCellAccessoryType)tableView:(UITableView *)tableView accessoryTypeForRowWithIndexPath:(NSIndexPath *)indexPath {
//    if (![self hasDestinationViewControllerForItemCellAtIndexPath:indexPath]) {
//        return UITableViewCellAccessoryNone;
//    }
//    return UITableViewCellAccessoryDisclosureIndicator;
//}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    BOOL navBarIsTranslucent = self.navigationController.navigationBar.isTranslucent;
    if ([self shouldOpaqueNavBarIfNeeded]) {
        if (navBarIsTranslucent) {
            self.navigationController.navigationBar.translucent = NO;
        }
    } else {
        if (!navBarIsTranslucent && [self shouldTranslucentNavigationBar]) {
            self.navigationController.navigationBar.translucent = YES;
        }
    }
}

- (BOOL)shouldOpaqueNavBarIfNeeded {
    return self.tableView.contentOffset.y >= (self.heightForHeaderCell - kUINavigationBarHeight - kUIStatusBarHeight) ? YES : NO;
}

#pragma mark - default implementations

// navigation bar
- (BOOL)shouldHideNavigationBar {
    return NO;
}

- (BOOL)shouldMaskNavigationBarBackgroundColor {
    return YES;
}

- (BOOL)shouldHideNavigationBarShadow {
    return YES;
}

- (BOOL)shouldTranslucentNavigationBar {
    return YES;
}

// table view
- (UIColor *)backgroundColorForTableView {
    return YJGSTVC_DEFAULT_TABLE_BACKGROUND_COLOR;
}

- (CGFloat)topEdgeInsetForTableView {
    return 0.0f;
}

- (YJGroupedStyleTableViewSeparatorStyle)lineSeparatorStyleForTableView {
    return YJGroupedStyleTableViewSeparatorStyleDefault;
}

- (UIColor *)lineSeparatorColorForTableView {
    return YJGSTVC_DEFAULT_LINE_SEPARATOR_COLOR;
}

- (UIEdgeInsets)separatorInsetsForTableView {
    return UIEdgeInsetsZero;
}

// register header cell
- (nullable NSString *)nibNameForRegisteringHeaderCell {
    return nil;
}

- (nullable Class)classForRegisteringHeaderCell {
    return nil;
}

- (nullable NSString *)classNameForRegisteringHeaderCell {
    return nil;
}

- (nullable NSString *)reuseIdentifierForHeaderCell {
    return nil;
}

- (UITableViewCellStyle)styleForItemCell {
    return UITableViewCellStyleDefault;
}

- (YJGroupedStyleTableViewCellIndentationStyle)indentationStyleForItemCell {
    return YJGroupedStyleTableViewCellIndentationStyleAlignTitle;
}

- (UIColor *)backgroundColorForItemCell {
    return YJGSTVC_DEFAULT_ITEM_CELL_BACKGROUND_COLOR;
}

// configure cell
- (void)configureHeaderCell:(UITableViewCell *)cell {
    
}

- (void)configureItemCell:(UITableViewCell *)cell forRow:(NSInteger)row inSection:(NSInteger)section {
    
}

- (void)configureGroupSeparatorCell:(UITableViewCell *)cell {
    
}

// configure cell contents
// For cell titles, it needs the nest array for grouping titles.

- (NSArray <NSArray <NSString *> *> *)titlesForGroupedCells {
    return @[ @[ @"First item in group A" ],
              @[ @"First item in group B", @"Second item in group B", @"Third item in group B" ],
              @[ @"First item in group C", @"Second item in group C" ] ];
}

// There is no need to group cast style for rest of cell content informations, expect for cell titles.

- (nullable NSArray <NSString *> *)subtitlesForItemCells {
/* Example:
return
  @[ @"group A - item 1",
     @"group B - item 1",
     @"group B - item 2",
     @"group B - item 3",
     @"group C - item 1",
     @"group C - item 2" ]; */
    return nil;
}

- (nullable NSArray <UIImage *> *)iconImagesForItemCells {
    return nil;
}

- (nullable NSArray <NSString *> *)iconImageNamesForItemCells {
    return nil;
}

- (nullable NSArray <NSString *> *)classNamesOfDestinationViewControllersForItemCells {
    return nil;
}

- (nullable NSArray <NSString *> *)storyboardIdentifiersOfDestinationViewControllersForItemCells {
    return nil;
}

- (nullable NSString *)storyboardNameForControllerStoryboardIdentifier:(NSString *)storyboardID {
    return @"Main";
}

- (BOOL)canPushDestinationViewControllerFromItemCellForRow:(NSInteger)row inSection:(NSInteger)section {
    return YES;
}

- (void)configureDestinationViewControllerBeforePushing:(__kindof UIViewController *)viewController forRow:(NSInteger)row inSection:(NSInteger)section {
    
}

- (CGFloat)heightForItemCell {
    return 44.0f;
}

- (CGFloat)heightForVerticalSpaceBetweenGroups {
    return 40.0f;
}

@end


NSInteger const YJGroupedStyleTableViewControllerHeaderCellForCompressedSizeCalculation = __LINE__;


@implementation UITableView (_YJReloadData)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self swizzleInstanceMethodForSelector:@selector(reloadData) toSelector:@selector(yj_reloadData)];
    });
}

- (void)yj_reloadData {
    if ([self.delegate respondsToSelector:@selector(fetchRequiredDataForLoadingGroupedCells)]) {
        [(id)self.delegate fetchRequiredDataForLoadingGroupedCells];
    }
    [self yj_reloadData];
}

@end

