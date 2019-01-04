//
//  ToastManager.m
//  BaseProject
//
//  Created by 张熔冰 on 2018/3/23.
//  Copyright © 2018年 lovcreate. All rights reserved.
//

#import "ToastManager.h"
#import "MBProgressHUD.h"

@interface ToastManager()

@property(nonatomic, strong) MBProgressHUD *hud;

@end

@implementation ToastManager

LC_SINGLE_M(ToastManager);



-(void)showMessage:(NSString*)message, ...NS_FORMAT_FUNCTION(1,2){
    va_list args;
    va_start(args, message);
    NSString *msg = [[NSString alloc] initWithFormat:message arguments:args];
    va_end(args);
    [self showMessage:msg delay:1.5f];
}

-(void)showMessage:(NSString*)message delay:(float)delay{
    if (self.hud) {
        [self.hud hideAnimated:NO];
    }
    UIApplication* application = [UIApplication sharedApplication];
    [application.keyWindow endEditing:YES];//收键盘
    //把之前的隐藏
    MBProgressHUD* toastHud = [[MBProgressHUD alloc] initWithView:application.keyWindow];
    [application.keyWindow addSubview:toastHud];
    toastHud.removeFromSuperViewOnHide = YES;
    toastHud.mode = MBProgressHUDModeText;
    toastHud.detailsLabel.text = message;
    toastHud.detailsLabel.font = [UIFont systemFontOfSize:12.f];
    toastHud.offset = CGPointMake(0, MBProgressMaxOffset);
    toastHud.bezelView.color = [[UIColor blackColor] colorWithAlphaComponent:.8];
    toastHud.detailsLabel.textColor = [UIColor whiteColor];
    [toastHud showAnimated:YES];
    [toastHud hideAnimated:YES afterDelay:delay];
    toastHud.userInteractionEnabled = NO;
    self.hud = toastHud;
}
@end
