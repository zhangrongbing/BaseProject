//
//  AppDelegate+IntroducePageViews.m
//  BaseProject
//
//  Created by Swift liu on 2018/10/31.
//  Copyright © 2018 Lovcreate. All rights reserved.
//

#import "AppDelegate+IntroducePageViews.h"
#import "LCIntroduceHelper.h"

@implementation AppDelegate (IntroducePageViews)

- (void)showIntroduce{
    [LCIntroduceHelper showIntroductoryPage:@[@"intro_0.jpg", @"intro_1.jpg", @"intro_2.jpg", @"intro_3.jpg"]];
}

@end
