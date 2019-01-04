//
//  SideViewController.m
//  BaseProject
//
//  Created by 张熔冰 on 2018/8/16.
//  Copyright © 2018年 Lovcreate. All rights reserved.
//

#import "SideViewController.h"

#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

@interface SideViewController ()<UIViewControllerTransitioningDelegate>

@end

@implementation SideViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self prefersStatusBarHidden];
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear: animated];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - UIViewControllerTransitioningDelegate

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source{
    return [[SidePresentedAnimated alloc] init];
}

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed{
    return [[SideDismissedAnimated alloc] init];
}

- (nullable UIPresentationController *)presentationControllerForPresentedViewController:(UIViewController *)presented presentingViewController:(nullable UIViewController *)presenting sourceViewController:(UIViewController *)source NS_AVAILABLE_IOS(8_0){
    SideController *controller = [[SideController alloc] initWithPresentedViewController:presented presentingViewController:presenting];
    return controller;
}

-(BOOL)prefersStatusBarHidden{
    return YES;
}
@end

@implementation SidePresentedAnimated

- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext{
    return .3f;
}
- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext{
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    UIView *toView = toVC.view;
    UIView *containerView = [transitionContext containerView];
    [containerView addSubview:toView];
    
    CGRect finalFrame = [transitionContext finalFrameForViewController:toVC];
    toView.frame = CGRectOffset(finalFrame, -CGRectGetWidth(finalFrame), 0);
    
    [UIView animateWithDuration:.3f delay:0.f usingSpringWithDamping:.7f initialSpringVelocity:0.5f options:UIViewAnimationOptionCurveLinear animations:^{
        toView.frame = CGRectOffset(finalFrame, 0, 0);
    } completion:^(BOOL finished) {
        if (finished) {
            [transitionContext completeTransition:YES];
        }
    }];
}
@end

@implementation SideDismissedAnimated

- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext{
    return .3f;
}
- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext{
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIView *fromView = fromVC.view;
    [UIView animateWithDuration:.3f delay:0.f usingSpringWithDamping:.7f initialSpringVelocity:0.5f options:UIViewAnimationOptionCurveLinear animations:^{
        fromView.frame = CGRectOffset(CGRectMake(0, 0, 0, kScreenHeight), 0, 0);
    } completion:^(BOOL finished) {
        if (finished) {
            [transitionContext completeTransition:YES];
        }
    }];
}

@end

@interface SideController()

@end

@implementation SideController

-(CGRect)frameOfPresentedViewInContainerView{
    return CGRectMake(0, 0, kScreenWidth - 60.f, kScreenHeight);
}
@end
