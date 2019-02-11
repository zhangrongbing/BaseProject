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

- (CGFloat)left{
    return self.frame.origin.x;
}

- (void)setLeft:(CGFloat)left{
    CGRect frame = self.frame;
    frame.origin.x = left;
    self.frame = frame;
}

- (CGFloat)right{
    return CGRectGetMaxX(self.frame);
}

-(void)setRight:(CGFloat)right{
    CGRect frame = self.frame;
    frame.origin.x = right - frame.size.width;
    self.frame = frame;
}

- (CGFloat)top{
    return self.frame.origin.y;
}

- (void)setTop:(CGFloat)top{
    CGRect frame = self.frame;
    frame.origin.y = top;
    self.frame = frame;
}

- (CGFloat)bottom{
    return CGRectGetMaxY(self.frame);
}

- (void)setBottom:(CGFloat)bottom{
    CGRect frame = self.frame;
    frame.origin.y = bottom - frame.size.height;
    self.frame = frame;
}

- (CGFloat)width{
    return self.frame.size.width;
}

- (void)setWidth:(CGFloat)width{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (CGFloat)height{
    return self.frame.size.height;
}

- (void)setHeight:(CGFloat)height{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGFloat)centerX{
    return self.center.x;
}

- (void)setCenterX:(CGFloat)centerX{
    CGPoint pt = self.center;
    pt.x = centerX;
    self.center = pt;
}

- (CGFloat)centerY{
    return self.center.y;
}

- (void)setCenterY:(CGFloat)centerY{
    CGPoint pt = self.center;
    pt.y = centerY;
    self.center = pt;
}

- (CGPoint)boundsCenter{
    return CGPointMake(self.width / 2.f, self.height / 2.f);
}

- (CGFloat)boundsCenterX{
    return self.width / 2.f;
}

- (CGFloat)boundsCenterY{
    return self.height / 2.f;
}

- (CGPoint)origin{
    return self.frame.origin;
}

- (void)setOrigin:(CGPoint)origin{
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

- (CGSize)size{
    return self.frame.size;
}

- (void)setSize:(CGSize)size{
    CGRect frame = self.frame;
    frame.size = size;
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

-(CGRect)safeTop_bounds{
    if (@available(iOS 11, *)) {
        CGRect rect = self.bounds;
        rect.size = CGSizeMake(rect.size.width, rect.size.height - kSafeTop);
    }
    return self.bounds;
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
