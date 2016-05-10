//
//  YJMaskTableViewController.m
//  YJKit
//
//  Created by huang-kun on 16/5/10.
//  Copyright © 2016年 huang-kun. All rights reserved.
//

#import "YJMaskTableViewController.h"
#import "UIBarButtonItem+YJCategory.h"
#import "YJObjcMacros.h"
#import "YJExecutionMacros.h"
#import "YJRoundedCornerImageView.h"
#import "UIView+YJCategory.h"
#import "UIScreen+YJCategory.h"


#define YJBlendedLayerCellReuseID @"YJBlendedLayerCellReuseID"
#define YJMaskedCellReuseID @"YJMaskedCellReuseID"

static const CGSize kYJSquareImageSize = (CGSize){ 50.0f, 50.0f };
static const CGFloat kYJSquareImageCornerRadius = 10.0f;
static const int kYJSquareImageCountInEachRow = 5;


@interface YJBlendedLayerCell : UITableViewCell
@end

@implementation YJBlendedLayerCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        CGFloat padding = YJGridPaddingInContainerWidth(kUIScreenSize.width, kYJSquareImageSize.width, kYJSquareImageCountInEachRow);
        for (int i = 0; i < kYJSquareImageCountInEachRow; i++) {
            CGFloat offset = YJGridOffsetXAtIndex(i, kYJSquareImageSize.width, padding);
            // Setup an image view
            UIImageView *demoImageView = [UIImageView new];
            demoImageView.frame = CGRectMake(offset, 0, kYJSquareImageSize.width, kYJSquareImageSize.height);
            demoImageView.image = [UIImage imageNamed:@"Puppy.jpg"];
            [self.contentView addSubview:demoImageView];
            // Setup rounded corner
            demoImageView.layer.cornerRadius = kYJSquareImageCornerRadius;
            demoImageView.layer.masksToBounds = YES;
        }
    }
    return self;
}

@end


@interface YJMaskedCell : UITableViewCell
@end

@implementation YJMaskedCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // The reason of YJRoundedCornerImageView can make rounded corner without layer blending is to create a shape layer with corner shapes on top of the image view that covers the original corners. The top corners for covering have the same color as the image view's superview's background color. So it's corners have been rounded by visual deception instead of actual rendering.
        // The most IMPORTANT condition for using YJRoundedCornerImageView to make rounded corner works is to make sure it's superview must has a background color. However the UITableViewCell's contentView does not have a default background color. So in this case, we must superview's background color explicitly.
        // There will be another issue when the superview doesn't have a background color and we can not set the superview's background color to solve it. e.g. Adding YJRoundedCornerImageView inside of UIStackView will cause the issue and UIStackView is not backed by CALayer for performance reason, so there is no way for setting it's superview's background color. In this case, we can explicitly set color to a property called maskColor of YJRoundedCornerImageView instance. This maskColor comes from the YJLayerBasedMasking protocol and YJMaskedImageView implements it for force using a given color for masking instead of using the default superview's background color.
        self.contentView.backgroundColor = [UIColor whiteColor];

        CGFloat padding = YJGridPaddingInContainerWidth(kUIScreenSize.width, kYJSquareImageSize.width, kYJSquareImageCountInEachRow);
        for (int i = 0; i < kYJSquareImageCountInEachRow; i++) {
            CGFloat offset = YJGridOffsetXAtIndex(i, kYJSquareImageSize.width, padding);
            // Setup an image view
            YJRoundedCornerImageView *demoImageView = [YJRoundedCornerImageView new];
            demoImageView.frame = CGRectMake(offset, 0, kYJSquareImageSize.width, kYJSquareImageSize.height);
            demoImageView.image = [UIImage imageNamed:@"Puppy.jpg"];
            [self.contentView addSubview:demoImageView];
            // Setup rounded corner
            demoImageView.cornerRadius = kYJSquareImageCornerRadius;
        }
    }
    return self;
}

@end


@interface YJMaskTableViewController ()
@property (nonatomic) BOOL tryYJMask;
@end

@implementation YJMaskTableViewController

- (void)dealloc {
    NSLog(@"%@ dealloc", self.class);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerClass:[YJBlendedLayerCell class] forCellReuseIdentifier:YJBlendedLayerCellReuseID];
    [self.tableView registerClass:[YJMaskedCell class] forCellReuseIdentifier:YJMaskedCellReuseID];
    [self setupMaskSwitch];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self setupHint];
}

- (void)setupHint {
    perform_once()
    [[[UIAlertView alloc] initWithTitle:@"Test with CALayer Instrument" message:@"Launch CALayer Instrument, check \"Color Blended Layers\" box, then run this demo. There will be green and red colors on the screen. Red colored region means using layer blending to achieve the rounded corner effect, and green colored region means opaque, which performs faster. Apple software engineers encouraged developers to use approaches to avoid layer blending and offscreen-rendering.\n\nYou can tap the button on the upper right corner to turn on and off layer blending." delegate:nil cancelButtonTitle:@"I've got it" otherButtonTitles:nil, nil] show];
}

- (void)setupMaskSwitch {
    @weakify(self)
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Blend Off" style:UIBarButtonItemStylePlain actionHandler:^(UIBarButtonItem * _Nonnull sender) {
        @strongify(self)
        if ([sender.title isEqualToString:@"Blend Off"]) {
            sender.title = @"Blend On";
            self.tryYJMask = YES;
        } else {
            sender.title = @"Blend Off";
            self.tryYJMask = NO;
        }
        [self.tableView reloadData];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 50;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *reuseID = self.tryYJMask ? YJMaskedCellReuseID : YJBlendedLayerCellReuseID;
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseID forIndexPath:indexPath];
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return kYJSquareImageSize.height + 1.0;
}

@end
