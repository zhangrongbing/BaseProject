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
+ (UIViewController *)_getCurrentVC;

/**
 获取当前键盘
 */
+ (UIView *)_findKeyboard;
@end
