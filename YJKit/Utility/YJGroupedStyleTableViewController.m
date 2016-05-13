//
//  YJGroupedStyleTableViewController.h
//  YJKit
//
//  Created by huang-kun on 16/5/11.
//  Copyright © 2016年 huang-kun. All rights reserved.
//

#import "YJGroupedStyleTableViewController.h"
#import "NSArray+YJCollection.h"
#import "YJUIMacros.h"
#import "YJExecutionMacros.h"

@interface YJGroupedStyleItemCell : UITableViewCell
@end

@interface YJGroupedStyleSeparatorCell : UITableViewCell
@end

@implementation YJGroupedStyleItemCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    return self;
}

@end

@implementation YJGroupedStyleSeparatorCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor lightGrayColor];
    }
    return self;
}

@end

#define YJGSTVCItemCellReuseID @"YJGSTVCItemCellReuseID"
#define YJGSTVCSeparatorCellReuseID @"YJGSTVCSeparatorCellReuseID"

static const CGFloat kYJGSTVCLastSeparatorCellHeight = 999.0f;
static const CGFloat kYJGSTVCBottomSpaceFromLastCell = 50.0f;

@interface YJGroupedStyleTableViewController ()
@property (nonatomic, copy) NSArray <NSNumber *> *itemRows; // Rows for item cells
@property (nonatomic, copy) NSDictionary <NSNumber *, NSString *> *itemTitles;
@property (nonatomic, copy, nullable) NSDictionary <NSNumber *, NSString *> *itemSubtitles;
@property (nonatomic, copy, nullable) NSDictionary <NSNumber *, UIImage *> *itemIconImages;
@property (nonatomic, copy, nullable) NSDictionary <NSNumber *, NSString *> *itemIconImageNames;
@property (nonatomic, copy, nullable) NSDictionary <NSNumber *, NSString *> *classNamesForDestinationViewControllers;
@property (nonatomic, copy, nullable) NSDictionary <NSNumber *, NSString *> *storyboardIdentifiersForDestinationViewControllers;
@property (nonatomic, strong) UIColor *backgroundColorForHeaderCell; // @dynamic
@property (nonatomic, assign) BOOL shouldAnimateStatusBar;
@property (nonatomic, assign) BOOL didRegisterHeaderCell;
@end

@implementation YJGroupedStyleTableViewController

- (instancetype)init {
    self = [super initWithStyle:UITableViewStylePlain];
    if (self) [self fetchRequiredData];
    return self;
}

#pragma mark - mapping

- (void)fetchRequiredData {
    
    NSMutableDictionary <NSNumber *, NSString *> *titles = @{}.mutableCopy;
    NSInteger index = 2;
    NSArray *groups = [self titlesForGroupedCells];
    for (NSArray *group in groups) {
        for (NSString *title in group) {
            titles[@(index)] = title;
            index++;
        }
        index++;
    }
    
    NSArray *itemRows = [[titles allKeys] sortedArrayUsingComparator:^NSComparisonResult(NSNumber *obj1, NSNumber *obj2) {
        if ([obj1 integerValue] < [obj2 integerValue]) return NSOrderedAscending;
        else if ([obj1 integerValue] > [obj2 integerValue]) return NSOrderedDescending;
        else return NSOrderedSame;
    }];
    
    NSDictionary * __nullable (^cellContentsFromList)(NSArray *) = ^NSDictionary * __nullable (NSArray *list) {
        if (!list.count) return nil;
        NSArray *flattenList = [list flatten];
        NSAssert(itemRows.count == flattenList.count, @"<%@> ItemRows has different count with list. \nItemRows:%@, \nlist:%@", self.class, itemRows, flattenList);
        NSMutableDictionary *contents = @{}.mutableCopy;
        for (NSInteger i = 0; i < flattenList.count; ++i) {
            contents[itemRows[i]] = flattenList[i];
        }
        return contents.copy;
    };
    
    self.itemTitles = titles.copy;
    self.itemRows = itemRows;
    self.itemSubtitles = cellContentsFromList([self subtitlesForItemCells]);
    self.itemIconImages = cellContentsFromList([self iconImagesForItemCells]);
    self.itemIconImageNames = cellContentsFromList([self iconImageNamesForItemCells]);
    self.classNamesForDestinationViewControllers = cellContentsFromList([self classNamesOfDestinationViewControllersForItemCells]);
    self.storyboardIdentifiersForDestinationViewControllers = cellContentsFromList([self storyboardIdentifiersOfDestinationViewControllersForItemCells]);
    
    UIEdgeInsets insets = UIEdgeInsetsZero;
    insets.bottom = kYJGSTVCBottomSpaceFromLastCell;
    if ([self shouldHideNavigationBar]) insets.top -= kUIStatusBarHeight;
    self.tableView.contentInset = insets;
    
    self.tableView.backgroundColor = [self backgroundColorForTableView];
    self.tableView.separatorColor = [self backgroundColorForTableView];
    self.tableView.separatorInset = [self separatorInsetsForTableView];
}

