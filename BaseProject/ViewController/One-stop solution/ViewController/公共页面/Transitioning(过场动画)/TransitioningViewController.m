//
//  TransitioningViewController.m
//  BaseProject
//
//  Created by 张熔冰 on 2018/8/16.
//  Copyright © 2018年 Lovcreate. All rights reserved.
//

#import "TransitioningViewController.h"
#import "UpToDownViewController.h"

@interface TransitioningViewController ()

@end

@implementation TransitioningViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(IBAction)pressUpToDownButton:(id)sender{
    UpToDownViewController *controller = [[UpToDownViewController alloc] init];
    [self presentViewController:controller animated:YES completion:nil];
}

@end
