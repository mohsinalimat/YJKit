//
//  YJGeometryViewController.m
//  YJKit
//
//  Created by huang-kun on 16/3/24.
//  Copyright © 2016年 huang-kun. All rights reserved.
//

#import "YJGeometryViewController.h"
#import "YJGeometryExtension.h"
#import "UIGestureRecognizer+YJBlockBased.h"
#import "YJObjcMacros.h"
#import "YJUIMacros.h"

@interface YJGeometryViewController ()
@property (nonatomic, strong) UILabel *label;
@property (nonatomic, strong) CALayer *frameLayer;
@property (nonatomic, strong) CALayer *staticLayer;
@property (nonatomic, assign) CGRect originalFrame;
@property (nonatomic, assign) CGRect targetFrame;
@end

@implementation YJGeometryViewController {
    BOOL _reset;
    BOOL _conflict;
}

- (void)dealloc {
    NSLog(@"%@ dealloc", self.class);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addGestures];
    
    self.staticLayer = [self frameLayerWithColor:[UIColor lightGrayColor].CGColor];
    self.frameLayer = [self frameLayerWithColor:[UIColor orangeColor].CGColor];
    [self.view.layer addSublayer:self.staticLayer];
    [self.view.layer addSublayer:self.frameLayer];
    self.label = [[UILabel alloc] init];
    self.label.center = [self labelCenter];
    [self.view addSubview:self.label];
}

- (CGPoint)layerCenter {
    return (CGPoint){ self.view.center.x, self.view.center.y - 80 };
}

- (CGPoint)labelCenter {
    return (CGPoint){ self.view.center.x, self.view.center.y + 80 };
}

#pragma mark - gestures

- (void)addGestures {
    // Add a hint description for introduction.
    UILabel *hint = [UILabel new];
    hint.numberOfLines = 0;
    hint.textColor = [UIColor lightGrayColor];
    hint.font = [UIFont systemFontOfSize:14.0f];
    hint.text = @"Single tap to change layout.\nLeft swipe to reset default layout.\nRight swipe to reset random layout.\nDouble finger single tap to switch \nbetween conflicts and normal situations.";
    [hint sizeToFit];
    hint.center = CGPointMake(self.view.center.x, 50.0f);
    [self.view addSubview:hint];
    
    // NOTICE:
    // Using _ivar directly will retain self inside of block!
    // MUST using strongify(self) with self->_ivar inside of block to avoid the implicit-self-capturing.
    @weakify(self)
    
    // Single tap to calculate layer frames
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithActionHandler:^(UIGestureRecognizer * _Nonnull gestureRecognizer) {
        @strongify(self)
        if (gestureRecognizer.state != UIGestureRecognizerStateRecognized) return;
        if (CGRectIsEmpty(self.frameLayer.bounds)) return;
        
        static int i = 0;
        if (self->_reset) i = 0;
        self->_reset = NO;
        
        NSArray *options = self->_conflict ? [self conflictOptions] : [self options];;
        NSArray *descriptions = self->_conflict ? [self conflictDescriptions] : [self descriptions];
        
        if (i == options.count) i = 0;
        
        CGRectPositionOptions option = [options[i] unsignedIntValue];
        CGRect inRect = CGRectPositioned(self.originalFrame, self.targetFrame, option);
        self.frameLayer.frame = inRect;
        
        self.label.text = self->_reset ? nil : descriptions[i];
        [self.label sizeToFit];
        self.label.center = [self labelCenter];
        
        i++;
    }];
    
    // Left swipe to reset default layout
    UISwipeGestureRecognizer *leftSwipe = [UISwipeGestureRecognizer new];
    leftSwipe.direction = UISwipeGestureRecognizerDirectionLeft;
    [leftSwipe setActionHandler:^(UIGestureRecognizer * _Nonnull gestureRecognizer) {
        @strongify(self)
        if (gestureRecognizer.state != UIGestureRecognizerStateRecognized) return;
        
        self->_reset = YES;
        static int i = 0;
        
        self.staticLayer.bounds = (CGRect){ CGPointZero, {100,100} };
        self.staticLayer.position = [self layerCenter];
        self.targetFrame = self.staticLayer.frame;
        
        self.originalFrame = i % 2 == 0 ? (CGRect){ 0, 0, 50, 200 } : (CGRect){ 0, 0, 200, 50 };
        self.frameLayer.frame = self.originalFrame;
        
        self.label.text = nil;
        
        i++;
    }];
    
    // Right swipe to reset random layout.
    UISwipeGestureRecognizer *rightSwipe = [UISwipeGestureRecognizer new];
    rightSwipe.direction = UISwipeGestureRecognizerDirectionRight;
    [rightSwipe setActionHandler:^(UIGestureRecognizer * _Nonnull gestureRecognizer) {
        @strongify(self)
        if (gestureRecognizer.state != UIGestureRecognizerStateRecognized) return;
        
        self->_reset = YES;
        CGRect bounds = CGRectInset(kUIScreenBounds, 20, 50);
        CGFloat w = bounds.size.width;
        CGFloat h = bounds.size.height;
        
        CGFloat (^random)(CGFloat) = ^(CGFloat value){
            return (CGFloat)arc4random_uniform((u_int32_t)value);
        };
        
        self.staticLayer.bounds = (CGRect){ CGPointZero, {random(w),random(h)} };
        self.staticLayer.position = [self layerCenter];
        self.targetFrame = self.staticLayer.frame;
        
        self.originalFrame = (CGRect){ random(w), random(h), random(w), random(h) };
        self.frameLayer.frame = self.originalFrame;
        
        self.label.text = nil;
    }];
    
    // Double finger single tap to switch between conflicts and normal situations.
    UITapGestureRecognizer *doubleTouches = [UITapGestureRecognizer new];
    doubleTouches.numberOfTouchesRequired = 2;
    [doubleTouches setActionHandler:^(UIGestureRecognizer * _Nonnull gestureRecognizer) {
        @strongify(self)
        if (gestureRecognizer.state != UIGestureRecognizerStateRecognized) return;
        self->_reset = YES;
        self->_conflict = !self->_conflict;
    }];
    
    [self.view addGestureRecognizer:singleTap];
    [self.view addGestureRecognizer:leftSwipe];
    [self.view addGestureRecognizer:rightSwipe];
    [self.view addGestureRecognizer:doubleTouches];
}