- (NSUInteger)totalCellCount {
    return self.itemRows.lastObject.integerValue + 2;
}



#pragma mark - life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // registering separator
    [self.tableView registerClass:[YJGroupedStyleSeparatorCell class] forCellReuseIdentifier:YJGSTVCSeparatorCellReuseID];
    // registering header cell
    NSString *nibName = [self nibNameForRegisteringHeaderCell];
    Class HeaderCellClass = [self classForRegisteringHeaderCell];
    if (nibName.length) {
        [self.tableView registerNib:[UINib nibWithNibName:nibName bundle:nil] forCellReuseIdentifier:[self reuseIdentifierForHeaderCell]];
        self.didRegisterHeaderCell = YES;
    } else if (HeaderCellClass) {
        [self.tableView registerClass:HeaderCellClass forCellReuseIdentifier:[self reuseIdentifierForHeaderCell]];
        self.didRegisterHeaderCell = YES;
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    // update navigation bar and status bar
    if ([self shouldHideNavigationBar]) {
        [self.navigationController setNavigationBarHidden:YES animated:self.shouldAnimateStatusBar];
        [self updateStatusBar];
    } else {
        [self hideNavigationBarShadow];
    }
    // update tableView scrollable insets
    perform_once()
    UIEdgeInsets insets = self.tableView.contentInset;
    insets.bottom -= kYJGSTVCLastSeparatorCellHeight;
    self.tableView.contentInset = insets;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    self.navigationController.navigationBar.translucent = YES;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    if ([self shouldHideNavigationBar]) {
        [self.navigationController setNavigationBarHidden:NO animated:YES];
        [self updateStatusBar];
    }
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    if ([self shouldHideNavigationBar]) [self updateStatusBar];
}

#pragma mark - Update status bar and navigation bar

- (void)updateStatusBar {
    self.shouldAnimateStatusBar = (self.navigationController.viewControllers.count == 1) ? NO : YES;
}

- (void)hideNavigationBarShadow {
    // hide 1px shadow image
    UIImage *emptyShadow = [UIImage new];
    UINavigationBar *navBar = self.navigationController.navigationBar;
    navBar.translucent = NO;
    navBar.shadowImage = emptyShadow;
    [navBar setBackgroundImage:emptyShadow forBarMetrics:UIBarMetricsDefault];
}

#pragma mark - Accessors

- (void)setBackgroundColorForHeaderCell:(UIColor *)backgroundColorForHeaderCell {
    self.tableView.backgroundColor = backgroundColorForHeaderCell;
    self.navigationController.navigationBar.barTintColor = backgroundColorForHeaderCell;
}

