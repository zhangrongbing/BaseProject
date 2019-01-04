//
//  SearchResultViewController.m
//  BaseProject
//
//  Created by 张熔冰 on 2018/9/3.
//  Copyright © 2018年 Lovcreate. All rights reserved.
//

#import "SearchResultViewController.h"
#import "SearchHistoryTableViewController.h"

@interface SearchResultViewController ()

@end

@implementation SearchResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (self.keywords) {
        self.textField.text = self.keywords;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - UITextFieldView
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    [self.navigationController popViewControllerAnimated:NO];
    return NO;
}
@end
