//
//  SocketViewController.m
//  BaseProject
//
//  Created by 张熔冰 on 2018/8/27.
//  Copyright © 2018年 Lovcreate. All rights reserved.
//

#import "SocketViewController.h"
#import "SocketManager.h"
#import "IPManager.h"

@interface SocketViewController ()<SocketManagerDelegate>

///乘客端
@property(nonatomic, weak) IBOutlet UILabel *ipLabel;
@property(nonatomic, weak) IBOutlet UITextField *msgTextField;
@property(nonatomic, weak) IBOutlet UILabel *receiveLabel;

@property(nonatomic, strong) SocketManager *manager;

@end

@implementation SocketViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[self.navigationController.navigationBar.heightAnchor constraintEqualToConstant:80.f] setActive:YES];
}

#pragma mark - Action
//开始连接
-(IBAction)pressConnectButton:(id)sender{
    self.manager  = [SocketManager sharedInstance];
    NSString *host = [[IPManager sharedInstance] localIP];
    [self.manager connectToHost:host onPort:@"8080"];
    self.manager.delegate = self;
}
//发送消息
-(IBAction)pressSendButton:(id)sender{
    NSString *text = self.msgTextField.text;
    [[ToastManager sharedInstance] showMessage:@"发送了%@", text];
    [self.manager sendMessage:text];
}

#pragma mark - SocketManagerDelegate
//连接成功
-(void)socketManager:(SocketManager*)manager didConnectToHost:(NSString *)host onPort:(NSString *)port{
    self.ipLabel.text = host;
}
//接收到消息
-(void)socketManager:(SocketManager *)manager didReceiveMessage:(NSString *)message{
    self.receiveLabel.text = message;
}

-(void)socketManager:(SocketManager *)manager failedWithCode:(SocketManagerFailedCode)code error:(NSError *)error{
    DebugLog(@"发生了错误 %s; code = %ld, error = %@", __FUNCTION__, (long)code, error);
}
@end