- (UIColor *)backgroundColorForHeaderCell {
    return self.tableView.backgroundColor;
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
    UIColor *bgColor = [self backgroundColorForTableView];
    // header cell
    if (row == 0) {
        NSString *headerCellReuseID = [self reuseIdentifierForHeaderCell];
        if (headerCellReuseID && self.didRegisterHeaderCell) {
            cell = [tableView dequeueReusableCellWithIdentifier:headerCellReuseID forIndexPath:indexPath];
            [self configureHeaderCell:cell];
        } else {
            headerCellReuseID = @"_YJGSTVCHeaderCellReuseID";
            cell = [tableView dequeueReusableCellWithIdentifier:headerCellReuseID];
            if (!cell) {
                cell = [[YJGroupedStyleSeparatorCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:headerCellReuseID];
                if (bgColor) cell.contentView.backgroundColor = bgColor;
                [self configureSeparatorCell:cell];
            }
        }
        self.backgroundColorForHeaderCell = cell.contentView.backgroundColor ?: (cell.backgroundColor ?: [self backgroundColorForTableView]);
    }
    // item cell
    else if (isItemRow) {
        cell = [tableView dequeueReusableCellWithIdentifier:YJGSTVCItemCellReuseID];
        if (!cell) cell = [[YJGroupedStyleItemCell alloc] initWithStyle:[self styleForItemCell] reuseIdentifier:YJGSTVCItemCellReuseID];
        cell.accessoryType = [self hasDestinationViewControllerForItemCellAtIndexPath:indexPath] ? UITableViewCellAccessoryDisclosureIndicator : UITableViewCellAccessoryNone;
        [self _configureItemCell:(id)cell atIndexPath:indexPath];
        [self configureItemCell:cell atItemRow:[self.itemRows indexOfObject:@(row)]];
    }
    // separator cell
    else {
        cell = [tableView dequeueReusableCellWithIdentifier:YJGSTVCSeparatorCellReuseID forIndexPath:indexPath];
        if (bgColor) cell.contentView.backgroundColor = bgColor;
        [self configureSeparatorCell:cell];
    }
    return cell;
}

- (void)_configureItemCell:(YJGroupedStyleItemCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    NSInteger row = indexPath.row;
    cell.textLabel.text = self.itemTitles[@(row)];
    cell.detailTextLabel.text = self.itemSubtitles[@(row)];
    UIImage *image = self.itemIconImages[@(row)];
    if (!image) image = [UIImage imageNamed:self.itemIconImageNames[@(row)]];
    cell.imageView.image = image;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger row = indexPath.row;
    if (row == 0) {
        if (self.didRegisterHeaderCell) {
            static CGFloat cellHeight = 0.0f;
            if (cellHeight) return cellHeight;
            UITableViewCell *cell = [[NSBundle mainBundle] loadNibNamed:[self nibNameForRegisteringHeaderCell] owner:self options:nil].firstObject;
            cell.tag = YJGroupedStyleTableViewControllerHeaderCellForFittingSizeCalculationTag;
            [self configureHeaderCell:cell];
            cellHeight = [self cellHeightFittingInCompressedSizeForCell:cell];
            return cellHeight;
        } else {
            return [self shouldHideNavigationBar] ? kUIStatusBarHeight + kUINavigationBarHeight : kUIStatusBarHeight;
        }
    } else if ([self.itemRows containsObject:@(row)]) {
        return [self heightForItemCell];
    } else if (row == self.totalCellCount - 1) {
        return kYJGSTVCLastSeparatorCellHeight;
    }
    return [self heightForVerticalSpaceBetweenGroups];
}

- (CGFloat)cellHeightFittingInCompressedSizeForCell:(UITableViewCell *)cell {
    UIView *contentView = cell.contentView;
    CGFloat cellWidth = self.tableView.frame.size.width;
    NSArray *constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:[contentView(==w)]" options:0 metrics:@{ @"w":@(cellWidth) } views:NSDictionaryOfVariableBindings(contentView)];
    [contentView addConstraints:constraints];
    CGSize cellSize = [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    [contentView removeConstraints:constraints];
    return cellSize.height;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger row = indexPath.row;
    if (![self.itemRows containsObject:@(row)]) return;
    if (![self canPushDestinationViewControllerFromItemCellAtItemRow:[self.itemRows indexOfObject:@(row)]]) return;
    
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
    [self configureDestinationViewControllerBeforePushing:vc atItemRow:[self.itemRows indexOfObject:@(row)]];
    
    self.navigationController.navigationBar.translucent = NO;
    [self.navigationController pushViewController:vc animated:YES];
}

- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0 ||
        ![self.itemRows containsObject:@(indexPath.row)] ||
        ![self hasDestinationViewControllerForItemCellAtIndexPath:indexPath] ||
        ![self canPushDestinationViewControllerFromItemCellAtItemRow:[self.itemRows indexOfObject:@(indexPath.row)]]) {
        return NO;
    }
    return YES;
}

