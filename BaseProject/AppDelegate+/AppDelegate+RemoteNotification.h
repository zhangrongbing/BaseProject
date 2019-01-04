//
//  AppDelegate+RemoteNotification.h
//  BaseProject
//
//  Created by 张熔冰 on 2018/4/13.
//  Copyright © 2018年 lovcreate. All rights reserved.
//

#import "AppDelegate.h"
#import "NSObject+Addition.h"
#import <UserNotifications/UserNotifications.h>

@interface AppDelegate (RemoteNotification)<UNUserNotificationCenterDelegate>

//注册苹果推送，获取deviceToken用于推送
- (void)registerAPNS:(UIApplication *)application;
//发送本地通知
-(void)sendLocalNotification;
@end
