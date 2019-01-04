//
//  SwitchButton.h
//  BaseProject
//
//  Created by 张熔冰 on 2018/12/10.
//  Copyright © 2018年 Lovcreate. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, SwitchType){
    SwitchTypeLogin = 0,
    SwitchTypeRegister
};

NS_ASSUME_NONNULL_BEGIN

@interface LoginSwitchButton : UIView

@property(nonatomic, strong) NSString *loginTitle;
@property(nonatomic, strong) NSString *registerTitle;
@property(nonatomic, strong) UIColor *loginColor;
@property(nonatomic, strong) UIColor *registerColor;

@property(nonatomic, strong) void(^selectedBlock)(SwitchType type);

@end

NS_ASSUME_NONNULL_END
