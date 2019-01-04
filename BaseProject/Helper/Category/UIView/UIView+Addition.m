//
//  UIView+Addition.m
//  BaseProject
//
//  Created by zhangrongbing on 2016/10/12.
//  Copyright © 2016年 lovcreate. All rights reserved.
//

#import "UIView+Addition.h"
#import "AppDelegate.h"

@implementation UIView (Addition)

-(void)setLc_x:(CGFloat)lc_x{
    CGRect frame = self.frame;
    frame.origin.x = lc_x;
    self.frame = frame;
}

-(CGFloat)lc_x{
    return self.frame.origin.x;
}

-(void)setLc_y:(CGFloat)lc_y{
    CGRect frame = self.frame;
    frame.origin.y = lc_y;
    self.frame = frame;
}

-(CGFloat)lc_y{
    return self.frame.origin.y;
}

-(void)setLc_w:(CGFloat)lc_w{
    CGRect frame = self.frame;
    frame.size.width = lc_w;
    self.frame = frame;
}

-(CGFloat)lc_w{
    return self.frame.size.width;
}

-(void)setLc_h:(CGFloat)lc_h{
    CGRect frame = self.frame;
    frame.size.height = lc_h;
    self.frame = frame;
}

-(CGFloat)lc_h{
    return self.frame.size.height;
}

-(void)setLc_size:(CGSize)lc_size{
    CGRect frame = self.frame;
    frame.size = lc_size;
    self.frame = frame;
}

-(CGSize)lc_size{
    return self.frame.size;
}

-(void)setLc_origin:(CGPoint)lc_origin{
    CGRect frame = self.frame;
    frame.origin = lc_origin;
    self.frame = frame;
}

-(CGPoint)lc_origin{
    return self.frame.origin;
}

-(CGPoint)lc_center{
    return self.center;
}

-(void)setLc_b:(CGFloat)lc_b{
    CGRect frame = self.frame;
    frame.origin.y = lc_b - frame.size.height;
    self.frame = frame;
}

-(CGFloat)lc_b{
    CGRect frame = self.frame;
    return frame.origin.y + frame.size.height;
}

-(void)setLc_center:(CGPoint)lc_center{
    CGPoint point = self.center;
    point.x = lc_center.x;
    point.y = lc_center.y;
    self.center = point;
}

-(CGFloat)lc_r{
    return self.lc_x + self.lc_w;
}

-(void)setLc_r:(CGFloat)lc_r{
    CGRect frame = self.frame;
    frame.origin.x = lc_r - frame.size.width;
    self.frame = frame;
}

-(void)lc_setCornerRadius:(CGFloat)radius{
    [self.layer setMasksToBounds:YES];
    [self.layer setCornerRadius:radius];
}

-(void)lc_setCornerRadius:(CGFloat)corner roundingCorners:(UIRectCorner)roundingCorners{
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:roundingCorners cornerRadii:CGSizeMake(corner, corner)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.bounds;
    maskLayer.path = maskPath.CGPath;
    self.layer.mask = maskLayer;
}


-(NSArray*)lc_allSubviewsForView:(UIView*)view{
    NSMutableArray *subViews = @[].mutableCopy;
    [view.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj.subviews.count > 0) {
            [self lc_allSubviewsForView:obj];
        }
        [subViews addObject:obj];
    }];
    return subViews;
}
@end

//animationWithKeyPath的值：
// path
//　 transform.scale = 比例轉換
//
//transform.scale.x = 闊的比例轉換
//
//transform.scale.y = 高的比例轉換
//
//transform.rotation.z = 平面圖的旋轉
//
//opacity = 透明度
//
//margin
//
//zPosition
//
//backgroundColor    背景颜色
//
//cornerRadius    圆角
//
//borderWidth
//
//bounds
//
//contents
//
//contentsRect
//
//cornerRadius
//
//frame
//
//hidden
//
//mask
//
//masksToBounds
//
//opacity
//
//position
//
//shadowColor
//
//shadowOffset
//
//shadowOpacity
//
//shadowRadius
