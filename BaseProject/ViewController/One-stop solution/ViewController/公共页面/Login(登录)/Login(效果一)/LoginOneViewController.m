//
//  LoginOneViewController.m
//  BaseProject
//
//  Created by 张熔冰 on 2018/12/10.
//  Copyright © 2018年 Lovcreate. All rights reserved.
//

#import "LoginOneViewController.h"
#import "LoginSwitchButton.h"
#import "LoginUserView.h"
#import "MoveUpPlaceholderTextField.h"
#import "UIImage+Addition.h"

#define kOperatorViewSpacing 20.f

@interface LoginOneViewController ()

@property(nonatomic, strong) LoginUserView *userView;
@property(nonatomic, strong) UIButton *loginButton;

@end

@implementation LoginOneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    [self initSwitchButton];
    [self initUserView];
    [self initAccount];
    [self initPwd];
    [self initOperatorView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
-(void)setupUI{
    self.view.backgroundColor = RGB(0x333333);
}

-(void)initSwitchButton{
    LoginSwitchButton *button = [[LoginSwitchButton alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 64.f)];
    button.loginTitle = LCGetStringWithKeyFromTable(@"登录", nil);
    button.loginColor = [UIColor purpleColor];
    button.registerTitle = LCGetStringWithKeyFromTable(@"注册", nil);
    button.registerColor = [UIColor orangeColor];
    [self.view addSubview:button];
}

-(void)initUserView{
    LoginUserView *userView = [[LoginUserView alloc] initWithFrame:CGRectMake(32.f, 64, kScreenWidth - 32.f*2, 80)];
    userView.tag = 901;
    [self.view addSubview:userView];
    self.userView = userView;
}

-(void)initAccount{
    MoveUpPlaceholderTextField *account = [[MoveUpPlaceholderTextField alloc] initWithFrame:CGRectMake(32.f, 64*2, kScreenWidth- 32.f*2, 66.f)];
    account.placeholder = LCGetStringWithKeyFromTable(@"账号", nil);
    account.textColor = [UIColor orangeColor];
    account.regex = @"^[A-Za-z0-9]{4,20}+$";
    account.placeholderColor = [UIColor lightGrayColor];
    [account setTextChangedBlock:^(NSString *text, BOOL matched) {
        if ([text isEqualToString:@"Icer"]) {
            UIImage *userIcon = [UIImage imageNamed:@"user_icon"];
            [self.userView showUserIcon:userIcon nickName:@"Icer"];
        }else if(text.length == 0){
            [self.userView hide];
        }
    }];
    [self.view addSubview:account];
}

-(void)initPwd{
    MoveUpPlaceholderTextField *pwd = [[MoveUpPlaceholderTextField alloc] initWithFrame:CGRectMake(32.f, 64*3+33, kScreenWidth - 32.f*2, 64.f)];
    pwd.placeholder = LCGetStringWithKeyFromTable(@"密码", nil);
    pwd.textColor = [UIColor orangeColor];
    pwd.regex = @"^[A-Za-z0-9]{6,20}+$";
    pwd.placeholderColor = [UIColor lightGrayColor];
    [pwd.textField setSecureTextEntry:YES];
    [pwd setTextChangedBlock:^(NSString *text, BOOL matched) {
        [self.loginButton setEnabled:matched];
    }];
    [self.view addSubview:pwd];
}

-(void)initOperatorView{
    UIView *operatorView = [[UIView alloc] initWithFrame:CGRectMake(32, kScreenHeight - 30.f - kOperatorViewSpacing, kScreenWidth - 32*2, 30.f)];
    operatorView.tag = 902;
    [self.view addSubview:operatorView];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardShown:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardHiden:) name:UIKeyboardWillHideNotification object:nil];
    UIButton *loginBtn = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetWidth(operatorView.frame)*2/3.f, 0, CGRectGetWidth(operatorView.frame)/3.f, CGRectGetHeight(operatorView.frame))];
    [loginBtn addTarget:self action:@selector(pressLoginButton:) forControlEvents:UIControlEventTouchUpInside];
    UIImage *disableColorImage = [UIImage _imageWithColor:[UIColor lightGrayColor] size:loginBtn.frame.size];
    UIImage *normalColorImage = [UIImage _imageWithColor:[UIColor greenColor] size:loginBtn.frame.size];
    [loginBtn setBackgroundImage:disableColorImage forState:UIControlStateDisabled];
    [loginBtn setBackgroundImage:normalColorImage forState:UIControlStateNormal];
    [loginBtn setTitle:LCGetStringWithKeyFromTable(@"登录", nil) forState:UIControlStateNormal];
    [loginBtn setTitle:LCGetStringWithKeyFromTable(@"登录", nil) forState:UIControlStateDisabled];
    [loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateDisabled];
    loginBtn.layer.masksToBounds = YES;
    loginBtn.layer.cornerRadius = CGRectGetHeight(operatorView.frame)/2.f;
    [loginBtn setEnabled:NO];
    [operatorView addSubview:loginBtn];
    //三方登录
    NSArray *buttons = [self generateThirdLoginBtn];
    if (buttons.count > 0) {
        UIStackView *stackView = [[UIStackView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(operatorView.frame)/2.f, CGRectGetHeight(operatorView.frame))];
        stackView.spacing = 20.f;
        stackView.backgroundColor = [UIColor redColor];
        stackView.distribution = UIStackViewDistributionFillEqually;
        [operatorView addSubview:stackView];
        for (UIButton *btn  in buttons) {
            btn.backgroundColor = RGB(0x999999);
            btn.layer.masksToBounds = YES;
            btn.layer.cornerRadius = CGRectGetHeight(operatorView.frame)/2.f;
            [stackView addArrangedSubview:btn];
        }
    }
    self.loginButton = loginBtn;
}

#pragma mark - Selector
-(void)keyboardShown:(NSNotification*)notification{
    CGRect keyboardFrame = [[notification.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    NSTimeInterval time = [[notification.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    UIView *view = [self.view viewWithTag:902];
    [UIView animateWithDuration:time animations:^{
        view.frame = CGRectMake(CGRectGetMinX(view.frame), kScreenHeight - CGRectGetHeight(view.frame) - CGRectGetHeight(keyboardFrame) - kOperatorViewSpacing, CGRectGetWidth(view.frame), CGRectGetHeight(view.frame));
    }];
}

-(void)keyboardHiden:(NSNotification*)notification{
    NSTimeInterval time = [[notification.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    UIView *view = [self.view viewWithTag:902];
    [UIView animateWithDuration:time animations:^{
        view.frame = CGRectMake(CGRectGetMinX(view.frame), kScreenHeight - CGRectGetHeight(view.frame) - kOperatorViewSpacing, CGRectGetWidth(view.frame), CGRectGetHeight(view.frame));
    }];
}

#pragma mark - Action
-(void)pressLoginButton:(UIButton*)button {
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark - Public
//生成三方登录按钮 微信/qq
-(NSMutableArray*)generateThirdLoginBtn{
    NSMutableArray *buttons = @[].mutableCopy;
#if TARGET_IPHONE_SIMULATOR
    return buttons;
#else
    // 是否安装微信
    BOOL wechat = [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"mqqapi://"]];
    // 是否安装QQ
    BOOL qq = [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"weixin://"]];
    if (wechat) {
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setImage:[UIImage imageNamed:@"login_qq"] forState:UIControlStateNormal];
        [buttons addObject:btn];
    }
    if (qq) {
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setImage:[UIImage imageNamed:@"login_weixin"] forState:UIControlStateNormal];
        [buttons addObject:btn];
    }
    return buttons;
#endif
}
@end
