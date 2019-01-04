//
//  NSObject+Current.h
//  OrderCar-Driver
//
//  Created by 伯明利 on 2017/7/25.
//  Copyright © 2017年 lovcreate. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSObject (Current)

/**
 获取当前容器
 */
+ (UIViewController *)lc_getCurrentVC;

/**
 获取当前键盘
 */
+ (UIView *)lc_findKeyboard;
@end
