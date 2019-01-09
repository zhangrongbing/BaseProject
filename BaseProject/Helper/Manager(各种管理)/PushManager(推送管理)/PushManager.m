//
//  PushManager.m
//  BaseProject
//
//  Created by 张熔冰 on 2019/1/9.
//  Copyright © 2019年 Lovcreate. All rights reserved.
//

#import "PushManager.h"

@implementation PushManager

SINGLE_M(PushManager);

-(void)didReceivePushData:(NSDictionary*)userInfo{
    NSString* alert = [[userInfo objectForKey:@"aps"] objectForKey:@"alert"];
    NSString* badge = [[userInfo objectForKey:@"aps"] objectForKey:@"badge"];
    [UIApplication sharedApplication].applicationIconBadgeNumber = [badge intValue];
    
    DebugLog(@"alert = %@, badge = %@", alert, badge);
}

-(void)didReceiveMessageData:(NSString*)data{
    
}
@end
