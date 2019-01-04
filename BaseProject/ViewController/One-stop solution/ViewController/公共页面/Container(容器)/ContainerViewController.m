//
//  ContainerViewController.m
//  BaseProject
//
//  Created by 张熔冰 on 2018/8/6.
//  Copyright © 2018年 Lovcreate. All rights reserved.
//

#import "ContainerViewController.h"
#import "ContainerView.h"
#import "Masonry.h"
#import "UIColor+Addition.h"
#import "FirstViewController.h"
#import "SecondTableViewController.h"
#import "ThreeTableViewController.h"
#import "UIDevice+Addition.h"

@interface ContainerViewController ()

@property(nonatomic, strong) NSArray *tabs;

@property(nonatomic, strong) ContainerView *containerView;
@property(nonatomic, strong) FirstViewController *firstVC;
@property(nonatomic, strong) SecondTableViewController *secondVC;
@property(nonatomic, strong) ThreeTableViewController *threeVC;

@property(nonatomic, strong) FirstViewController *firstVC1;
@property(nonatomic, strong) SecondTableViewController *secondVC1;
@property(nonatomic, strong) ThreeTableViewController *threeVC1;

@property(nonatomic, strong) FirstViewController *firstVC2;
@property(nonatomic, strong) SecondTableViewController *secondVC2;
@property(nonatomic, strong) ThreeTableViewController *threeVC2;

@end

@implementation ContainerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.containerView = [[ContainerView alloc] initWithFrame:CGRectMake(0, 64.f, kScreenWidth, kScreenHeight - 64.f) style:SegmentControlStylePlain];
    self.containerView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.containerView setViewControllers:@[self.firstVC, self.secondVC, self.threeVC, self.firstVC1, self.secondVC1, self.threeVC1, self.firstVC2, self.secondVC2, self.threeVC2] defaultIndex:0];
    [self.view addSubview:self.containerView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Getter and Setter
-(FirstViewController*)firstVC{
    if (!_firstVC) {
        _firstVC = [[FirstViewController alloc] init];
        _firstVC.title = @"关注";
    }
    return _firstVC;
}

-(SecondTableViewController*)secondVC{
    if (!_secondVC) {
        _secondVC = [[SecondTableViewController alloc] init];
        _secondVC.title = @"热点";
    }
    return _secondVC;
}
-(ThreeTableViewController*)threeVC{
    if (!_threeVC) {
        _threeVC = [[ThreeTableViewController alloc] init];
        _threeVC.title = @"推荐";
    }
    return _threeVC;
}

-(FirstViewController*)firstVC1{
    if (!_firstVC1) {
        _firstVC1 = [[FirstViewController alloc] init];
        _firstVC1.title = @"长春";
    }
    return _firstVC1;
}

-(SecondTableViewController*)secondVC1{
    if (!_secondVC1) {
        _secondVC1 = [[SecondTableViewController alloc] init];
        _secondVC1.title = @"军事";
    }
    return _secondVC1;
}
-(ThreeTableViewController*)threeVC1{
    if (!_threeVC1) {
        _threeVC1 = [[ThreeTableViewController alloc] init];
        _threeVC1.title = @"政治";
    }
    return _threeVC1;
}

-(FirstViewController*)firstVC2{
    if (!_firstVC2) {
        _firstVC2 = [[FirstViewController alloc] init];
        _firstVC2.title = @"亚运会";
    }
    return _firstVC2;
}

-(SecondTableViewController*)secondVC2{
    if (!_secondVC2) {
        _secondVC2 = [[SecondTableViewController alloc] init];
        _secondVC2.title = @"视频";
    }
    return _secondVC2;
}
-(ThreeTableViewController*)threeVC2{
    if (!_threeVC2) {
        _threeVC2 = [[ThreeTableViewController alloc] init];
        _threeVC2.title = @"娱乐";
    }
    return _threeVC2;
}
@end
