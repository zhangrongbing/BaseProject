//
//  AppDelegate+Shortcut.m
//  BaseProject
//
//  Created by 张熔冰 on 2019/1/10.
//  Copyright © 2019年 Lovcreate. All rights reserved.
//

#import "AppDelegate+Shortcut.h"
#import "ShortcutManager.h"

@implementation AppDelegate (Shortcut)

#ifdef __IPHONE_9_0
- (void)application:(UIApplication *)application performActionForShortcutItem:(UIApplicationShortcutItem *)shortcutItem completionHandler:(void (^)(BOOL))completionHandler {
    completionHandler([[ShortcutManager sharedInstance] selectShortCutItem:shortcutItem]);
}

#endif

@end
