//
//  YJGroupedStyleTableViewController.h
//  YJKit
//
//  Created by huang-kun on 16/5/11.
//  Copyright © 2016年 huang-kun. All rights reserved.
//


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


#import "YJGroupedStyleTableViewController.h"
#import "UIScreen+YJCategory.h"
#import "YJUIMacros.h"

#define YJGSTVCItemCellReuseID @"YJGSTVCItemCellReuseID"
#define YJGSTVCSeparatorCellReuseID @"YJGSTVCSeparatorCellReuseID"

static const CGFloat kYJGSTVCBackgroundTranslucentAlpha = 0.7;

@interface YJGroupedStyleTableViewController ()
@property (nonatomic, copy) NSArray <NSNumber *> *itemRows; // Rows for item cells
@property (nonatomic, copy) NSDictionary <NSNumber *, NSString *> *itemTitles;
@property (nonatomic, copy, nullable) NSDictionary <NSNumber *, NSString *> *itemSubtitles;
@property (nonatomic, copy, nullable) NSDictionary <NSNumber *, UIImage *> *itemIconImages;
@property (nonatomic, copy, nullable) NSDictionary <NSNumber *, NSString *> *itemIconImageNames;
@property (nonatomic, copy, nullable) NSDictionary <NSNumber *, NSString *> *classNamesForDestinationViewControllers;
@property (nonatomic, copy, nullable) NSDictionary <NSNumber *, NSString *> *storyboardIdentifiersForDestinationViewControllers;
@property (nonatomic, strong) UIImage *backgroundImage; // @dynamic
@property (nonatomic, assign) BOOL shouldAnimateStatusBar; // If self is pushed from tabbar vc, not animated; otherwise animated.
@property (nonatomic, assign) BOOL didRegisterHeaderCell;
@end

@implementation YJGroupedStyleTableViewController

