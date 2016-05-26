//
//  UITextView+YJCategory.m
//  YJKit
//
//  Created by huang-kun on 16/5/25.
//  Copyright © 2016年 huang-kun. All rights reserved.
//

#import <objc/runtime.h>
#import "UITextView+YJCategory.h"
#import "NSObject+YJCategory_Swizzling.h"
#import "NSObject+YJAssociatedIdentifier.h"
#import "NSArray+YJCollection.h"
#import "RGBColor.h"

static const void *YJTextViewAssociatedPlaceholderKey = &YJTextViewAssociatedPlaceholderKey;
static const void *YJTextViewAssociatedPlaceholderColorKey = &YJTextViewAssociatedPlaceholderColorKey;

@interface UITextView ()
@property (nonatomic, assign) RGBColor yj_originalTextColor;
@end

@implementation UITextView (YJCategory)

- (BOOL)_isEmpty {
    return !self.text.length && !self.attributedText.length;
}

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self swizzleInstanceMethodForSelector:@selector(initWithFrame:) toSelector:@selector(yj_initTextViewWithFrame:)];
        [self swizzleInstanceMethodForSelector:NSSelectorFromString(@"dealloc") toSelector:@selector(yj_textViewDealloc)];
        [self swizzleInstanceMethodForSelector:@selector(removeFromSuperview) toSelector:@selector(yj_textViewRemoveFromSuperview)];
    });
}

#pragma mark - placeholder

- (void)setPlaceholder:(NSString *)placeholder {
    objc_setAssociatedObject(self, YJTextViewAssociatedPlaceholderKey, placeholder, OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self _displayPlaceholderIfNeeded];
}

- (NSString *)placeholder {
    return objc_getAssociatedObject(self, YJTextViewAssociatedPlaceholderKey);
}

- (NSAttributedString *)_attributedPlaceholder:(NSString *)placeholder {
    NSDictionary *attributes = @{ NSForegroundColorAttributeName : self.placeholderColor };
    return [[NSAttributedString alloc] initWithString:placeholder attributes:attributes];
}

- (void)setPlaceholderColor:(UIColor *)placeholderColor {
    objc_setAssociatedObject(self, YJTextViewAssociatedPlaceholderColorKey, placeholderColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIColor *)placeholderColor {
    UIColor *placeholderColor = objc_getAssociatedObject(self, YJTextViewAssociatedPlaceholderColorKey);
    if (!placeholderColor) placeholderColor = [UIColor lightGrayColor];
    return placeholderColor;
}

#pragma mark - observing text editing

- (instancetype)yj_initTextViewWithFrame:(CGRect)frame {
    id textView = [self yj_initTextViewWithFrame:frame];
    
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc addObserver:self selector:@selector(yj_beginTextEditing) name:UITextViewTextDidBeginEditingNotification object:self];
    [nc addObserver:self selector:@selector(yj_endTextEditing) name:UITextViewTextDidEndEditingNotification object:self];
    
    return textView;
}

- (void)yj_textViewDealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [self yj_textViewDealloc];
}

- (void)yj_beginTextEditing {
    [self _hidePlaceholderIfPossible];
}

- (void)yj_endTextEditing {
    [self _displayPlaceholderIfNeeded];
}

#pragma mark - observing life cycle

- (void)layoutSubviews {
    [super layoutSubviews];
    
    NSArray *taps = [self.superview.gestureRecognizers filter:^BOOL(__kindof UIGestureRecognizer * _Nonnull obj) {
        return [obj isKindOfClass:[UITapGestureRecognizer class]];
    }];
    
    if (!taps.count) {
        UITapGestureRecognizer *dismissTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(yj_dismissTextView)];
        [self.superview addGestureRecognizer:dismissTap];
    } else {
        UITapGestureRecognizer *tap = taps.lastObject;
        [tap removeTarget:self action:@selector(yj_dismissTextView)];
        [tap addTarget:self action:@selector(yj_dismissTextView)];
    }
}

- (void)yj_textViewRemoveFromSuperview {
    for (UITapGestureRecognizer *tap in self.superview.gestureRecognizers) {
        [tap removeTarget:self action:@selector(yj_dismissTextView)];
    }
    [self yj_textViewRemoveFromSuperview];
}

- (void)yj_dismissTextView {
    [self resignFirstResponder];
}

#pragma mark - text attributes

- (void)_displayPlaceholderIfNeeded {
    if ([self _isEmpty]) {
        self.yj_originalTextColor = self.textColor ? [self.textColor RGBColor] : (RGBColor){0,0,0,1};
        self.attributedText = [self _attributedPlaceholder:self.placeholder];
    }
}

- (void)_hidePlaceholderIfPossible {
    if ([self.attributedText.string isEqualToString:self.placeholder]) {
        self.attributedText = nil;
        self.textColor = [UIColor colorWithRGBColor:self.yj_originalTextColor];
    }
}

- (void)setYj_originalTextColor:(RGBColor)yj_originalTextColor {
    objc_setAssociatedObject(self, @selector(yj_originalTextColor), @(yj_originalTextColor), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (RGBColor)yj_originalTextColor {
    return [objc_getAssociatedObject(self, _cmd) RGBColorValue];
}

@end
