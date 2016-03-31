//
//  YJGridViewController.m
//  YJKit
//
//  Created by Jack Huang on 16/3/30.
//  Copyright © 2016年 huang-kun. All rights reserved.
//

#import "YJGridViewController.h"
#import "UIView+YJCategory.h"

@interface YJGridViewController ()
@property (nonatomic, strong) UIView *horizontalBar;
@property (nonatomic, strong) UIView *verticalBar;
@property (nonatomic, strong) NSArray *horizontalSquares;
@property (nonatomic, strong) NSArray *verticalSquares;
@end

@implementation YJGridViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.    
    self.horizontalBar = [[UIView alloc] init];
    self.horizontalBar.backgroundColor = [UIColor orangeColor];
    self.verticalBar = [[UIView alloc] init];
    self.verticalBar.backgroundColor = [UIColor orangeColor];
    
    NSArray *(^squares)() = ^{
        NSMutableArray *squares = @[].mutableCopy;
        for (int i = 0; i < 5; i++) {
            UIView *square = [[UIView alloc] init];
            square.backgroundColor = [UIColor blueColor];
            [squares addObject:square];
        }
        return [squares copy];
    };
    
    self.horizontalSquares = squares();
    self.verticalSquares = squares();
    
    [self.view addSubview:self.horizontalBar];
    [self.view addSubview:self.verticalBar];
    
    for (UIView *square in self.horizontalSquares) {
        [self.horizontalBar addSubview:square];
    }
    for (UIView *square in self.verticalSquares) {
        [self.verticalBar addSubview:square];
    }
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.horizontalBar.frame = (CGRect){ 25, 50, self.view.bounds.size.width - 50 , 80 };
    self.verticalBar.frame = (CGRect){ self.view.bounds.size.width / 2 - 40, 150, 80, self.view.bounds.size.height - 200 };
    
    [self layoutHorizontalGrids:self.horizontalSquares inContainerView:self.horizontalBar];
    [self layoutVerticalGrids:self.verticalSquares inContainerView:self.verticalBar];
}

// fixed padding
- (void)layoutHorizontalGrids:(NSArray *)grids inContainerView:(UIView *)containerView {
    CGFloat size = YJGridWidthInContainerWidth(containerView.frame.size.width, grids.count, 10);
    for (int i = 0; i < grids.count; i++) {
        CGFloat x = YJGridOffsetXAtIndex(i, size, 10);
        UIView *grid = grids[i];
        CGRect frame;
        frame.origin.x = x;
        frame.origin.y = CGRectGetMidY(containerView.bounds) - size / 2;
        frame.size.width = size;
        frame.size.height = size;
        grid.frame = frame;
    }
}

// fixed size
- (void)layoutVerticalGrids:(NSArray *)grids inContainerView:(UIView *)containerView {
    CGFloat size = 10.0f;
    CGFloat padding = YJGridPaddingInContainerHeight(containerView.frame.size.height, size, grids.count);
    for (int i = 0; i < grids.count; i++) {
        CGFloat y = YJGridOffsetYAtIndex(i, size, padding);
        UIView *grid = grids[i];
        CGRect frame;
        frame.origin.x = CGRectGetMidX(containerView.bounds) - size / 2;
        frame.origin.y = y;
        frame.size.width = size;
        frame.size.height = size;
        grid.frame = frame;
    }
}

@end
