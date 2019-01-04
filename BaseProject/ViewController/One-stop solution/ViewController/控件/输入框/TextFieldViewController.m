//
//  TextFieldViewController.m
//  BaseProject
//
//  Created by 张熔冰 on 2018/9/12.
//  Copyright © 2018年 Lovcreate. All rights reserved.
//

#import "TextFieldViewController.h"
#import "MoveUpPlaceholderTextField.h"

@interface TextFieldViewController ()

@property(nonatomic, strong) IBOutlet MoveUpPlaceholderTextField *moveUptextField;

@end

@implementation TextFieldViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.moveUptextField.placeholder = @"Username";
    self.moveUptextField.regex = @"^[0-9]{3,6}$";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.moveUptextField.textField resignFirstResponder];
}
@end
