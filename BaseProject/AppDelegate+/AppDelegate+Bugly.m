//
//  AppDelegate+Bugly.m
//  BaseProject
//
//  Created by 张熔冰 on 2018/6/13.
//  Copyright © 2018年 lovcreate. All rights reserved.
//

#import "AppDelegate+Bugly.h"

@implementation AppDelegate (Bugly)

-(void)registerBugly{
    // 异常上报
    BuglyConfig *config = [[BuglyConfig alloc] init];
    config.debugMode = YES;
    config.blockMonitorEnable = YES;
    config.version = kApp_Version;
    config.delegate = self;
    config.reportLogLevel = BuglyLogLevelWarn;
    config.deviceIdentifier = @"deviceIdentifier";
    config.channel = @"channel";
    [Bugly startWithAppId:@"6aea5b9cf7" config:config];
}

#pragma mark - BuglyDelegate
- (NSString *)attachmentForException:(NSException *)exception {
    return @"发生了一些不愉快的事情";
}
@end
