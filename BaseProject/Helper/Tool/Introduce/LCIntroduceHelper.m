//
//  LCIntroduceHelper.m
//  BaseProject
//
//  Created by Swift liu on 2018/10/31.
//  Copyright © 2018 Lovcreate. All rights reserved.
//

#import "LCIntroduceHelper.h"
#import "LCIntroductoryPagesView.h"

@interface LCIntroduceHelper ()

@property (weak, nonatomic) UIWindow *curWindow;

@property (strong, nonatomic) LCIntroductoryPagesView *curIntroductoryPagesView;

@end

@implementation LCIntroduceHelper

LC_SINGLE_M(LCIntroduceHelper);

#define kScreenWidth UIScreen.mainScreen.bounds.size.width
#define kScreenHeight UIScreen.mainScreen.bounds.size.height

+ (void)showIntroductoryPage:(NSArray<NSString *> *)imageAry{
    if (![LCIntroduceHelper sharedInstance].curIntroductoryPagesView) {
        [LCIntroduceHelper sharedInstance].curIntroductoryPagesView = [LCIntroductoryPagesView pagesWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) withImages:imageAry];
    }
    
    [LCIntroduceHelper sharedInstance].curWindow = [UIApplication sharedApplication].keyWindow;
    [[LCIntroduceHelper sharedInstance].curWindow addSubview:[LCIntroduceHelper sharedInstance].curIntroductoryPagesView];
    
}

@end
