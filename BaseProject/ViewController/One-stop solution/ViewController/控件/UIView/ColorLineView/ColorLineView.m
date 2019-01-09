//
//  ColorLineView.m
//  AnimationDemo
//
//  Created by 张熔冰 on 2018/9/28.
//  Copyright © 2018年 Lovcreate. All rights reserved.
//

#import "ColorLineView.h"

#define kNormalColorKey @"NormalColorKey"
#define kEnableColorKey @"EnableColorKey"
#define kUnableColorKey @"UnableColorKey"

@interface ColorLineView()<CAAnimationDelegate>

@property(nonatomic, strong) CAShapeLayer *aniLayer;

@end

@implementation ColorLineView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]) {
        [self setupUI];
    }
    return self;
}

#pragma mark - CAAnimationDelegate
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    DebugLog(@"layers = %@",self.layer.sublayers);
}

#pragma mark - Public
-(void)setupUI{
    self.normalColor = [UIColor orangeColor];
    self.enableColor = [UIColor greenColor];
    self.unableColor = [UIColor redColor];
    
    self.aniLayer = [CAShapeLayer layer];
}

-(void)configureShapeLayer:(CAShapeLayer *)aniLayer withStatus:(ColorLineStatus) status{
    CGColorRef fillColor = nil;
    if(status == ColorLineNormal){
        fillColor = self.normalColor.CGColor;
    }else if (status == ColorLineUnable) {
        fillColor = self.unableColor.CGColor;
    }else if(status == ColorLineEnable){
        fillColor = self.enableColor.CGColor;
    }
    aniLayer.frame = self.bounds;
    aniLayer.backgroundColor = fillColor;
    [self.layer addSublayer:aniLayer];
    [self addAnimationForShapeLayer:aniLayer];
}

//画线
-(void)addAnimationForShapeLayer:(CAShapeLayer*)layer{
    
    CABasicAnimation *widthAni = [CABasicAnimation animationWithKeyPath:@"bounds.size.width"];
    widthAni.fromValue = @(0);
    widthAni.toValue = @(CGRectGetWidth(self.bounds));
    widthAni.duration = .3f;
    
    CAKeyframeAnimation *cornerRadiusAni = [CAKeyframeAnimation animationWithKeyPath:@"cornerRadius"];
    cornerRadiusAni.values = @[@(0.f), @(CGRectGetHeight(self.bounds)/2.f), @(0.f)];
    cornerRadiusAni.duration = .3f;
    
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.delegate = self;
    group.animations = @[widthAni, cornerRadiusAni];
    group.duration = .3f;
    group.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    [layer addAnimation:group forKey:@"GroupKey"];
}

#pragma mark - Getter and Setter
-(void)setStatus:(ColorLineStatus)status{
    if (_status == status) {
        return;
    }
    _status = status;
    
    [self.aniLayer removeAllAnimations];
    [self configureShapeLayer:self.aniLayer withStatus:status];
}
@end

