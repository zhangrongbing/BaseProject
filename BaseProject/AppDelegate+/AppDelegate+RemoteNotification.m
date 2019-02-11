//
//  AppDelegate+RemoteNotification.m
//  BaseProject
//
//  Created by 张熔冰 on 2018/4/13.
//  Copyright © 2018年 lovcreate. All rights reserved.
//

#import "AppDelegate+RemoteNotification.h"
#import "AFNetworkReachabilityManager.h"
#import <CloudPushSDK/CloudPushSDK.h>
#import "PushManager.h"

#define kAppKey @"25236293"
#define kAppSecret @"ec5b26e5e5d15fb1ac15ddf9517fa1ea"

@implementation AppDelegate (RemoteNotification)

- (void)registerAPNS:(UIApplication *)application {

#ifdef __IPHONE_10_0
    if (@available(iOS 10, *)) {
        UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
        center.delegate = self;
        UNAuthorizationOptions options = UNAuthorizationOptionBadge|UNAuthorizationOptionSound | UNAuthorizationOptionAlert;
        [center requestAuthorizationWithOptions:options completionHandler:^(BOOL granted, NSError * _Nullable error) {
            DebugLog(@"granted = %@ error = %@", granted?@"yes":@"no", error);
        }];
        [application registerForRemoteNotifications];
    }
#elif __IPHONE_8_0
    [application registerUserNotificationSettings: [UIUserNotificationSettings settingsForTypes: (UIUserNotificationTypeSound | UIUserNotificationTypeAlert | UIUserNotificationTypeBadge) categories:nil]];
    [application registerForRemoteNotifications];
    DebugLog(@"");
#else
    [[UIApplication sharedApplication] registerForRemoteNotificationTypes:(UIRemoteNotificationTypeAlert|UIRemoteNotificationTypeBadge|UIRemoteNotificationTypeSound)];
    DebugLog(@"");
#endif
}

//官网返回的DeviceToken
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken{
    NSString* DeviceToken = [[deviceToken description] stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"<>"]];
    DeviceToken = [DeviceToken stringByReplacingOccurrencesOfString:@" " withString:@""];
    DebugLog(@"官方返回的DeviceToken=%@", DeviceToken);
    [self initCloudPush];
}
//离线通知注册失败
- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    DebugLog(@"离线通知注册失败:ERROR= %@", error);
}

//接收通知
#ifdef __IPHONE_10_0
- (void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions options))completionHandler API_AVAILABLE(ios(10.0)){//将要展示
    
    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]){//远程通知
        NSDictionary *userInfo = notification.request.content.userInfo;
        [[PushManager sharedInstance] didReceivePushData:userInfo];
    }else{//本地通知
        
    }
    completionHandler(UNNotificationPresentationOptionNone);
}

- (void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void(^)(void))completionHandler API_AVAILABLE(ios(10.0)){
    
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]){//远程通知
        NSDictionary *userInfo = response.notification.request.content.userInfo;
        [[PushManager sharedInstance] didReceivePushData:userInfo];
    }else{//本地通知
        
    }
    completionHandler();
    
}

#else
-(void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo{
    [[PushManager sharedInstance] didReceivePushData:userInfo];
    DebugLog(@"收到了离线通知");
}
#endif

//收到本地通知
- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification{
    
    DebugLog(@"收到了本地通知");
}
#pragma mark - Public
//发送本地通知
-(void)sendLocalNotification{
    if (@available(iOS 10.0, *)) {
        UNMutableNotificationContent *content = [[UNMutableNotificationContent alloc] init];
        content.title = @"title";
        content.subtitle = @"subTitle";
        content.body = @"body";
        content.sound = [UNNotificationSound defaultSound];

        UNTimeIntervalNotificationTrigger *trigger = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:3.f repeats:NO];

        NSString *notificationName = [NSString stringWithFormat:@"%@", @"foreground"];
        UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:notificationName content:content trigger:trigger];
        UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
        [center addNotificationRequest:request withCompletionHandler:^(NSError * _Nullable error) {
            if (error == nil) {
                DebugLog(@"发送推送成功");
            }
        }];
    } else{
        DebugLog(@"发送了通知");
        UILocalNotification *notification = [[UILocalNotification alloc] init];
        notification.alertBody = [NSString stringWithFormat:@"Agent-%d",arc4random()%100]; //通知主体
        notification.applicationIconBadgeNumber += 1;//应用程序图标右上角显示的消息数
        notification.alertAction = @"打开应用"; //待机界面的滑动动作提示
        notification.alertLaunchImage = @"Default";//通过点击通知打开应用时的启动图片,这里使用程序启动图片
        notification.soundName = UILocalNotificationDefaultSoundName;//收到通知时播放的声音，默认消息声音
        notification.userInfo = @{@"id": @1, @"user": @"cloudox"};//绑定到通知上的其他附加信息
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [[UIApplication sharedApplication] scheduleLocalNotification:notification];
        });
    }
}
//初始化阿里云推送
- (void)initCloudPush {
    [CloudPushSDK asyncInit:kAppKey appSecret:kAppSecret callback:^(CloudPushCallbackResult *res) {
        if (res.success) {
            DebugLog(@"阿里云初始化成功, deviceId: %@.", [CloudPushSDK getDeviceId]);
        } else {
            DebugLog(@"阿里云初始化失败, error: %@", res.error);
        }
    }];
}
@end
