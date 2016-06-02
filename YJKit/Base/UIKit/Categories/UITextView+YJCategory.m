//
//  UITextView+YJCategory.m
//  YJKit
//
//  Created by huang-kun on 16/5/25.
//  Copyright © 2016年 huang-kun. All rights reserved.
//

#import <objc/runtime.h>
#import "UITextView+YJCategory.h"
#import "NSObject+YJRuntimeSwizzling.h"
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
        // exchange init
        [self swizzleInstanceMethodForSelector:@selector(initWithFrame:) toSelector:@selector(yj_textViewInitWithFrame:)];
        [self swizzleInstanceMethodForSelector:@selector(initWithCoder:) toSelector:@selector(yj_textViewInitWithCoder:)];
        // exchange dealloc
        [self swizzleInstanceMethodForSelector:NSSelectorFromString(@"dealloc") toSelector:@selector(yj_textViewDealloc)];
        // exchange life cycle
        [self swizzleInstanceMethodForSelector:@selector(layoutSubviews) toSelector:@selector(yj_textViewLayoutSubviews)];
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

- (void)setPlaceholderColor:(UIColor *)placeholderColor {
    objc_setAssociatedObject(self, YJTextViewAssociatedPlaceholderColorKey, placeholderColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIColor *)placeholderColor {
    UIColor *placeholderColor = objc_getAssociatedObject(self, YJTextViewAssociatedPlaceholderColorKey);
    if (!placeholderColor) placeholderColor = [UIColor lightGrayColor];
    return placeholderColor;
}

- (instancetype)yj_textViewInitWithFrame:(CGRect)frame {
    id textView = [self yj_textViewInitWithFrame:frame];
    [self yj_notificationObservingTextView:textView];
    return textView;
}

- (nullable instancetype)yj_textViewInitWithCoder:(NSCoder *)coder {
    id textView = [self yj_textViewInitWithCoder:coder];
    [self yj_notificationObservingTextView:textView];
    return textView;
}

- (void)yj_notificationObservingTextView:(UITextView *)textView {
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc addObserver:self selector:@selector(yj_beginTextEditing) name:UITextViewTextDidBeginEditingNotification object:textView];
    [nc addObserver:self selector:@selector(yj_endTextEditing) name:UITextViewTextDidEndEditingNotification object:textView];
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

#pragma mark - auto resign first responder

- (void)setAutoResignFirstResponder:(BOOL)autoResignFirstResponder {
    objc_setAssociatedObject(self, @selector(autoResignFirstResponder), @(autoResignFirstResponder), OBJC_ASSOCIATION_COPY_NONATOMIC);
    
    if (!autoResignFirstResponder) {
        [self yj_removeResignFirstResponderTapActionFromSuperview];
    }
}

- (BOOL)autoResignFirstResponder {
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}

- (void)yj_textViewLayoutSubviews {
    [self yj_textViewLayoutSubviews];
    
    if (self.autoResignFirstResponder) {
        NSArray *taps = [self.superview.gestureRecognizers arrayByFilteringWithCondition:^BOOL(__kindof UIGestureRecognizer * _Nonnull obj) {
            return [obj isKindOfClass:[UITapGestureRecognizer class]];
        }];
        
        if (!taps.count) {
            UITapGestureRecognizer *resignFirstResponderTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(yj_handleResignFirstResponderTap)];
            [self.superview addGestureRecognizer:resignFirstResponderTap];
        } else {
            UITapGestureRecognizer *tap = taps.lastObject;
            [tap removeTarget:self action:@selector(yj_handleResignFirstResponderTap)];
            [tap addTarget:self action:@selector(yj_handleResignFirstResponderTap)];
        }
    }
}

- (void)yj_textViewRemoveFromSuperview {
    if (self.autoResignFirstResponder) {
        [self yj_removeResignFirstResponderTapActionFromSuperview];
    }
    [self yj_textViewRemoveFromSuperview];
}

- (void)yj_removeResignFirstResponderTapActionFromSuperview {
    for (UIGestureRecognizer *gesture in self.superview.gestureRecognizers) {
        if ([gesture isKindOfClass:[UITapGestureRecognizer class]]) {
            [gesture removeTarget:self action:@selector(yj_handleResignFirstResponderTap)];
        }
    }
}

- (void)yj_handleResignFirstResponderTap {
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

- (NSAttributedString *)_attributedPlaceholder:(NSString *)placeholder {
    NSDictionary *attributes = @{ NSForegroundColorAttributeName : self.placeholderColor,
                                  NSFontAttributeName : self.font };
    return [[NSAttributedString alloc] initWithString:placeholder attributes:attributes];
}

- (void)setYj_originalTextColor:(RGBColor)yj_originalTextColor {
    objc_setAssociatedObject(self, @selector(yj_originalTextColor), @(yj_originalTextColor), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (RGBColor)yj_originalTextColor {
    return [objc_getAssociatedObject(self, _cmd) RGBColorValue];
}

@end
