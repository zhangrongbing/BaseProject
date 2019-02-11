//
//  BaseNavigationController.m
//  BaseProject
//
//  Created by zhangrongbing on 2016/11/22.
//  Copyright © 2016年 lovcreate. All rights reserved.
//

#import "BaseNavigationController.h"
#import "BaseViewController.h"
#import "SwipeBack.h"
#import "BaseTableViewController.h"
#import "PushManager.h"
#import "ShortcutManager.h"

@interface BaseNavigationController ()<PushManagerDelegate, ShortcutManagerDelegate>

@property(nonatomic, strong) BaseViewController* curViewController;

@end

@implementation BaseNavigationController

-(instancetype)initWithRootViewController:(UIViewController *)rootViewController{
    if (self = [super initWithRootViewController:rootViewController]) {
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor],NSFontAttributeName:[UIFont systemFontOfSize:17.f]}];
    [self.navigationBar setBarTintColor:RGB(0x297FCA)];
    [self.navigationBar setTintColor:[UIColor whiteColor]];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [PushManager sharedInstance].delegate = self;
    [ShortcutManager sharedInstance].delegate = self;
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(UIInterfaceOrientation)preferredInterfaceOrientationForPresentation{
    return UIInterfaceOrientationPortrait;
}

-(void)pushViewController:(BaseViewController *)viewController animated:(BOOL)animated{
    self.curViewController= viewController;
    if (self.childViewControllers.count > 0) {
        UIImage* leftImage = [UIImage imageNamed:@"Back"];
        UIButton *leftButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 20.f, 44.f)];
        [leftButton setImage:leftImage forState:UIControlStateNormal];
        leftButton.imageEdgeInsets = UIEdgeInsetsMake(0, -8, 0, 8);
        UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
        viewController.navigationItem.leftBarButtonItem = leftItem;
        [leftButton addTarget:self action:@selector(popViewControllerAnimated:) forControlEvents:UIControlEventTouchUpInside];
    }
    [super pushViewController:viewController animated:animated];
}

- (UIStatusBarStyle)preferredStatusBarStyle{
    UIViewController* controller = self.topViewController;
    return [controller preferredStatusBarStyle];
}

//状态栏
-(BOOL)prefersStatusBarHidden{
    return [self.topViewController prefersStatusBarHidden];
}
//- (BOOL)shouldAutorotate {
//    UIViewController* controller = self.topViewController;
//    return [controller shouldAutorotate];
//    return NO;
//}
//- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
//    UIViewController* controller = self.topViewController;
//    return [controller supportedInterfaceOrientations];
//    return UIInterfaceOrientationMaskAll;
//}
@end

