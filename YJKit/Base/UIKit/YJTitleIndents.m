//
//  YJTitleIndents.m
//  YJKit
//
//  Created by huang-kun on 16/5/14.
//  Copyright © 2016年 huang-kun. All rights reserved.
//

#import "YJTitleIndents.h"

const YJTitleIndents YJTitleIndentsZero = { 0, 0, 0, 0 };

NSString *NSStringFromYJTitleIndents(YJTitleIndents indents) {
    return [NSString stringWithFormat:@"(YJTitleIndents) { top: %@, left: %@, bottom: %@, right: %@ }", @(indents.top), @(indents.left), @(indents.bottom), @(indents.right)];
}