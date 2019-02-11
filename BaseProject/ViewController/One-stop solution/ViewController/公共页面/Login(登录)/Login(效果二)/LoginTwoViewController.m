//
//  LoginTwoViewController.m
//  BaseProject
//
//  Created by 张熔冰 on 2018/12/12.
//  Copyright © 2018年 Lovcreate. All rights reserved.
//

#import "LoginTwoViewController.h"
#import "NetworkingManager.h"
#import "LoginOperation.h"

@interface LoginTwoViewController ()

@property(nonatomic, weak) IBOutlet UITextField *accountTextField;
@property(nonatomic, weak) IBOutlet UITextField *passwordTextField;

@end

@implementation LoginTwoViewController

-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    if (self = [super initWithNibName:@"LoginTwoViewController" bundle:nibBundleOrNil]) {
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

-(IBAction)pressLoginButton:(id)sender{
    NSString *account = self.accountTextField.text;
    NSString *password  = self.passwordTextField.text;
    
    NSMutableDictionary *params = @{}.mutableCopy;
    params[@"username"] = account;
    params[@"password"] = password;
    LoginOperation *operation = [[LoginOperation alloc] initWithTarget:self params:params];
    [[NetworkingManager sharedInstance] asyncOperation:operation handler:^(NSInteger state) {
        
    }];
    
}
@end