- (BOOL)hasDestinationViewControllerForItemCellAtIndexPath:(NSIndexPath *)indexPath {
    return self.classNamesForDestinationViewControllers[@(indexPath.row)].length ||
    self.storyboardIdentifiersForDestinationViewControllers[@(indexPath.row)].length;
}

// WARNING: Using legacy cell layout due to delegate implementation of tableView:accessoryTypeForRowWithIndexPath: in <YJPersonCenterViewController: 0x14db2d40>.  Please remove your implementation of this method and set the cell properties accessoryType and/or editingAccessoryType to move to the new cell layout behavior.  This method will no longer be called in a future release.

//- (UITableViewCellAccessoryType)tableView:(UITableView *)tableView accessoryTypeForRowWithIndexPath:(NSIndexPath *)indexPath {
//    if (![self hasDestinationViewControllerForItemCellAtIndexPath:indexPath]) {
//        return UITableViewCellAccessoryNone;
//    }
//    return UITableViewCellAccessoryDisclosureIndicator;
//}

#pragma mark - default implementations

- (BOOL)shouldHideNavigationBar {
    return YES;
}

// table view
- (nullable UIColor *)backgroundColorForTableView {
    return [UIColor lightGrayColor];
}

- (nullable UIImage *)backgroundImageForTableView {
    return nil;
}

- (UIEdgeInsets)separatorInsetsForTableView {
    return UIEdgeInsetsMake(0, 5, 0, 0);
}

// register header cell
- (nullable NSString *)nibNameForRegisteringHeaderCell {
    return @"YJPersonCenterUserInfoCell";
}

- (nullable Class)classForRegisteringHeaderCell {
    return nil;
}

- (nullable NSString *)reuseIdentifierForHeaderCell {
    return @"YJGSTVCHeaderCellReuseID";
}

- (UITableViewCellStyle)styleForItemCell {
    return UITableViewCellStyleDefault;
}

// configure cell
- (void)configureHeaderCell:(UITableViewCell *)cell {
    
}

- (void)configureItemCell:(UITableViewCell *)cell atItemRow:(NSUInteger)itemRow {
    
}

- (void)configureSeparatorCell:(UITableViewCell *)cell {
    
}

// configure cell contents
- (NSArray <NSArray <NSString *> *> *)titlesForGroupedCells {
    return @[ @[ @"First item in group A" ],
              @[ @"First item in group B", @"Second item in group B", @"Third item in group B" ],
              @[ @"First item in group C", @"Second item in group C" ] ];
}

- (nullable NSArray <NSString *> *)subtitlesForItemCells {
    return nil;
    /* Example:
     return @[ @"group A - item 1",
     @"group B - item 1", @"group B - item 2", @"group B - item 3",
     @"group C - item 1", @"group C - item 2" ]; */
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

- (BOOL)canPushDestinationViewControllerFromItemCellAtItemRow:(NSUInteger)itemRow {
    return NO;
}

- (void)configureDestinationViewControllerBeforePushing:(__kindof UIViewController *)viewController atItemRow:(NSUInteger)itemRow {
    
}

- (CGFloat)heightForItemCell {
    return 44.0f;
}

- (CGFloat)heightForVerticalSpaceBetweenGroups {
    return 8.0f;
}

@end

const NSInteger YJGroupedStyleTableViewControllerHeaderCellForFittingSizeCalculationTag = __LINE__;
