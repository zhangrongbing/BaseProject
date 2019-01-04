//
//  LifeCyclePushViewController.m
//  BaseProject
//
//  Created by 张熔冰 on 2018/8/27.
//  Copyright © 2018年 Lovcreate. All rights reserved.
//

#import "LifeCyclePushViewController.h"
#import "LifeCycleView.h"

@interface LifeCyclePushViewController ()

@property(nonatomic, strong) LifeCycleView *myView;
@property(nonatomic, strong) UIButton *changeFrameBtn;

@end

@implementation LifeCyclePushViewController
-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]) {
        DebugLog(@"");
    }
    return self;
}

-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    if (self = [super initWithNibName:@"LifeCyclePushViewController" bundle:nibBundleOrNil]) {
        DebugLog(@"");
    }
    return self;
}

-(void)loadView{
    [super loadView];
    DebugLog(@"");
}

-(void)loadViewIfNeeded{
    [super loadViewIfNeeded];
    DebugLog(@"");
}
- (void)viewDidLoad {
    [super viewDidLoad];
    DebugLog(@"");
    [self configureMyView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    DebugLog(@"");
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    DebugLog(@"");
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    DebugLog(@"");
}

-(void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    DebugLog(@"");
}

-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    DebugLog(@"");
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    DebugLog(@"");
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    DebugLog(@"");
}

-(void)configureMyView{
    self.myView = [[LifeCycleView alloc] initWithFrame:CGRectMake(8, 200, kScreenWidth - 8*2, 50.f)];
    self.myView.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.myView];
    
    self.changeFrameBtn = [[UIButton alloc] initWithFrame:CGRectMake(8, 300.f, kScreenWidth - 8*2, 44.f)];
    self.changeFrameBtn.backgroundColor = [UIColor blueColor];
    [self.changeFrameBtn setTitle:@"修改Frame" forState:UIControlStateNormal];
    [self.changeFrameBtn addTarget:self action:@selector(pressButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.changeFrameBtn];
}

#pragma mark - Action
-(void)pressButton:(UIButton*)button{
    self.myView.frame = CGRectMake(30, 150, kScreenWidth - 30*2.f, arc4random_uniform(50));
}
@end
