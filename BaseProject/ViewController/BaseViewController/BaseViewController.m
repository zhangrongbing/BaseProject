//
//  BaseViewController.m
//  BaseProject
//
//  Created by zhangrongbing on 2016/11/22.
//  Copyright © 2016年 lovcreate. All rights reserved.
//

#import "BaseViewController.h"
#import <SwipeBack/SwipeBack.h>

@interface BaseViewController ()

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
@end
