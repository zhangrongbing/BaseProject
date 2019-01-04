//
//  AppDelegate+Bugly.h
//  BaseProject
//
//  Created by 张熔冰 on 2018/6/13.
//  Copyright © 2018年 lovcreate. All rights reserved.
//

#import "AppDelegate.h"
#import <Bugly/Bugly.h>

@interface AppDelegate (Bugly)<BuglyDelegate>

-(void)registerBugly;
@end
