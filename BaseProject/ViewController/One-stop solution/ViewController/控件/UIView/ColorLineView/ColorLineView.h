//
//  ColorLineView.h
//  AnimationDemo
//
//  Created by 张熔冰 on 2018/9/28.
//  Copyright © 2018年 Lovcreate. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, ColorLineStatus){
    ColorLineNormal = 0,
    ColorLineEnable,
    ColorLineUnable
};

NS_ASSUME_NONNULL_BEGIN

@interface ColorLineView : UIView

@property(nonatomic, assign) ColorLineStatus status;

@property(nonatomic, strong) UIColor* normalColor;
@property(nonatomic, strong) UIColor* enableColor;
@property(nonatomic, strong) UIColor* unableColor;

@end

NS_ASSUME_NONNULL_END
