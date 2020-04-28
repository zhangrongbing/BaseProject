//
//  AppDelegate.m
//  BaseProject
//
//  Created by 张熔冰 on 2018/6/20.
//  Copyright © 2018年 Lovcreate. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "BaseNavigationController.h"
#import "AppDelegate+RemoteNotification.h"
#import "Notificationhandler.h"
#import "Client.h"
#import "AppDelegate+IntroducePageViews.h"
#import "AppDelegate+ADs.h"
#import "AppDelegate+Bugly.h"
#import <AMapFoundationKit/AMapFoundationKit.h>

//@interface AppDelegate ()

@interface AppDelegate ()<UIApplicationDelegate>

//@property (strong, nonatomic) Notificationhandler *handler;
//@property (nonatomic, strong) YYFPSLabel *fpsLabel;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
    _window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    ViewController *controller = [[ViewController alloc] init];
    BaseNavigationController *nav = [[BaseNavigationController alloc] initWithRootViewController:controller];
    [Client sharedInstance].nav = nav;
    _window.rootViewController = nav;
    [_window makeKeyAndVisible];
    
#if TARGET_IPHONE_SIMULATOR
    
#else
    [self registerAPNS:application];
    [[AMapServices sharedServices] setEnableHTTPS:YES];
    [AMapServices sharedServices].apiKey = kMAP_KEY;
#endif

#if DEBUG
    [self registerBuglyForAppId:@"需要注册测试appid"];
#else
    [self registerBuglyForAppId:@"6aea5b9cf7"];
#endif
    [self configGlobalApperance];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {DebugLog(@"");}
- (void)applicationDidEnterBackground:(UIApplication *)application {DebugLog(@"");}
- (void)applicationWillEnterForeground:(UIApplication *)application {DebugLog(@"");}
- (void)applicationDidBecomeActive:(UIApplication *)application {DebugLog(@"");}
- (void)applicationWillTerminate:(UIApplication *)application {DebugLog(@"");}

-(void)configGlobalApperance{
    //APP样式
    [UITableView appearance].keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    [UITableView appearance].separatorColor = [UIColor tableViewSeparatorColor];
    
    [UITabBar appearance].translucent = NO;
}

@end
