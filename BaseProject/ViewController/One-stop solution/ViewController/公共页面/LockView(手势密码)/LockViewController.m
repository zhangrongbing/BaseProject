//
//  LockViewController.m
//  BaseProject
//
//  Created by 张熔冰 on 2018/8/13.
//  Copyright © 2018年 Lovcreate. All rights reserved.
//

#import "LockViewController.h"
#import "JinnLockViewController.h"

@interface LockViewController ()<JinnLockViewControllerDelegate>

@end

@implementation LockViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - JinnLockViewControllerDelegate
//密码创建成功
- (void)passcodeDidCreate:(NSString *)passcode{
    [[ToastManager sharedInstance] showMessage:@"创建成功%@", passcode];
}

//密码修改成功
- (void)passcodeDidModify:(NSString *)passcode{
    [[ToastManager sharedInstance] showMessage:@"修改成功%@", passcode];
}

//密码验证成功
- (void)passcodeDidVerify:(NSString *)passcode{
    [[ToastManager sharedInstance] showMessage:@"验证成功%@", passcode];
}

//密码移除成功
- (void)passcodeDidRemove{
    [[ToastManager sharedInstance] showMessage:@"移除成功"];
}

#pragma mark - Public
-(IBAction)pressSetLockButton:(id)sender{
    JinnLockViewController *controller = [[JinnLockViewController alloc] initWithDelegate:self type:JinnLockTypeCreate appearMode:JinnLockAppearModePresent];
    [self presentViewController:controller animated:YES completion:nil];
}

-(IBAction)pressResetLockButton:(id)sender{
    JinnLockViewController *controller = [[JinnLockViewController alloc] initWithDelegate:self type:JinnLockTypeModify appearMode:JinnLockAppearModePresent];
    [self presentViewController:controller animated:YES completion:nil];
}

-(IBAction)pressVerificationButton:(id)sender{
    JinnLockViewController *controller = [[JinnLockViewController alloc] initWithDelegate:self type:JinnLockTypeVerify appearMode:JinnLockAppearModePresent];
    [self presentViewController:controller animated:YES completion:nil];
}

-(IBAction)pressRemoveButton:(id)sender{
    JinnLockViewController *controller = [[JinnLockViewController alloc] initWithDelegate:self type:JinnLockTypeRemove appearMode:JinnLockAppearModePresent];
    [self presentViewController:controller animated:YES completion:nil];
}
@end
