//
//  SideViewController.m
//  BaseProject
//
//  Created by 张熔冰 on 2018/8/16.
//  Copyright © 2018年 Lovcreate. All rights reserved.
//

#import "SideViewContainer.h"
#import "SideViewController.h"

@interface SideViewContainer ()

@end

@implementation SideViewContainer

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"侧边栏"] style:UIBarButtonItemStylePlain target:self action:@selector(pressLeftItem:)];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(pressRightItem:)];
    self.view.tag = 1001;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    DebugLog(@"%@", NSStringFromCGRect(self.view.frame));
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self setNeedsStatusBarAppearanceUpdate];
}

//-(BOOL)prefersStatusBarHidden{
//    return YES;
//}
#pragma mark - Action
-(void)pressLeftItem:(UIBarButtonItem *)item{
    SideViewController *controller = [[SideViewController alloc] init];
    [self presentViewController:controller animated:YES completion:nil];
}

-(void)pressRightItem:(UIBarButtonItem*)item{
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end

