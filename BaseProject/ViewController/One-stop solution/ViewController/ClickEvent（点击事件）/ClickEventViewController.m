//
//  ClickEventViewController.m
//  BaseProject
//
//  Created by Swift liu on 2018/10/25.
//  Copyright © 2018 Lovcreate. All rights reserved.
//

#import "ClickEventViewController.h"
#import "Masonry.h"
#import "UIView+Block.h"
#import "UIButton+EnlargeTouchArea.h"

@interface ClickEventViewController ()

@end

@implementation ClickEventViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor cyanColor];
    [self.view addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.mas_equalTo(self.view).offset(120);
        make.size.mas_equalTo(CGSizeMake(100, 80));
    }];
    
    UIView *weakView = view;
    [view addClickedBlock:^(id  _Nonnull obj) {
        
        [[ToastManager sharedInstance] showMessage:@"3333"];
        DebugLog(@"点击了这个view->%@",weakView);
    }];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"按钮边界扩大10" forState:UIControlStateNormal];
    [btn setBackgroundColor:[UIColor redColor]];
    [self.view addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(view.mas_bottom).offset(44);
        make.left.mas_equalTo(self.view).offset(100);
        make.size.mas_equalTo(CGSizeMake(150, 40));
    }];

    UIButton *weakBtn = btn;
    //    扩大区域
    [btn lc_setEnlargeEdgeWithTop:10 right:10 bottom:10 left:10];
    [btn addClickedBlock:^(id  _Nonnull obj) {
        [[ToastManager sharedInstance] showMessage:@"2223333"];
        DebugLog(@"点击了这个按钮->%@",weakBtn);
    }];
    
    
    
    
    
    // Do any additional setup after loading the view.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
