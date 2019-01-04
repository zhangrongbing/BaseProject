//
//  ButtonViewController.m
//  BaseProject
//
//  Created by 张熔冰 on 2018/8/21.
//  Copyright © 2018年 Lovcreate. All rights reserved.
//

#import "ButtonViewController.h"
#import "UIButton+Badge.h"
#import "UIBarButtonItem+Badge.h"

@interface ButtonViewController ()

@property(nonatomic, weak) IBOutlet UIButton *badgeButton;
@property(nonatomic, weak) IBOutlet UIButton *badgeButton1;

@end

@implementation ButtonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIImage *image = [UIImage imageNamed:@"消息"];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0,0,image.size.width, image.size.height);
    [button addTarget:self action:@selector(pressRightButton:) forControlEvents:UIControlEventTouchDown];
    [button setBackgroundImage:image forState:UIControlStateNormal];
    
    // Make BarButton Item
    UIBarButtonItem *navLeftButton = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.rightBarButtonItem = navLeftButton;
    self.navigationItem.rightBarButtonItem.badgeValue = @" ";
    self.navigationItem.rightBarButtonItem.badgeFont = [UIFont systemFontOfSize:7.f];
    self.navigationItem.rightBarButtonItem.badgePadding = 0.f;
    self.navigationItem.rightBarButtonItem.badgeOriginX = CGRectGetWidth(button.frame);
    self.navigationItem.rightBarButtonItem.badgeOriginY = -6.f;
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.badgeButton.badgeValue =  @"12";
    
    self.badgeButton1.badgeValue = @" ";
    self.badgeButton1.badgeFont = [UIFont systemFontOfSize:7.f];
    self.badgeButton1.badgePadding = 0.f;
    self.badgeButton1.badgeOriginX = CGRectGetWidth(self.badgeButton1.frame);
    self.badgeButton1.badgeOriginY = -6.f;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)pressRightButton:(UIButton*)button{
    
}
@end
