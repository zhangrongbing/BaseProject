//
//  LoginViewController.m
//  BaseProject
//
//  Created by 张熔冰 on 2018/8/3.
//  Copyright © 2018年 Lovcreate. All rights reserved.
//

#import "LoginViewController.h"
#import "ViewController.h"
#import "AppDelegate.h"

@interface LoginViewController ()

@property(nonatomic, weak) IBOutlet UITextField *accountTextField;
@property(nonatomic, weak) IBOutlet UITextField *passwordTextField;
@property(nonatomic, weak) IBOutlet UIButton *loginButton;
@property(nonatomic, weak) IBOutlet UIButton *forgetPwdButton;
@property(nonatomic, weak) IBOutlet UIButton *registerButton;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = RGB(0xE4F1FD);
    [self setupUI];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Action
//密码可见
-(void)performVisibleButton:(UIButton*)button{
    button.selected = !button.isSelected;
    self.passwordTextField.secureTextEntry = !button.isSelected;
    
}
//忘记密码
-(IBAction)pressForgetPwdButton:(UIButton*)button{
    [[ToastManager sharedInstance] showMessage:@"忘记密码"];
}
//注册
-(IBAction)pressRegisterButton:(UIButton*)button{
    [[ToastManager sharedInstance] showMessage:@"注册"];
}
//登录
-(IBAction)pressLoginButton:(UIButton*)button{
    [self asyncLogin];
}
//监听字符变化
-(void)performTextDidChanged:(UITextField*)textField{
    BOOL loginBtnVisible = self.accountTextField.text.length > 0 && self.passwordTextField.text.length > 0;
    [self.loginButton setEnabled:loginBtnVisible];
}
#pragma mark - Public
-(void)setupUI{
    NSString *accountPlaceholder = LCGetStringWithKeyFromTable(@"账号", nil);
    NSString *passwordPlaceholder = LCGetStringWithKeyFromTable(@"密码", nil);
    NSString *loginTitle = LCGetStringWithKeyFromTable(@"登录", nil);
    NSString *forgetPwdTitle = LCGetStringWithKeyFromTable(@"忘记密码", nil);
    NSString *registerTitle = LCGetStringWithKeyFromTable(@"还没有账号_立即注册", nil);
    
    [self.loginButton setTitle:loginTitle forState:UIControlStateNormal];
    [self.loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.loginButton setEnabled:NO];
    [self.forgetPwdButton setTitle:forgetPwdTitle forState:UIControlStateNormal];
    [self.forgetPwdButton setTitleColor:RGB(0x297FCA) forState:UIControlStateNormal];
    [self.registerButton setTitle:registerTitle forState:UIControlStateNormal];
    [self.registerButton setTitleColor:RGB(0x297FCA) forState:UIControlStateNormal];
    
    
    self.accountTextField.placeholder = accountPlaceholder;
    [self.accountTextField addTarget:self action:@selector(performTextDidChanged:) forControlEvents:UIControlEventEditingChanged];
    UIButton *visibleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [visibleBtn setEnabled:YES];
    [visibleBtn setImage:[UIImage imageNamed:@"可见"] forState:UIControlStateNormal];
    [visibleBtn setImage:[UIImage imageNamed:@"不可见"] forState:UIControlStateSelected];
    [visibleBtn sizeToFit];
    [visibleBtn addTarget:self action:@selector(performVisibleButton:) forControlEvents:UIControlEventTouchUpInside];
    self.passwordTextField.placeholder = passwordPlaceholder;
    self.passwordTextField.rightViewMode = UITextFieldViewModeAlways;
    self.passwordTextField.rightView = visibleBtn;
    [self.passwordTextField addTarget:self action:@selector(performTextDidChanged:) forControlEvents:UIControlEventEditingChanged];
    
}

-(void)asyncLogin{
    [[ToastManager sharedInstance] showMessage:@"登录"];
    AppDelegate *appDelegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
    ViewController *controller = [[ViewController alloc] init];
    BaseNavigationController *nav = [[BaseNavigationController alloc] initWithRootViewController:controller];
    appDelegate.window.rootViewController = nav;
    [appDelegate.window makeKeyAndVisible];
}
@end
