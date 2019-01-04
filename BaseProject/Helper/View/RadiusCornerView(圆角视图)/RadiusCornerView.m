//
//  RadiusCornerView.m
//  BaseProject
//
//  Created by 张熔冰 on 2018/8/3.
//  Copyright © 2018年 Lovcreate. All rights reserved.
//

#import "RadiusCornerView.h"


@interface RadiusCornerView()

@property(nonatomic, assign) IBInspectable CGSize size;

@end

@implementation RadiusCornerView

-(void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:UIRectCornerAllCorners cornerRadii:self.size];
    CAShapeLayer *layer = [[CAShapeLayer alloc] init];
    layer.frame = rect;
    layer.path = path.CGPath;
    self.layer.mask = layer;
}

@end
