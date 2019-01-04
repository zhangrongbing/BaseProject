//
//  ContainerView.m
//  BaseProject
//
//  Created by 张熔冰 on 2018/8/6.
//  Copyright © 2018年 Lovcreate. All rights reserved.
//

#import "ContainerView.h"

#define SliderTableMenuViewHeight 45.f

@interface ContainerView()<UIPageViewControllerDelegate, UIPageViewControllerDataSource, SegmentControlDelegate, SegmentControlDataSource>

@property(nonatomic, strong) UIPageViewController *pageController;
@property(nonatomic, strong) SegmentControl *segmentControl;
@property(nonatomic, assign) NSInteger curIndex;
@property(nonatomic, assign) UIViewController *pendingViewController;

@end

@implementation ContainerView

-(instancetype)init{
    if (self = [super init]) {
        [self setupUI];
    }
    return self;
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]) {
        [self setupUI];
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame style:(SegmentControlStyle)style{
    if (self = [super initWithFrame:frame]) {
        self.style = style;
        [self setupUI];
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    if (self.pageController) {
        self.pageController.view.frame = CGRectMake(0, SliderTableMenuViewHeight, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame) - SliderTableMenuViewHeight);
    }
}

#pragma mark - Getter and Setter
-(UIPageViewController*)pageController{
    if (!_pageController) {
        _pageController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
        _pageController.delegate = self;
        _pageController.dataSource = self;
        _pageController.view.backgroundColor = [UIColor redColor];
    }
    return _pageController;
}

-(SegmentControl*)segmentControl{
    if (!_segmentControl) {
        _segmentControl = [[SegmentControl alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), SliderTableMenuViewHeight) menuStyle:self.style defaultIndex:1];
    }
    return _segmentControl;
}

-(void)setViewControllers:(NSArray*)viewControllers defaultIndex:(NSInteger)index{
    _viewControllers = viewControllers;
    self.segmentControl.curIndex = index;
    self.curIndex = index;
    self.segmentControl.menuDelegate = self;
    self.segmentControl.menuDataSource = self;
    UIViewController *controller = [viewControllers objectAtIndex:index];
    [self.pageController setViewControllers:@[controller] direction:UIPageViewControllerNavigationDirectionReverse animated:NO completion:nil];
}

#pragma mark - SliderTabMenuViewDataSource
-(NSInteger)numberOfTitleInSegmentControl{
    return self.viewControllers.count;
}

-(NSString*)segmentControl:(SegmentControl *)view titleForIndex:(NSInteger)index{
    UIViewController *controller = [self.viewControllers objectAtIndex:index];
    return controller.title;
}

#pragma mark - SliderTabMenuViewDelegate
-(void)segmentControl:(SegmentControl *)view didSelectedForIndex:(NSInteger)index{
    UIPageViewControllerNavigationDirection direction;
    if (index > self.curIndex) {
        direction = UIPageViewControllerNavigationDirectionForward;
    }else{
        direction = UIPageViewControllerNavigationDirectionReverse;
    }
    UIViewController *selectedVC = [self.viewControllers objectAtIndex:index];
    [self.pageController setViewControllers:@[selectedVC] direction:direction animated:YES completion:nil];
    self.curIndex = index;
}

#pragma mark - UIPageViewControllerDataSource
- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController{
    NSInteger index = [self.viewControllers indexOfObject:viewController];
    if (index == NSNotFound || index == 0) {
        return nil;
    }
    NSInteger beforeIndex = index - 1;
    
    return [self.viewControllers objectAtIndex:beforeIndex];
}

- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController{
    NSInteger index = [self.viewControllers indexOfObject:viewController];
    if (index == NSNotFound) {
        return nil;
    }
    if (index + 1 >= self.viewControllers.count) return nil;
    index = index + 1;
    return [self.viewControllers objectAtIndex:index];
}

-(void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray<UIViewController *> *)previousViewControllers transitionCompleted:(BOOL)completed{
    if (completed) {
        self.curIndex = [self.viewControllers indexOfObject:pageViewController.viewControllers.lastObject];
        [self.segmentControl moveToIndex:self.curIndex];
    }
}

#pragma mark - Public
-(void)setupUI{
    [self addSubview:self.segmentControl];
    [self addSubview:self.pageController.view];
}

@end