- (NSArray *)options {
    CGRectPositionOptions fit = CGRectScaleAspectFit;
    CGRectPositionOptions fill = CGRectScaleAspectFill;
    CGRectPositionOptions t = CGRectAlignTop;
    CGRectPositionOptions l = CGRectAlignLeft;
    CGRectPositionOptions b = CGRectAlignBottom;
    CGRectPositionOptions r = CGRectAlignRight;
    CGRectPositionOptions c = CGRectAlignCenter;
    return @[ @(c), @(fit), @(fill), @(t), @(l), @(b), @(r), @(t | l), @(t | r), @(b | l), @(b | r),
              @(fit | t), @(fit | l), @(fit | b), @(fit | r), @(fit | t | l), @(fit | t | r), @(fit | b | l), @(fit | b | r),
              @(fill | t), @(fill | l), @(fill | b), @(fill | r), @(fill | t | l), @(fill | t | r), @(fill | b | l), @(fill | b | r),
              ];
}

- (NSArray *)descriptions {
    return @[@"AlignCenter",
             @"ScaleAspectFit",
             @"ScaleAspectFill",
             @"AlignTop",
             @"AlignLeft",
             @"AlignBottom",
             @"AlignRight",
             @"(AlignTop | AlignLeft)",
             @"(AlignTop | AlignRight)",
             @"(AlignBottom | AlignLeft)",
             @"(AlignBottom | AlignRight)",
             @"(ScaleAspectFit | AlignTop)",
             @"(ScaleAspectFit | AlignLeft)",
             @"(ScaleAspectFit | AlignBottom)",
             @"(ScaleAspectFit | AlignRight)",
             @"(ScaleAspectFit | AlignTop | AlignLeft)",
             @"(ScaleAspectFit | AlignTop | AlignRight)",
             @"(ScaleAspectFit | AlignBottom | AlignLeft)",
             @"(ScaleAspectFit | AlignBottom | AlignRight)",
             @"(ScaleAspectFill | AlignTop)",
             @"(ScaleAspectFill | AlignLeft)",
             @"(ScaleAspectFill | AlignBottom)",
             @"(ScaleAspectFill | AlignRight)",
             @"(ScaleAspectFill | AlignTop | AlignLeft)",
             @"(ScaleAspectFill | AlignTop | AlignRight)",
             @"(ScaleAspectFill | AlignBottom | AlignLeft)",
             @"(ScaleAspectFill | AlignBottom | AlignRight)",
             ];
}

- (CALayer *)frameLayerWithColor:(CGColorRef)color {
    CALayer *frameLayer = [CALayer layer];
    frameLayer = [CAShapeLayer layer];
    frameLayer.borderWidth = 2.0f;
    frameLayer.borderColor = color;
    return frameLayer;
}

#pragma mark - conflicts

/* 
 * Priority from high to low - (ScaleAspectFit > ScaleAspectFill) > (Top > Left > Right > Bottom > Center).
 */

- (NSArray *)conflictOptions {
    CGRectPositionOptions fit = CGRectScaleAspectFit;
    CGRectPositionOptions fill = CGRectScaleAspectFill;
    CGRectPositionOptions t = CGRectAlignTop;
    CGRectPositionOptions l = CGRectAlignLeft;
    CGRectPositionOptions b = CGRectAlignBottom;
    CGRectPositionOptions r = CGRectAlignRight;
    CGRectPositionOptions c = CGRectAlignCenter;
    return @[@(fit | fill), @(t | b), @(l | r), @(t | c), @(t | l | r), @(t | c | r), @(b | l | r), @(t | r | b), @(t | l | b | r),
             @(fit | t | b), @(fit | r | l), @(fill | fit | t | b | r), @(fit | t | l | b | r)
             ];
}

- (NSArray *)conflictDescriptions {
    return @[@"(Fit | Fill)",
             @"(Top | Bottom)",
             @"(Left | Right)",
             @"(Top | Center)",
             @"(Top | Left | Right)",
             @"(Top | Center | Right)",
             @"(Bottom | Left | Right)",
             @"(Top | Right | Bottom)",
             @"(Top | Left | Bottom | Right)",
             @"(Fit | Top | Bottom)",
             @"(Fit | Right | Left)",
             @"(Fill | Fit | Top | Bottom | Right)",
             @"(Fit | Top | Left | Bottom | Right)",
             ];
}



@end
