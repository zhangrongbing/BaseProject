//
//  Notificationhandler.m
//  BaseProject
//
//  Created by Swift liu on 2018/10/29.
//  Copyright © 2018 Lovcreate. All rights reserved.
//

#import "Notificationhandler.h"

@implementation Notificationhandler

- (void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler API_AVAILABLE(ios(10.0)){
    
    NSString *identifier = notification.request.identifier;
    UNNotificationPresentationOptions options = options = UNNotificationPresentationOptionNone; //默认什么也不做，不显示
    if (identifier == nil) {
        completionHandler(options);
        return;
    }
    // timeInterVal设置为前台可以显示
    if ([identifier isEqualToString:@"foreground"]) {
        options = UNNotificationPresentationOptionSound | UNNotificationPresentationOptionAlert;
    }else {
        options = UNNotificationPresentationOptionNone;
    }
    //设置完成之后必须调用这个回调，否则设置的options无效
    completionHandler(options);
}

- (void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)(void))completionHandler API_AVAILABLE(ios(10.0)){
    NSString *identifier = response.notification.request.identifier;//
    if ([identifier isEqualToString:@"foreground"]) {
        DebugLog(@"点击通知--ios(10.0)");
    }
    completionHandler();
}




@end
