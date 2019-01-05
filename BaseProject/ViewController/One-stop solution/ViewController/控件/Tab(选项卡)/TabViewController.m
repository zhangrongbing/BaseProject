//
//  TabViewController.m
//  BaseProject
//
//  Created by 张熔冰 on 2018/8/6.
//  Copyright © 2018年 Lovcreate. All rights reserved.
//

#import "TabViewController.h"
#import "SegmentControl.h"
#import "UIColor+Addition.h"

@interface TabViewController ()<SegmentControlDataSource, SegmentControlDelegate>

@property(nonatomic, strong) SegmentControl *semgentControl;
@property(nonatomic, strong) NSArray *titles1;
@property(nonatomic, strong) NSArray *titles2;
@property(nonatomic, strong) NSArray *titles3;

@end

@implementation TabViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titles1 = @[@"代付款", @"待发货", @"待收货"];
    self.titles3 = @[@"关注", @"长春", @"热点", @"小说", @"视频", @"军事", @"头条号", @"科技", @"财经",@"国际"];
//    self.semgentControl = [[SegmentControl alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, 45.f) menuStyle:SegmentControlStylePlain defaultIndex:1];
//    self.semgentControl.menuDelegate = self;
//    self.semgentControl.menuDataSource = self;
    [self.view addSubview:self.semgentControl];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"换位置" style:UIBarButtonItemStylePlain target:self action:@selector(pressRightItem:)];
    self.navigationItem.rightBarButtonItem = rightItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - SliderTabMenuViewDataSource

-(NSInteger)numberOfTitleInSegmentControl{
    return self.titles3.count;
}

-(NSString*)segmentControl:(SegmentControl *)view titleForIndex:(NSInteger)index{
    NSString *title = [self.titles3 objectAtIndex:index];
    return title;
}

#pragma mark - SliderTabMenuViewDelegate
-(void)sliderTabMenuView:(SegmentControl*)view didSelectedForIndex:(NSInteger)index{
    [[ToastManager sharedInstance] showMessage:@"选择了%li", (long)index];
}

#pragma mark - Action
-(void)pressRightItem:(UIBarButtonItem*)item{
    NSInteger index = arc4random()% self.titles3.count;
    [self.semgentControl moveToIndex:index];
}

@end
