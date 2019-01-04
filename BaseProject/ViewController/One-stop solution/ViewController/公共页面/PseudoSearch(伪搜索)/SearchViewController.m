//
//  PseudoSearchViewController.m
//  BaseProject
//
//  Created by 张熔冰 on 2018/8/23.
//  Copyright © 2018年 Lovcreate. All rights reserved.
//

#import "SearchViewController.h"
#import "SearchHistoryTableViewController.h"

@interface SearchViewController ()<UITextFieldDelegate>

@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createTitleView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)dealloc{
    DebugLog(@"");
}

#pragma mark - UITextFieldView
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    SearchHistoryTableViewController *controller = [[SearchHistoryTableViewController alloc] init];
    BaseNavigationController *nav = [[BaseNavigationController alloc] initWithRootViewController:controller];
    [self presentViewController:nav animated:NO completion:nil];
    return NO;
}

#pragma mark - Public
-(void)createTitleView{
    UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 32.f)];
    textField.layer.masksToBounds = YES;
    textField.layer.cornerRadius = 10.f;
    textField.placeholder = @"主页搜索";
    textField.backgroundColor = [RGB(0x8E8E93) colorWithAlphaComponent:0.88];
    textField.tintColor = RGB(0x999999);
    textField.borderStyle = UITextBorderStyleNone;
    UIImageView *iv = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 34.f, 32.f)];
    [iv setImage:[UIImage imageNamed:@"搜索"]];
    [iv setContentMode:UIViewContentModeCenter];
    textField.leftView = iv;
    textField.leftViewMode = UITextFieldViewModeAlways;
    self.navigationItem.titleView = textField;
    textField.delegate = self;
    self.textField = textField;
}
@end
