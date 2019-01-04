//
//  PopTableViewController.m
//  BaseProject
//
//  Created by 张熔冰 on 2018/8/9.
//  Copyright © 2018年 Lovcreate. All rights reserved.
//

#import "PopViewController.h"
#import "UIColor+Addition.h"

#define kWidth 145.f// 控件宽度

@interface PopViewController ()

@property(nonatomic, strong) NSArray<MenuItem*> *items;
@property(nonatomic, strong) void (^handler)(NSInteger index);

@property(nonatomic, strong) UIStackView *stackView;

@end

@implementation PopViewController

-(instancetype)init{
    if (self = [super init]) {
        self.stackView = [[UIStackView alloc] init];
        self.stackView.distribution = UIStackViewDistributionFillEqually;
        self.stackView.axis = UILayoutConstraintAxisVertical;
        self.stackView.spacing = 1;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = RGB(0x282C34);
    [self.view addSubview:self.stackView];
    [self.items enumerateObjectsUsingBlock:^(MenuItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setImage:obj.image forState:UIControlStateNormal];
        [button setTitle:obj.title forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:16.f];
        [button setImageEdgeInsets:UIEdgeInsetsMake(0, 16, 0, 0)];
        [button setTitleEdgeInsets:UIEdgeInsetsMake(0, 32, 0, 0)];
        button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [button addTarget:self action:@selector(pressButton:) forControlEvents:UIControlEventTouchUpInside];
        button.tag = idx+100;
        [self.stackView addArrangedSubview:button];
        //加入分割线
        if (idx != 0) {
            UIView *lineView = [[UIView alloc] init];
            lineView.backgroundColor = [UIColor groupTableViewBackgroundColor];
            [self.stackView addSubview:lineView];
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    //计算内容视图的frame
    self.contentSize = CGSizeMake(kWidth, (kMenuItemHeight + 1)*self.items.count - 1);
    self.stackView.frame = self.view.bounds;
    //分割线的frame
    __block NSInteger i = 1;
    [self.stackView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (![obj isKindOfClass:[UIButton class]]) {
            obj.frame = CGRectMake(8, i * (kMenuItemHeight+1) - 1, CGRectGetWidth(self.view.frame) - 8*2, 1);
            i++;
        }
    }];
    self.view.superview.layer.cornerRadius = 3.f;
}

-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
}

+(instancetype)controllerWithSourceView:(UIView*)sourceView data:(NSArray<MenuItem*>*)items handler:(void(^)(NSInteger index)) handler{
    PopViewController *controller = [[PopViewController alloc] init];
    controller.items = items;
    controller.handler = handler;
    controller.sourceView = sourceView;
    return controller;
}

+(instancetype)controllerWithBarButtonItem:(UIBarButtonItem*)barItem data:(NSArray<MenuItem*>*)items handler:(void(^)(NSInteger index)) handler{
    PopViewController *controller = [[PopViewController alloc] init];
    controller.items = items;
    controller.handler = handler;
    controller.barItem = barItem;
    return controller;
}
#pragma mark - Action
-(void)pressButton:(UIButton*)button{
    if (self.handler) {
        NSInteger index = button.tag - 100;
        self.handler(index);
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
