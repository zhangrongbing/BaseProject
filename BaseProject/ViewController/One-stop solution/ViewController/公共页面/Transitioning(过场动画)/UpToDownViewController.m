//
//  UpToDownViewController.m
//  BaseProject
//
//  Created by 张熔冰 on 2018/8/16.
//  Copyright © 2018年 Lovcreate. All rights reserved.
//

#import "UpToDownViewController.h"

@interface UpToDownViewController ()<UIViewControllerTransitioningDelegate>

@property(nonatomic, strong) UIButton *button;

@end

@implementation UpToDownViewController

-(instancetype)init{
    if (self = [super init]) {
        self.transitioningDelegate = self;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.button = [[UIButton alloc] initWithFrame:CGRectMake(0, 64, 320, 100)];
    self.button.backgroundColor = [UIColor blueColor];
    [self.view addSubview:self.button];
    [self.button setTitle:@"降落吧，宝贝" forState:UIControlStateNormal];
    [self.button addTarget:self action:@selector(pressButton:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Action
-(void)pressButton:(UIButton *)button{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UIViewControllerTransitioningDelegate
- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source{
    return [[PresentedAnimated alloc] init];
}

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed{
    return [[DismissedAnimated alloc] init];
}

@end

@implementation PresentedAnimated

- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext{
    return .3f;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext{
    BaseViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    BaseViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    UIView *fromView = fromVC.view;
    UIView *toView = toVC.view;
    UIView *containerView = [transitionContext containerView];
    
    CGRect finalFrame = [transitionContext finalFrameForViewController:toVC];
    [containerView addSubview:toView];
    toView.frame = CGRectMake(0, -CGRectGetHeight(finalFrame), CGRectGetWidth(finalFrame), CGRectGetHeight(finalFrame));
    [UIView animateWithDuration:.3f animations:^{
        fromView.alpha = 0.f;
        toView.alpha = 1.f;
        toView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
    } completion:^(BOOL finished) {
        if (finished) {
            [transitionContext completeTransition:YES];
        }
    }];
}

@end

@implementation DismissedAnimated
- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext{
    return .3f;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext{
    BaseViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    BaseViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    UIView *fromView = fromVC.view;
    UIView *toView = toVC.view;
    UIView *containerView = [transitionContext containerView];
    
    CGRect finalFrame = [transitionContext finalFrameForViewController:toVC];
    [containerView addSubview:toView];
    fromView.frame = CGRectMake(0, 0, CGRectGetWidth(finalFrame), CGRectGetHeight(finalFrame));
    [UIView animateWithDuration:.3f animations:^{
        fromView.alpha = 0.f;
        toView.alpha = 1.f;
        fromView.frame = CGRectMake(0, -CGRectGetHeight(finalFrame), CGRectGetWidth(finalFrame), CGRectGetHeight(finalFrame));
    } completion:^(BOOL finished) {
        if (finished) {
            [transitionContext completeTransition:YES];
        }
    }];
}

@end
