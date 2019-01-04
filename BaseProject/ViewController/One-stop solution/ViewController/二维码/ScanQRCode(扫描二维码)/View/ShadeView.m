//
//  ShadeView.m
//  BaseProject
//
//  Created by 张熔冰 on 2018/10/22.
//  Copyright © 2018年 Lovcreate. All rights reserved.
//

#import "ShadeView.h"

#define kScanningLineMovingTime 3.f

@interface ShadeView()

@property(nonatomic, strong) UIView *lineView;

@end

@implementation ShadeView

-(instancetype)init{
    if (self = [super init]) {
        self.backgroundColor = [UIColor clearColor];
        self.opaque = NO;//设置透明
        self.contentMode = UIViewContentModeRedraw;
    }
    return self;
}
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        self.opaque = NO;//设置透明
        self.contentMode = UIViewContentModeRedraw;
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
}

-(void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    
    [self addClearRect:rect];
    [self addBorderWithRect:rect];
    NSValue *value = [NSValue valueWithCGRect:rect];
    [self performSelector:@selector(addScanningLine:) withObject:value afterDelay:3.f];
}

-(void)dealloc{
    
}
#pragma mark - Public
//加入背景
-(void)addClearRect:(CGRect)mainRect{
    CGFloat width = mainRect.size.width;
    CGFloat height = mainRect.size.height;
    [[UIColor colorWithWhite:0 alpha:0.6] setFill];
    UIRectFill(mainRect);
    CGFloat size = width/7.f;
    CGRect clearRect;
    clearRect = CGRectMake(size, height/2.f - 5*size/2, 5*size, 5*size);
    CGRect clearIntersection = CGRectIntersection(clearRect, mainRect);
    [[UIColor clearColor] setFill];
    UIRectFill(clearIntersection);
}
//加入四个角线
-(void)addBorderWithRect:(CGRect) mainRect{
    CGFloat width = mainRect.size.width;
    CGFloat height = mainRect.size.height;
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(ctx, 3);
    CGContextSetStrokeColorWithColor(ctx, [UIColor greenColor].CGColor);
    CGContextSetLineCap(ctx, kCGLineCapSquare);
    CGFloat size = width/7.f;
    CGPoint upLeftPoints[] = {CGPointMake(size, height/2.f - 5*size/2), CGPointMake(size + 20, height/2.f - 5*size/2), CGPointMake(size, height/2.f - 5*size/2), CGPointMake(size, height/2.f - 5*size/2 + 20)};
    CGPoint upRightPoints[] = {CGPointMake(6*size, height/2.f - 5*size/2), CGPointMake(6*size - 20, height/2.f - 5*size/2), CGPointMake(6*size, height/2.f - 5*size/2), CGPointMake(6*size, height/2.f - 5*size/2 + 20)};
    CGPoint belowLeftPoints[] = {CGPointMake(size, height/2 + 5*size/2.f), CGPointMake(size, height/2 + 5*size/2.f - 20), CGPointMake(size, height/2 + 5*size/2.f), CGPointMake(size + 20, height/2 + 5*size/2.f)};
    CGPoint belowRightPoints[] = {CGPointMake(6*size, height/2 + 5*size/2.f), CGPointMake(6*size, height/2 + 5*size/2.f - 20), CGPointMake(6*size, height/2 + 5*size/2.f), CGPointMake(6*size - 20.f, height/2 + 5*size/2.f)};
    CGContextStrokeLineSegments(ctx, upLeftPoints, 4);
    CGContextStrokeLineSegments(ctx, upRightPoints, 4);
    CGContextStrokeLineSegments(ctx, belowLeftPoints, 4);
    CGContextStrokeLineSegments(ctx, belowRightPoints, 4);
}

-(void)addScanningLine:(NSValue*)value{
    CGRect mainRect = [value CGRectValue];
    CGFloat width = mainRect.size.width;
    CGFloat height = mainRect.size.height;
    CGFloat size = width/7.f;
    if (self.lineView == nil) {
        self.lineView = [[UIView alloc] initWithFrame:CGRectMake(size, height/2 - 5*size/2.f, 5*size, 2)];
        CAGradientLayer *gradientLayer = [CAGradientLayer layer];
        gradientLayer.colors = @[(__bridge id)[UIColor clearColor].CGColor,
                                 (__bridge id)[UIColor greenColor].CGColor,
                                 (__bridge id)[UIColor clearColor].CGColor];
        gradientLayer.locations = @[@0.05f, @0.5f, @0.95f];
        gradientLayer.startPoint = CGPointMake(0, 0);
        gradientLayer.endPoint = CGPointMake(1.0, 0);
        gradientLayer.frame = self.lineView.bounds;
        [self.lineView.layer addSublayer:gradientLayer];
        [self addSubview:self.lineView];
        [self animateScanningLineWithSize:size height:height];
    }
}

#pragma mark - selector
-(void)animateScanningLineWithSize:(CGFloat)size height:(CGFloat)height{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position.y"];
    animation.fromValue = @(height/2 - 5*size/2.f);
    animation.toValue = @(height/2 - 5*size/2.f + 5*size);
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    animation.duration = kScanningLineMovingTime;
    animation.repeatCount = CGFLOAT_MAX;
    [self.lineView.layer addAnimation:animation forKey:nil];
}
@end
