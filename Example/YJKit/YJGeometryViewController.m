//
//  YJGeometryViewController.m
//  YJKit
//
//  Created by Jack Huang on 16/3/24.
//  Copyright © 2016年 Jack Huang. All rights reserved.
//

#import "YJGeometryViewController.h"
#import "CGGeometry_YJExtension.h"

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

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(calculateFrame)];
    UISwipeGestureRecognizer *leftSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(resetFrame)];
    leftSwipe.direction = UISwipeGestureRecognizerDirectionLeft;
    UISwipeGestureRecognizer *rightSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(resetRandomFrame)];
    rightSwipe.direction = UISwipeGestureRecognizerDirectionRight;
    UITapGestureRecognizer *doubleTouches = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(resetConflict)];
    doubleTouches.numberOfTouchesRequired = 2;
    [self.view addGestureRecognizer:singleTap];
    [self.view addGestureRecognizer:leftSwipe];
    [self.view addGestureRecognizer:rightSwipe];
    [self.view addGestureRecognizer:doubleTouches];
    
    self.staticLayer = [self frameLayerWithColor:[UIColor lightGrayColor].CGColor];
    self.frameLayer = [self frameLayerWithColor:[UIColor orangeColor].CGColor];
    
    [self.view.layer addSublayer:self.staticLayer];
    [self.view.layer addSublayer:self.frameLayer];
    
    self.label = [[UILabel alloc] init];
    self.label.center = (CGPoint){ self.view.center.x, self.view.center.y + 100 };
    [self.view addSubview:self.label];
    
    [self resetFrame];
}

- (void)calculateFrame {
    static int i = 0;
    if (_reset) i = 0;
    _reset = NO;

    NSArray *options = _conflict ? [self conflictOptions] : [self options];;
    NSArray *descriptions = _conflict ? [self conflictDescriptions] : [self descriptions];
    
    if (i == options.count) i = 0;
    
    CGRectPositionOptions option = [options[i] unsignedIntValue];
    CGRect inRect = CGRectPositioned(self.originalFrame, self.targetFrame, option);
    self.frameLayer.frame = inRect;
    
    self.label.text = _reset ? nil : descriptions[i];
    [self.label sizeToFit];
    self.label.center = (CGPoint){ self.view.center.x, self.view.center.y + 100 };
    
    i++;
}

- (void)resetFrame {
    _reset = YES;
    static int i = 0;
    
    self.staticLayer.bounds = (CGRect){ CGPointZero, {100,100} };
    self.staticLayer.position = self.view.center;
    self.targetFrame = self.staticLayer.frame;
    
    self.originalFrame = i % 2 == 0 ? (CGRect){ 0, 0, 50, 200 } : (CGRect){ 0, 0, 200, 50 };
    self.frameLayer.frame = self.originalFrame;
    
    self.label.text = nil;
    
    i++;
}

- (void)resetRandomFrame {
    _reset = YES;
    CGRect bounds = CGRectInset([UIScreen mainScreen].bounds, 20, 50);
    CGFloat w = bounds.size.width;
    CGFloat h = bounds.size.height;
    
    CGFloat (^random)(CGFloat) = ^(CGFloat value){
        return (CGFloat)arc4random_uniform((u_int32_t)value);
    };
    
    self.staticLayer.bounds = (CGRect){ CGPointZero, {random(w),random(h)} };
    self.staticLayer.position = self.view.center;
    self.targetFrame = self.staticLayer.frame;
    
    self.originalFrame = (CGRect){ random(w), random(h), random(w), random(h) };
    self.frameLayer.frame = self.originalFrame;
    
    self.label.text = nil;
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

- (void)resetConflict {
    _reset = YES;
    _conflict = !_conflict;
}

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
