//
//  AppDelegate+ADs.m
//  BaseProject
//
//  Created by Swift liu on 2018/11/1.
//  Copyright © 2018 Lovcreate. All rights reserved.
//

#import "AppDelegate+ADs.h"
#import "LCAdvertiseHelper.h"

@implementation AppDelegate (ADs)

- (void)showAds{
    NSArray <NSString *> *imagesURLS = @[@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1541052232345&di=3f235e58a68f15eb8f32a8bcaef20e58&imgtype=0&src=http%3A%2F%2Fimgsrc.baidu.com%2Fimgad%2Fpic%2Fitem%2Fe824b899a9014c080740b79f017b02087bf4f495.jpg",@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1541052303697&di=9640690f0fdd631c1de9252d2154e291&imgtype=0&src=http%3A%2F%2Fimg.zcool.cn%2Fcommunity%2F01094b57d625810000012e7e9a23d1.gif"];
    // 启动广告
    [LCAdvertiseHelper showAdvertiserView:imagesURLS];
}

@end
