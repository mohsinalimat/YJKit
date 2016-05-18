//
//  YJStaticTableViewController.m
//  YJKit
//
//  Created by huang-kun on 16/5/17.
//  Copyright © 2016年 huang-kun. All rights reserved.
//

#import "YJStaticTableViewController.h"

@interface YJStaticTableViewController ()
@end

@implementation YJStaticTableViewController

- (nullable NSString *)nibNameForRegisteringHeaderCell {
    return @"YJStaticHeaderCell";
}

- (NSArray <NSArray <NSString *> *> *)titlesForGroupedCells {
    return @[ @[ @"hello", @"world" ],
              @[ @"and", @"you" ],
              @[ @"1", @"2", @"3", @"4" ],
              @[ @"hi" ]
              ];
}

- (YJGroupedStyleTableViewCellIndentationStyle)indentationStyleForItemCell {
    return YJGroupedStyleTableViewCellIndentationStyleAlignTitle;
}

@end
