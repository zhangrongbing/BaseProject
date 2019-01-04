//
//  ChildViewController.m
//  BaseProject
//
//  Created by 张熔冰 on 2018/8/8.
//  Copyright © 2018年 Lovcreate. All rights reserved.
//

#import "ChildViewController.h"
#import "SegmentControl.h"
#import "FirstViewController.h"
#import "SecondTableViewController.h"
#import "ThreeTableViewController.h"

@interface ChildViewController ()<SegmentControlDelegate, SegmentControlDataSource>

@property(nonatomic, strong) SegmentControl *segmentControl;
@property(nonatomic, strong) FirstViewController *firstVC;
@property(nonatomic, strong) SecondTableViewController *secondVC;
@property(nonatomic, strong) ThreeTableViewController *threeVC;

@property(nonatomic, strong) UIViewController *currentVC;
@property(nonatomic, strong) NSArray *controllers;
@end

@implementation ChildViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.controllers = @[self.firstVC, self.secondVC, self.threeVC];
    self.segmentControl = [[SegmentControl alloc] initWithFrame:CGRectMake(0, 88, kScreenWidth, 45.f) menuStyle:SegmentControlStylePlain defaultIndex:0];
    self.segmentControl.menuDataSource = self;
    self.segmentControl.menuDelegate = self;
    [self.view addSubview:self.segmentControl];
    
    CGRect rect = CGRectMake(0, self.segmentControl.lc_b, kScreenWidth, kScreenHeight - self.segmentControl.lc_b);
    self.firstVC.view.frame = rect;
    [self addChildViewController:self.firstVC];
    [self.view addSubview:self.firstVC.view];
    self.currentVC = self.firstVC;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


#pragma mark - Getter and Setter
-(FirstViewController*)firstVC{
    if (!_firstVC) {
        _firstVC = [[FirstViewController alloc] init];
        _firstVC.title = @"数学";
    }
    return _firstVC;
}

-(SecondTableViewController*)secondVC{
    if (!_secondVC) {
        _secondVC = [[SecondTableViewController alloc] init];
        _secondVC.title = @"语文";
    }
    return _secondVC;
}
-(ThreeTableViewController*)threeVC{
    if (!_threeVC) {
        _threeVC = [[ThreeTableViewController alloc] init];
        _threeVC.title = @"英语";
    }
    return _threeVC;
}

#pragma mark - SliderTabMenuViewDataSource
-(NSInteger)numberOfTitleInSegmentControl{
    return self.controllers.count;
}

-(NSString*)segmentControl:(SegmentControl *)view titleForIndex:(NSInteger)index{
    UIViewController *controller = [self.controllers objectAtIndex:index];
    return controller.title;
}

#pragma mark - SliderTabMenuViewDelegate
-(void)segmentControl:(SegmentControl *)view didSelectedForIndex:(NSInteger)index{
    UIViewController *controller = [self.controllers objectAtIndex:index];
    [self replaceController:self.currentVC withVC:controller];
}

#pragma mark - Public
-(void)replaceController:(UIViewController*)oldVC withVC:(UIViewController*)newVC{
    if ([oldVC isKindOfClass:[newVC class]]) {
        return;
    }
    CGRect rect = CGRectMake(0, self.segmentControl.lc_b, kScreenWidth, kScreenHeight - self.segmentControl.lc_b);
    newVC.view.frame = rect;
    
    [self addChildViewController:newVC];
    [self transitionFromViewController:oldVC toViewController:newVC duration:.3f options:UIViewAnimationOptionTransitionNone animations:nil completion:^(BOOL finished) {
        if (finished) {
            [newVC didMoveToParentViewController:self];
            [oldVC willMoveToParentViewController:nil];
            [oldVC removeFromParentViewController];
            self.currentVC = newVC;
        }else{
            self.currentVC = oldVC;
        }
    }];
}
@end
