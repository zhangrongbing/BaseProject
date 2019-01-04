//
//  BottomExpansionViewController.m
//  BaseProject
//
//  Created by 张熔冰 on 2018/9/10.
//  Copyright © 2018年 Lovcreate. All rights reserved.
//

#import "BottomExpansionViewController.h"
#import "BottomExpansionView.h"

@interface BottomExpansionViewController ()

@property(nonatomic, strong) BottomExpansionView *expansionView;

@end

@implementation BottomExpansionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    BottomExpansionView* view = [[BottomExpansionView alloc] initWithDefaultTitle:@"我就是无数据的标题" title:@"我就是有数据的标题" data:@[@"1"] selectedBlock:^(NSInteger index) {
        
    }];
    [self.view addSubview:view];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
