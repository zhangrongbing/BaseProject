//
//  AppDelegate+Bugly.m
//  BaseProject
//
//  Created by 张熔冰 on 2018/6/13.
//  Copyright © 2018年 lovcreate. All rights reserved.
//

#import "AppDelegate+Bugly.h"
#import "UIDevice+Addition.h"

@implementation AppDelegate (Bugly)

-(void)registerBuglyForAppId:(NSString*) appId{
    NSString *uuid = [UIDevice currentDevice].identifierForVendor.UUIDString;
    // 异常上报
    BuglyConfig *config = [[BuglyConfig alloc] init];
#if DEBUG
    config.debugMode = YES;
#else
#endif
    config.blockMonitorEnable = YES;
    config.version = kApp_Version;
    config.delegate = self;
    config.reportLogLevel = BuglyLogLevelWarn;
    config.deviceIdentifier = uuid;
    config.channel = [NSString stringWithFormat:@"%@-%@",@"channel", uuid];
    [Bugly startWithAppId:appId config:config];
}

#pragma mark - BuglyDelegate
- (NSString *)attachmentForException:(NSException *)exception {
    return @"发生了一些不愉快的事情";
}
@end
