//
//  ContainerViewController.m
//  BaseProject
//
//  Created by 张熔冰 on 2018/8/6.
//  Copyright © 2018年 Lovcreate. All rights reserved.
//

#import "ContainerViewController.h"

#define SliderTableMenuViewHeight 45.f

@interface ContainerViewController ()<UIPageViewControllerDelegate, UIPageViewControllerDataSource, SegmentControlDelegate, SegmentControlDataSource>

@property(nonatomic, strong) UIPageViewController *pageController;
@property(nonatomic, strong) NSArray *childControllers;//自控制器列表
@property(nonatomic, assign) NSInteger curControllerIndex;//当前显示的controller下标

@end

@implementation ContainerViewController

-(instancetype)initWithIndex:(NSInteger)index{
    if (self = [super init]) {
        _segmentControl = [[SegmentControl alloc] initWithStyle:SegmentControlStyleEqual defaultIndex:index];
    }
    return self;
}

+(instancetype)containerWithControllers:(NSArray*)controllers defalutControllerIndex:(NSInteger)index{
    ContainerViewController *container = [[ContainerViewController alloc] initWithIndex:index];
    container.childControllers = controllers;
    container.curControllerIndex = index;
    return container;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    //初始化segment
    [self initSegmentControl];
    [self initPageController];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    //segmentControl
    UIView *segmentControl = self.segmentControl;
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[segmentControl]-0-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(segmentControl)]];
    NSDictionary *metrics;
    if (@available(iOS 11, *)) {
        metrics = @{@"NavigationBarHeight":@(self.view.safeAreaInsets.top)};
    }else{
        metrics = @{@"NavigationBarHeight":@(64)};
    }
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-NavigationBarHeight-[segmentControl(==45)]" options:0 metrics:metrics views:NSDictionaryOfVariableBindings(segmentControl)]];
    //UIPageViewController.view
    UIView *pageControllerView = self.pageController.view;
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[pageControllerView]-0-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(pageControllerView)]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[segmentControl]-0-[pageControllerView]-0-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(segmentControl, pageControllerView)]];
}

#pragma mark - init
-(void)initSegmentControl{
    _segmentControl.menuDelegate = self;
    _segmentControl.menuDataSource = self;
    _segmentControl.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:_segmentControl];
}
-(void)initPageController{
    self.pageController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    self.pageController.delegate = self;
    self.pageController.dataSource = self;
    UIViewController *controller = [self.childControllers objectAtIndex:self.curControllerIndex];
    [self.pageController setViewControllers:@[controller] direction:UIPageViewControllerNavigationDirectionReverse animated:NO completion:nil];
    self.pageController.view.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:self.pageController.view];
}

#pragma mark - SliderTabMenuViewDataSource
-(NSInteger)numberOfTitleInSegmentControl{
    return self.childControllers.count;
}

-(NSString*)segmentControl:(SegmentControl *)view titleForIndex:(NSInteger)index{
    UIViewController *controller = [self.childControllers objectAtIndex:index];
    return controller.title;
}

#pragma mark - SliderTabMenuViewDelegate
-(void)segmentControl:(SegmentControl *)view didSelectedForIndex:(NSInteger)index{
    UIPageViewControllerNavigationDirection direction;
    if (index > self.curControllerIndex) {
        direction = UIPageViewControllerNavigationDirectionForward;
    }else{
        direction = UIPageViewControllerNavigationDirectionReverse;
    }
    UIViewController *selectedVC = [self.childControllers objectAtIndex:index];
    [self.pageController setViewControllers:@[selectedVC] direction:direction animated:YES completion:nil];
    self.curControllerIndex = index;
}

#pragma mark - UIPageViewControllerDataSource
- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController{
    NSInteger index = [self.childControllers indexOfObject:viewController];
    if (index == NSNotFound || index == 0) {
        return nil;
    }
    NSInteger beforeIndex = index - 1;
    
    return [self.childControllers objectAtIndex:beforeIndex];
}

- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController{
    NSInteger index = [self.childControllers indexOfObject:viewController];
    if (index == NSNotFound) {
        return nil;
    }
    if (index + 1 >= self.childControllers.count) return nil;
    index = index + 1;
    return [self.childControllers objectAtIndex:index];
}

-(void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray<UIViewController *> *)previousViewControllers transitionCompleted:(BOOL)completed{
    if (completed) {
        self.curControllerIndex = [self.childControllers indexOfObject:pageViewController.viewControllers.lastObject];
        [self.segmentControl moveToIndex:self.curControllerIndex];
    }
}
@end
