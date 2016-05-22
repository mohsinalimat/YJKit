//
//  YJContentExtension.m
//  YJKit
//
//  Created by huang-kun on 16/5/22.
//  Copyright © 2016年 huang-kun. All rights reserved.
//

#import "YJContentExtension.h"

static UIEdgeInsets _yj_insetsFromIndents(YJContentIndents indents) {
    return (UIEdgeInsets){ indents.top, indents.left, indents.bottom, indents.right };
}

static YJContentIndents _yj_indentsFromInsets(UIEdgeInsets insets) {
    return (YJContentIndents){ insets.top, insets.left, insets.bottom, insets.right };
}

@implementation NSValue (YJContentExtension)

+ (NSValue *)valueWithContentIndents:(YJContentIndents)indents {
    return [self valueWithUIEdgeInsets:_yj_insetsFromIndents(indents)];
}

- (YJContentIndents)YJContentIndentsValue {
    return _yj_indentsFromInsets([self UIEdgeInsetsValue]);
}

@end


@implementation NSCoder (YJContentExtension)

- (void)encodeContentIndents:(YJContentIndents)indents forKey:(NSString *)key {
    [self encodeUIEdgeInsets:_yj_insetsFromIndents(indents) forKey:key];
}

- (YJContentIndents)decodeContentIndentsForKey:(NSString *)key {
    return _yj_indentsFromInsets([self decodeUIEdgeInsetsForKey:key]);
}

@end