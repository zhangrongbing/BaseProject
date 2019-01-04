//
//  SelectedPictureController.m
//  BaseProject
//
//  Created by 张熔冰 on 2018/8/15.
//  Copyright © 2018年 Lovcreate. All rights reserved.
//

#import "SheetController.h"

#define RGB(c) [UIColor colorWithRed:((c>>16)&0xFF)/255.0    \
green:((c>>8)&0xFF)/255.0    \
blue:(c&0xFF)/255.0         \
alpha:1]

#define kMenuItemHeight 44.f
#define kMenuItemTitleColor RGB(0x333333)

@interface SheetController ()

@property(nonatomic, strong) NSString *cancelTitle;
@property(nonatomic, strong) NSMutableArray *actions;

@end

@implementation SheetController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self initStackView];
    [self initCancelButton];
    [self initItems];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    //计算内容视图的frame
    UIView *stackView = [self.view viewWithTag:901];
    stackView.frame = CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame) - kMenuItemHeight - 16.f);
    //分割线的frame
    __block NSInteger i = 1;
    [stackView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (![obj isKindOfClass:[UIButton class]]) {
            obj.frame = CGRectMake(8, i * (kMenuItemHeight+1) - 1, CGRectGetWidth(self.view.frame) - 8*2, 1);
            i++;
        }
    }];
    UIView *cancelButton = [self.view viewWithTag:902];
    cancelButton.frame = CGRectMake(0, CGRectGetHeight(self.view.frame) - kMenuItemHeight, CGRectGetWidth(self.view.frame), kMenuItemHeight);
}

-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    UIStackView *mainStackView = [self.view viewWithTag:901];
    mainStackView.spacing = 1.f;
}

+(instancetype)controllerWithCancelTitle:(NSString *)cancelTitle{
    SheetController *controller =  [[SheetController alloc] init];
    controller.actions = [NSMutableArray array];
    controller.cancelTitle = cancelTitle;
    return controller;
}

-(void)dealloc{
    DebugLog(@"");
}
- (nullable UIPresentationController *)presentationControllerForPresentedViewController:(UIViewController *)presented presentingViewController:(nullable UIViewController *)presenting sourceViewController:(UIViewController *)source{
    SheetPresnetation *presentation = [[SheetPresnetation alloc] initWithPresentedViewController:presented presentingViewController:presenting];
    presentation.itemCount = self.actions.count;
    return presentation;
}

-(void)initStackView{
    UIStackView *stackView = [[UIStackView alloc] init];
    stackView.tag = 901;
    stackView.distribution = UIStackViewDistributionFillEqually;
    stackView.axis = UILayoutConstraintAxisVertical;
    [self.view addSubview:stackView];
}

-(void) initCancelButton{
    UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    cancelButton.tag = 902;
    cancelButton.backgroundColor = [UIColor whiteColor];
    [cancelButton setTitle:self.cancelTitle forState:UIControlStateNormal];
    cancelButton.titleLabel.font = [UIFont systemFontOfSize:15.f];
    [cancelButton setTitleColor:RGB(0x333333) forState:UIControlStateNormal];
    [cancelButton addTarget:self action:@selector(pressCancelButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:cancelButton];
}

-(void)initItems{
    [self.actions enumerateObjectsUsingBlock:^(SheetAction * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.backgroundColor = [UIColor whiteColor];
        if (obj.image) {
            [button setImage:obj.image forState:UIControlStateNormal];
        }
        [button setTitle:obj.title forState:UIControlStateNormal];
        [button setTitleColor:kMenuItemTitleColor forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:16.f];
        [button addTarget:self action:@selector(pressButton:) forControlEvents:UIControlEventTouchUpInside];
        button.tag = idx+10;
        
        UIStackView *stackView = [self.view viewWithTag:901];
        [stackView addArrangedSubview:button];
        //加入分割线
        if (idx != 0) {
            UIView *lineView = [[UIView alloc] init];
            lineView.backgroundColor = [UIColor groupTableViewBackgroundColor];
            [stackView addSubview:lineView];
        }
    }];
}
#pragma mark - Action
-(void)pressButton:(UIButton*)button{
    NSInteger tag = button.tag - 10;
    SheetAction *action = [self.actions objectAtIndex:tag];
    action.handler(action);
    [self dismissViewControllerAnimated:YES completion:nil];
}
//点击取消
-(void)pressCancelButton:(UIButton*)button{
    [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark - Public
-(void) addAction:(SheetAction *)action{
    [self.actions addObject:action];
}

@end

@implementation SheetAction

+(instancetype)actionWithTitle:(NSString*)title image:(nullable UIImage *) image handler:(void(^)(SheetAction *action)) handler{
    SheetAction *action = [[SheetAction alloc] init];
    action.title = title;
    action.image = image;
    action.handler = handler;
    return action;
}

@end

@implementation SheetPresnetation

-(CGRect)frameOfPresentedViewInContainerView{
    if (self.itemCount == 0) {
        return CGRectZero;
    }
    CGFloat height = kMenuItemHeight*(self.itemCount+1) + 16 + self.itemCount - 1;
    CGRect mainFrame = [UIScreen mainScreen].bounds;
    return CGRectMake(0, CGRectGetHeight(mainFrame) - height, CGRectGetWidth(mainFrame), height);
}

@end
