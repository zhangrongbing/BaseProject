//
//  CycleViewController.m
//  BaseProject
//
//  Created by 张熔冰 on 2018/8/15.
//  Copyright © 2018年 Lovcreate. All rights reserved.
//

#import "CycleViewController.h"
#import <SDCycleScrollView/SDCycleScrollView.h>

@interface CycleViewController ()<SDCycleScrollViewDelegate>

@property(nonatomic, strong) SDCycleScrollView *cycleView;

@end

@implementation CycleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.cycleView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Getter and Setter
-(SDCycleScrollView*)cycleView{
    if (!_cycleView) {
        _cycleView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 64, kScreenWidth, 260.f) delegate:self placeholderImage:nil];
        _cycleView.imageURLStringsGroup = @[
                                            @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1534306258186&di=5faa2ef44ae4c6b45e6ec526785f37f7&imgtype=0&src=http%3A%2F%2Fwww.qqma.com%2Fimgpic2%2Fcpimagenew%2F2018%2F4%2F5%2F6e1de60ce43d4bf4b9671d7661024e7a.jpg",
                                            @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1534306258186&di=71d9ff6c8deb2d5f2421d9e04a72f2f0&imgtype=0&src=http%3A%2F%2Fimg.zcool.cn%2Fcommunity%2F011a5859ac137ea8012028a92fc78a.jpg%401280w_1l_2o_100sh.jpg",
                                            @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1534306258186&di=4532ff096798534e33e2ccb978f92747&imgtype=0&src=http%3A%2F%2Fimg.zcool.cn%2Fcommunity%2F01b34f58eee017a8012049efcfaf50.jpg%401280w_1l_2o_100sh.jpg"];
    }
    return _cycleView;
}
                      
#pragma mark - SDCycleScrollViewDelegate
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    [[ToastManager sharedInstance] showMessage:@"点击了第%li个",(long)index];
}

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didScrollToIndex:(NSInteger)index{
    DebugLog(@"当前滚动到第%ld个",(long)index);
}
@end
