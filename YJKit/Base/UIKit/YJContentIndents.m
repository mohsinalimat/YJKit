//
//  YJContentIndents.m
//  YJKit
//
//  Created by huang-kun on 16/5/14.
//  Copyright © 2016年 huang-kun. All rights reserved.
//

#import "YJContentIndents.h"

const YJContentIndents YJContentIndentsZero = { 0, 0, 0, 0 };

NSString *NSStringFromYJContentIndents(YJContentIndents indents) {
    return [NSString stringWithFormat:@"(YJContentIndents) { top: %@, left: %@, bottom: %@, right: %@ }", @(indents.top), @(indents.left), @(indents.bottom), @(indents.right)];
}