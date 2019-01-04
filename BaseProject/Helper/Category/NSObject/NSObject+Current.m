//
//  NSObject+Current.m
//  OrderCar-Driver
//
//  Created by 伯明利 on 2017/7/25.
//  Copyright © 2017年 lovcreate. All rights reserved.
//

#import "NSObject+Current.h"

@implementation NSObject (Current)

+ (UIViewController *)lc_getCurrentVC {
    UIViewController *result = nil;
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    //app默认windowLevel是UIWindowLevelNormal，如果不是，找到UIWindowLevelNormal的
    if (window.windowLevel != UIWindowLevelNormal)
    {
        
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows)
        {
            if (tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    id  nextResponder = nil;
    UIViewController *appRootVC=window.rootViewController;
    //    如果是present上来的appRootVC.presentedViewController 不为nil
    if (appRootVC.presentedViewController) {
        nextResponder = appRootVC.presentedViewController;
    }else{
        UIView *frontView = [[window subviews] objectAtIndex:0];
        nextResponder = [frontView nextResponder];
    }
    
    if ([nextResponder isKindOfClass:[UITabBarController class]]){
        UITabBarController * tabbar = (UITabBarController *)nextResponder;
        UINavigationController * nav = (UINavigationController *)tabbar.viewControllers[tabbar.selectedIndex];
        //        UINavigationController * nav = tabbar.selectedViewController ; 上下两种写法都行
        result=nav.childViewControllers.lastObject;
        
    }else if ([nextResponder isKindOfClass:[UINavigationController class]]){
        UIViewController * nav = (UIViewController *)nextResponder;
        result = nav.childViewControllers.lastObject;
    }else{
        result = nextResponder;
    }
    
    return result;
}

//获取当前键盘
+ (UIView *)lc_findKeyboard {
    
    UIView *keyboardView = nil;
    
    NSArray *windows = [[UIApplication sharedApplication] windows];
    
    //逆序效率更高，因为键盘总在上方
    
    for (UIWindow *window in [windows reverseObjectEnumerator]) {
        
        keyboardView = [NSObject findKeyboardInView:window];
        
        if (keyboardView) {
            
            return keyboardView;
            
        }
        
    }
    
    return nil;
    
}

+ (UIView *)findKeyboardInView:(UIView *)view {
    
    for (UIView *subView in [view subviews]) {
        
        if (strstr(object_getClassName(subView), "UIKeyboard")) {
            
            return subView;
            
        }
        
        else {
            
            UIView *tempView = [NSObject findKeyboardInView:subView];
            
            if (tempView) {
                
                return tempView;
                
            }
            
        }
        
    }
    
    return nil;
}

@end
