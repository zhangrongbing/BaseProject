//
//  BaseTabBarController.m
//  BaseProject
//
//  Created by zhangrongbing on 2016/11/23.
//  Copyright © 2016年 lovcreate. All rights reserved.
//

#import "BaseTabBarController.h"

@interface BaseTabBarController ()

@end

@implementation BaseTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)addChildViewController:(UIViewController *)childController title:(NSString*)title norImage:(UIImage*) norImage selImage:(UIImage*) selImage{
    childController.title = title;

    //Tabbar
    UITabBarItem* tabBarItem = [[UITabBarItem alloc] initWithTitle:title image:norImage selectedImage:[selImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor], NSFontAttributeName:[UIFont systemFontOfSize:12.f]} forState:UIControlStateNormal];
    [tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor blueColor], NSFontAttributeName:[UIFont systemFontOfSize:12.f]} forState:UIControlStateSelected];
    childController.tabBarItem = tabBarItem;
    
    BaseNavigationController* navController = [[BaseNavigationController alloc] initWithRootViewController:childController];
    
    [self addChildViewController:navController];
}

@end