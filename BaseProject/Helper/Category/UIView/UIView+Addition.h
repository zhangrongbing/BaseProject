//
//  UIView+Addition.h
//  BaseProject
//
//  Created by zhangrongbing on 2016/10/12.
//  Copyright © 2016年 lovcreate. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <objc/runtime.h>

#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

#define kStatusBarHeight [[UIApplication sharedApplication] statusBarFrame].size.height
#define kNavBarHeight 44.0
#define kSafeTop (kStatusBarHeight + kNavBarHeight)

@interface UIView (Addition)

@property (nonatomic, assign) CGFloat left;
@property (nonatomic, assign) CGFloat right;
@property (nonatomic, assign) CGFloat top;
@property (nonatomic, assign) CGFloat bottom;

@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;

@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;

@property (nonatomic, assign, readonly) CGPoint boundsCenter;
@property (nonatomic, assign, readonly) CGFloat boundsCenterX;
@property (nonatomic, assign, readonly) CGFloat boundsCenterY;

@property (nonatomic, assign) CGPoint   origin;
@property (nonatomic, assign) CGSize    size;

@property (assign, nonatomic, readonly) CGRect safeTop_bounds;

-(void)_setCornerRadius:(CGFloat)radius;
-(void)_setCornerRadius:(CGFloat)corner roundingCorners:(UIRectCorner)roundingCorners;
-(NSArray*)_allSubviewsForView:(UIView*)view;
-(void)_dismissKeyboardForTap;//点击view，键盘消失。
@end