- (instancetype)init {
    self = [super initWithStyle:UITableViewStylePlain]; // I'll fake it to group style later
    if (self) {
        [self fetchRequiredData];
        self.tableView.backgroundColor = [self backgroundColorForTableView];
        self.tableView.contentInset = UIEdgeInsetsMake(-kUIStatusBarHeight, 0, 50, 0); // hide status bar on top, show extra spaces on bottom
        self.tableView.separatorInset = UIEdgeInsetsMake(0, 5, 0, 0);
        self.tableView.separatorColor = [self backgroundColorForTableView];
#if YJPCLoadBackgroundImageDebug
        self.backgroundImage = [UIImage imageNamed:@"dragon"]; // for displaying background image if needed
#endif
    }
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
        NSAssert(itemRows.count == list.count, @"<%@> ItemRows has different count with list. \nItemRows:%@, \nlist:%@", self.class, itemRows, list);
        NSMutableDictionary *contents = @{}.mutableCopy;
        for (NSInteger i = 0; i < list.count; ++i) {
            contents[itemRows[i]] = list[i];
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
    self.backgroundImage = [self backgroundImageForTableView];
}

#pragma mark - subclass overriding

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

// register header cell
- (nullable NSString *)nibNameForRegisteringHeaderCell {
    return @"YJPersonCenterUserInfoCell";
}

- (nullable Class)classForRegisteringHeaderCell {
    return nil;
}

- (NSString *)reuseIdentifierForHeaderCell {
    return @"YJGSTVCHeaderCellReuseID";
}

- (UITableViewCellStyle)styleForItemCell {
    return UITableViewCellStyleDefault;
}

// configure cell
- (void)configureHeaderCell:(UITableViewCell *)cell {
    
}

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

- (NSString *)storyboardNameForControllerStoryboardIdentifier:(NSString *)storyboardID {
    return @"Main";
}

- (BOOL)canPushViewControllerFromItemCellAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (CGFloat)heightForItemCell {
    return 46.0f;
}

- (CGFloat)heightForSeparator {
    return 9.0f;
}

#pragma mark - life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerClass:[YJGroupedStyleSeparatorCell class] forCellReuseIdentifier:YJGSTVCSeparatorCellReuseID];
    NSString *nibName = [self nibNameForRegisteringHeaderCell];
    Class cls = [self classForRegisteringHeaderCell];
    if (nibName.length) {
        [self.tableView registerNib:[UINib nibWithNibName:nibName bundle:nil] forCellReuseIdentifier:[self reuseIdentifierForHeaderCell]];
        self.didRegisterHeaderCell = YES;
    } else if (cls) {
        [self.tableView registerClass:cls forCellReuseIdentifier:[self reuseIdentifierForHeaderCell]];
        self.didRegisterHeaderCell = YES;
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.tableView.backgroundColor = self.backgroundImage ? nil : [self backgroundColorForTableView];
    if ([self shouldHideNavigationBar]) {
        [self.navigationController setNavigationBarHidden:YES animated:self.shouldAnimateStatusBar];
        [self updateStatusBar];
    }
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

- (void)updateStatusBar {
    self.shouldAnimateStatusBar = (self.navigationController.viewControllers.count == 1) ? NO : YES;
}

#pragma mark - Accessors

- (UIImage *)backgroundImage {
    if (self.tableView.backgroundView && [self.tableView.backgroundView isKindOfClass:[UIImageView class]]) {
        return [(UIImageView *)self.tableView.backgroundView image];
    }
    return nil;
}

- (void)setBackgroundImage:(UIImage *)image {
    UIImageView *backgroundImageView = (UIImageView *)self.tableView.backgroundView;
    if (!backgroundImageView) {
        backgroundImageView = [[UIImageView alloc] initWithFrame:kUIScreenBounds];
        backgroundImageView.contentMode = UIViewContentModeScaleToFill;
        backgroundImageView.backgroundColor = [self backgroundColorForTableView];
        self.tableView.backgroundView = backgroundImageView;
    }
    backgroundImageView.image = image;
}

#pragma mark - Translucency

- (void)configureTranslucencyForCell:(UITableViewCell *)cell {
    BOOL hasBackgroundImage = (self.backgroundImage != nil) ? YES : NO;
    CGFloat alpha = hasBackgroundImage ? kYJGSTVCBackgroundTranslucentAlpha : 1.0;
    cell.superview.alpha = alpha;
    cell.contentView.alpha = alpha;
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.itemRows.lastObject.integerValue + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger row = indexPath.row;
    BOOL isItemRow = [self.itemRows containsObject:@(row)] ? YES : NO;
    UITableViewCell *cell = nil;
    UIColor *bgColor = [self backgroundColorForTableView];
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
            }
        }
    } else if (isItemRow) {
        cell = [tableView dequeueReusableCellWithIdentifier:YJGSTVCItemCellReuseID];
        if (!cell) cell = [[YJGroupedStyleItemCell alloc] initWithStyle:[self styleForItemCell] reuseIdentifier:YJGSTVCItemCellReuseID];
        cell.textLabel.text = self.itemTitles[@(row)];
        cell.detailTextLabel.text = self.itemSubtitles[@(row)];
        UIImage *image = self.itemIconImages[@(row)];
        if (!image) image = [UIImage imageNamed:self.itemIconImageNames[@(row)]];
        cell.imageView.image = image;
    } else {
        cell = [tableView dequeueReusableCellWithIdentifier:YJGSTVCSeparatorCellReuseID forIndexPath:indexPath];
        if (bgColor) cell.contentView.backgroundColor = bgColor;
    }
    if (row != 0) [self configureTranslucencyForCell:cell];
    return cell;
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
    }
    return [self heightForSeparator];
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
    if (![self canPushViewControllerFromItemCellAtIndexPath:indexPath]) return;
    
    // push vc using storyboard id
    BOOL (^pushViewControllerFromStoryboard)() = ^{
        NSString *storyboardID = self.storyboardIdentifiersForDestinationViewControllers[@(row)];
        if (!storyboardID.length) return NO;
        NSString *storyboardName = [self storyboardNameForControllerStoryboardIdentifier:storyboardID];
        UIViewController *vc = [[UIStoryboard storyboardWithName:storyboardName bundle:nil] instantiateViewControllerWithIdentifier:storyboardID];
        [self.navigationController pushViewController:vc animated:YES];
        return YES;
    };
    
    // push vc from code
    BOOL (^pushViewControllerFromCode)() = ^{
        NSString *className = self.classNamesForDestinationViewControllers[@(row)];
        if (!className) return NO;
        Class VCClass = NSClassFromString(className);
        if (!VCClass) return NO;
        UIViewController *vc = [VCClass new];
        [self.navigationController pushViewController:vc animated:YES];
        return YES;
    };
    
    if (!pushViewControllerFromStoryboard()) {
        pushViewControllerFromCode();
    }
}

- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath {
    if (![self canPushViewControllerFromItemCellAtIndexPath:indexPath]) return NO;
    else return (indexPath.row == 0 || ![self.itemRows containsObject:@(indexPath.row)]) ? NO : YES;
}

@end

const NSInteger YJGroupedStyleTableViewControllerHeaderCellForFittingSizeCalculationTag = __LINE__;
