//
//  LoginTwoViewController.m
//  BaseProject
//
//  Created by 张熔冰 on 2018/12/12.
//  Copyright © 2018年 Lovcreate. All rights reserved.
//

#import "LoginTwoViewController.h"

@interface LoginTwoViewController ()

@property(nonatomic, strong) UIView *contentView;
@property(nonatomic, strong) UILabel *label;

@end

@implementation LoginTwoViewController

-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    if (self = [super initWithNibName:@"LoginTwoViewController" bundle:nibBundleOrNil]) {
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initContentView];
    [self initLabel];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"文字" style:UIBarButtonItemStylePlain target:self action:@selector(pressRightItem:)];
    self.navigationItem.rightBarButtonItem = rightItem;
}

-(void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    UIView *contentView = self.contentView;
    UILabel *label = self.label;
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-10-[contentView]-10-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(contentView)]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-10-[contentView(>=104)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(contentView)]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-30-[label]-30-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(label)]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-90-[label]-12-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(label)]];
}

-(void)pressRightItem:(UIBarButtonItem*)item{
    self.label.text = @"labellabellabellabellabellabellabellabellabellabellabellabellabellabellabellabellabellabellabel";
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"内容" preferredStyle:UIAlertControllerStyleAlert];
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        DebugLog(@"配置输入框1");
    }];
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        DebugLog(@"配置输入框2");
    }];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        DebugLog(@"知道了");
    }];
    [alert addAction:action];
    [self presentViewController:alert animated:NO completion:nil];
}

-(void)initContentView{
    self.contentView = [[UIView alloc] init];
    self.contentView.backgroundColor = [UIColor redColor];
    self.contentView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:self.contentView];
}

-(void)initLabel{
    self.label = [UILabel new];
    self.label.backgroundColor = [UIColor yellowColor];
    self.label.numberOfLines = 0;
    self.label.text = @"labellabellabellabellabellabellabellabellabellabellabellabellabellabellabellabellabellabellabel";
    self.label.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView addSubview:self.label];
}
@end
