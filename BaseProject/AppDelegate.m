//
//  AppDelegate.m
//  BaseProject
//
//  Created by 张熔冰 on 2018/6/20.
//  Copyright © 2018年 Lovcreate. All rights reserved.
//

#import "AppDelegate.h"
#import "MyConfig.h"
#import "ViewController.h"
#import "BaseNavigationController.h"
#import "AppDelegate+RemoteNotification.h"
#import "Notificationhandler.h"
#import "YYFPSLabel.h"
#import "AppDelegate+IntroducePageViews.h"
#import "AppDelegate+ADs.h"
#import "AppDelegate+Bugly.h"

//@interface AppDelegate ()

@interface AppDelegate ()<UIApplicationDelegate>

//@property (strong, nonatomic) Notificationhandler *handler;
//@property (nonatomic, strong) YYFPSLabel *fpsLabel;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    //配置全局变量
    MyConfig* config = [MyConfig sharedInstance];
    [config configGlobalApperance];
    
    _window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    ViewController* controller = [[ViewController alloc] init];
    BaseNavigationController *nav = [[BaseNavigationController alloc] initWithRootViewController:controller];
    _window.rootViewController = nav;
    [_window makeKeyAndVisible];
    
#if TARGET_IPHONE_SIMULATOR
    
#else
    [self registerBugly];
    [self registerAPNS:application];
#endif
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {DebugLog(@"");}
- (void)applicationDidEnterBackground:(UIApplication *)application {DebugLog(@"");}
- (void)applicationWillEnterForeground:(UIApplication *)application {DebugLog(@"");}
- (void)applicationDidBecomeActive:(UIApplication *)application {DebugLog(@"");}
- (void)applicationWillTerminate:(UIApplication *)application {DebugLog(@"");}
@end
