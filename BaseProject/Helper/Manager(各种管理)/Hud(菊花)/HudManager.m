//
//  HudManager.m
//  BaseProject
//
//  Created by 张熔冰 on 2018/4/13.
//  Copyright © 2018年 lovcreate. All rights reserved.
//

#import "HudManager.h"

@interface HudManager()

@property(nonatomic, strong)MBProgressHUD* hud;

@end

@implementation HudManager
SINGLE_M(HudManager);

-(instancetype)init{
    if (self = [super init]) {
        UIView* view = [UIApplication sharedApplication].keyWindow;
        self.hud = [[MBProgressHUD alloc] initWithView:view];
        self.hud.removeFromSuperViewOnHide = YES;
        self.hud.userInteractionEnabled = YES;
        [view addSubview:self.hud];
    }
    return self;
}

-(void)showHud:(BOOL)animated{
    if (!self.hud.superview) {
        UIView* view = [UIApplication sharedApplication].keyWindow;
        [view addSubview:self.hud];
    }
    [self.hud showAnimated:animated];
}

-(void)hide:(BOOL)animated{
    [self.hud hideAnimated:animated];
}
@end
