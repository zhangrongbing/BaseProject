//
//  BaseViewController.m
//  BaseProject
//
//  Created by zhangrongbing on 2016/11/22.
//  Copyright © 2016年 lovcreate. All rights reserved.
//

#import "BaseViewController.h"
#import <SwipeBack/SwipeBack.h>
#import "LoadingView.h"
#import "Masonry.h"

@interface BaseViewController ()

@property(nonatomic, strong) LoadingView *loadingView;

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)presentViewController:(UIViewController *)viewControllerToPresent animated:(BOOL)flag completion:(void (^)(void))completion{
    if ([viewControllerToPresent isKindOfClass:[UINavigationController class]]) {
        UINavigationController* nav = (UINavigationController*)viewControllerToPresent;
        UIViewController* rootVC = [nav.viewControllers lastObject];
        UIBarButtonItem* item = [[UIBarButtonItem alloc] initWithTitle:LCGetStringWithKeyFromTable(@"取消", nil) style:UIBarButtonItemStylePlain target:self action:@selector(pressCancelButton:)];
        rootVC.navigationItem.leftBarButtonItem = item;
    }
    [super presentViewController:viewControllerToPresent animated:flag completion:completion];
}

-(void)pressCancelButton:(UIButton*)button{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)showLoadingView{
    [self hideLoadingView];
    self.loadingView = [[LoadingView alloc] init];
    self.loadingView.backgroundColor = self.view.backgroundColor;
    [self.view addSubview:self.loadingView];
    NSLayoutConstraint *width = [NSLayoutConstraint constraintWithItem:self.loadingView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeWidth multiplier:1.f constant:0];
    NSLayoutConstraint *height = [NSLayoutConstraint constraintWithItem:self.loadingView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeHeight multiplier:1.f constant:0];
    NSLayoutConstraint *top = [NSLayoutConstraint constraintWithItem:self.loadingView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1.f constant:0];
    NSLayoutConstraint *leading = [NSLayoutConstraint constraintWithItem:self.loadingView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeading multiplier:1.f constant:0];
    [self.view addConstraints:@[width, height, top, leading]];
}

-(void)hideLoadingView{
    if (self.loadingView) {
        [self.loadingView removeFromSuperview];
    }
}
@end
