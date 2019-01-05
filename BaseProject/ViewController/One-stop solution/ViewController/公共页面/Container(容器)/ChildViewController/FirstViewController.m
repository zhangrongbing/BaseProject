//
//  FirstViewController.m
//  BaseProject
//
//  Created by 张熔冰 on 2018/8/7.
//  Copyright © 2018年 Lovcreate. All rights reserved.
//

#import "FirstViewController.h"
#import "UIView+Addition.h"

@interface FirstViewController ()

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 100, kScreenWidth, 300)];
    label.text = self.title;
    label.textColor = [UIColor redColor];
    label.font = [UIFont systemFontOfSize:25.f];
    label.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:label];
    DebugLog(@"title = %@",self.title);
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    DebugLog(@"");
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    DebugLog(@"");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    DebugLog(@"");
}
@end
