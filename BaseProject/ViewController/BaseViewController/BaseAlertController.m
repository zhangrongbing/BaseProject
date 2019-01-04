//
//  SheetViewController.m
//  BaseProject
//
//  Created by 张熔冰 on 2018/8/14.
//  Copyright © 2018年 Lovcreate. All rights reserved.
//

#import "BaseAlertController.h"

@interface BaseAlertController ()<UIViewControllerTransitioningDelegate>

@end

@implementation BaseAlertController

-(instancetype)init{
    if (self = [super init]) {
        self.modalPresentationStyle = UIModalPresentationCustom;
        self.transitioningDelegate = self;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dismissForUserInterraction = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - UIViewControllerTransitioningDelegate
- (nullable UIPresentationController *)presentationControllerForPresentedViewController:(UIViewController *)presented presentingViewController:(nullable UIViewController *)presenting sourceViewController:(UIViewController *)source{
    return nil;
}

@end

@interface BasePresentation()

@property(nonatomic, strong) UIVisualEffectView *visualView;
@property(nonatomic, strong) UITapGestureRecognizer *tap;

@end

@implementation BasePresentation

-(instancetype)initWithPresentedViewController:(UIViewController *)presentedViewController presentingViewController:(UIViewController *)presentingViewController{
    if (self = [super initWithPresentedViewController:presentedViewController presentingViewController:presentingViewController]) {
        UIBlurEffect *blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
        _visualView = [[UIVisualEffectView alloc] initWithEffect:blur];
        _visualView.alpha = 0;
        self.tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pressContainerView:)];
        [_visualView addGestureRecognizer:self.tap];
    }
    return self;
}

-(CGRect)frameOfPresentedViewInContainerView{
    return CGRectZero;
}

- (void)presentationTransitionWillBegin{
    self.visualView.frame = self.containerView.bounds;
    [self.containerView addSubview:_visualView];
    
    id<UIViewControllerTransitionCoordinator> coordinator = self.presentingViewController.transitionCoordinator;
    __block __weak typeof(self) weakSelf = self;
    [coordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
        weakSelf.visualView.alpha = .4;
    } completion:nil];
}

- (void)presentationTransitionDidEnd:(BOOL)completed{
    if (!completed) {
        [_visualView removeFromSuperview];
    }
}

- (void)dismissalTransitionWillBegin{
    id<UIViewControllerTransitionCoordinator> coordinator = self.presentingViewController.transitionCoordinator;
    __block __weak typeof(self) weakSelf = self;
    [coordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
        weakSelf.visualView.alpha = 0.0;
    } completion:nil];
}

- (void)dismissalTransitionDidEnd:(BOOL)completed{
    if (completed) {
        [_visualView removeFromSuperview];
        self.tap = nil;
    }
}

- (void)containerViewWillLayoutSubviews NS_REQUIRES_SUPER{
    self.visualView.frame = self.containerView.bounds;
}

#pragma mark - Action
-(void)pressContainerView:(UITapGestureRecognizer*)tap{
    [self.presentedViewController dismissViewControllerAnimated:YES completion:nil];
}

@end
