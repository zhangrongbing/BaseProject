//
//  LifeCycleAViewController.m
//  BaseProject
//
//  Created by 张熔冰 on 2018/8/27.
//  Copyright © 2018年 Lovcreate. All rights reserved.
//

#import "LifeCycleAViewController.h"
#import "LifeCyclePushViewController.h"

@interface LifeCycleAViewController ()

@end

@implementation LifeCycleAViewController

-(instancetype)init{
    if (self = [super init]) {
        DebugLog(@"");
    }
    return self;
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]) {
        DebugLog(@"");
    }
    return self;
}

-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    if (self = [super initWithNibName:@"LifeCycleAViewController" bundle:nibBundleOrNil]) {
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
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    DebugLog(@"");
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    DebugLog(@"");
}

-(void)viewSafeAreaInsetsDidChange{
    [super viewSafeAreaInsetsDidChange];
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

#pragma mark - Action
-(IBAction)pressPushButton:(id)sender{
    LifeCyclePushViewController *controller = [[LifeCyclePushViewController alloc] init];
    [self.navigationController pushViewController:controller animated:YES];
}

-(IBAction)pressPresentButton:(id)sender{
    
}
@end
