//
//  PickerSheetViewController.m
//  BaseProject
//
//  Created by 张熔冰 on 2018/8/9.
//  Copyright © 2018年 Lovcreate. All rights reserved.
//

#import "PickerSheetViewController.h"

#define kPickerViewHeight 260.f

#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

#define RGB(c) [UIColor colorWithRed:((c>>16)&0xFF)/255.0    \
green:((c>>8)&0xFF)/255.0    \
blue:(c&0xFF)/255.0         \
alpha:1]

@interface PickerSheetViewController ()

@property(nonatomic, strong) UIStackView *stackView;

@end

@implementation PickerSheetViewController

-(instancetype)init{
    if (self = [super init]) {
        [self initActions];
        self.titleLabel = [[UILabel alloc] init];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = RGB(0xF3F3F3);
    [self initStackView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)viewDidLayoutSubviews{
    [super viewWillLayoutSubviews];
    //主视图圆角
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.view.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(8, 8)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.view.bounds;
    maskLayer.path = maskPath.CGPath;
    self.view.layer.mask = maskLayer;
    //UIStackView
    UIView *stackView = self.stackView;
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[stackView(>=350)]-0-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(stackView)]];

    NSDictionary *metrics = @{@"titleViewHeight":@(kTitleViewHeight)};
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[stackView(==titleViewHeight)]" options:0 metrics:metrics views:NSDictionaryOfVariableBindings(stackView)]];
}

- (nullable UIPresentationController *)presentationControllerForPresentedViewController:(UIViewController *)presented presentingViewController:(nullable UIViewController *)presenting sourceViewController:(UIViewController *)source{
    PickerSheetPresentation *presentation = [[PickerSheetPresentation alloc] initWithPresentedViewController:presented presentingViewController:presenting];
    presentation.dismissForUserInterraction = self.dismissForUserInterraction;
    return presentation;
}

#pragma mark - Public
-(void)initStackView{
    self.stackView = [[UIStackView alloc] init];
    self.stackView.translatesAutoresizingMaskIntoConstraints = NO;
    self.stackView.distribution = UILayoutConstraintAxisHorizontal;
    self.stackView.alignment = UIStackViewAlignmentFill;
    self.stackView.backgroundColor = RGB(0xF3F3F3);
    [self.view addSubview:self.stackView];
    
    //取消按钮
    UIButton *cancelBtn = [self generateButtonWithAction:self.cancelAction contentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [cancelBtn addTarget:self action:@selector(performPressCancelButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.stackView addArrangedSubview:cancelBtn];
    
    //标题
    self.titleLabel.textColor = RGB(0x333333);
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.titleLabel setContentHuggingPriority:249 forAxis:UILayoutConstraintAxisHorizontal];
    [self.stackView addArrangedSubview:self.titleLabel];
    //确定按钮
    UIButton *confirmBtn = [self generateButtonWithAction:self.confirmAction contentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
    [confirmBtn addTarget:self action:@selector(performPressConfirmButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.stackView addArrangedSubview:confirmBtn];
}

-(void)initActions{
    self.confirmAction = [PickerAction actionWithTitle:@"确定" titleColor:RGB(0x666666) bgColor:[UIColor clearColor]];
    self.cancelAction = [PickerAction actionWithTitle:@"取消" titleColor:RGB(0x666666) bgColor:[UIColor clearColor]];
}
//根据参数生成按钮
-(UIButton*)generateButtonWithAction:(PickerAction*)action contentHorizontalAlignment:(UIControlContentHorizontalAlignment)alignment{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setContentCompressionResistancePriority:251 forAxis:UILayoutConstraintAxisHorizontal];//抗挤压
    [button setContentHuggingPriority:251 forAxis:UILayoutConstraintAxisHorizontal];//内容抱紧
    [button setContentEdgeInsets:UIEdgeInsetsMake(0, 16, 0, 16)];
    if (action.backgroundColor) {
        [button setBackgroundColor:action.backgroundColor];
    }
    if (action.image) {
        [button setImage:action.image forState:UIControlStateNormal];
    }else{
        [button setTitle:action.title forState:UIControlStateNormal];
        [button setTitleColor:action.titleColor forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:17.f];//默认字体大小
        [button setContentHorizontalAlignment:alignment];
    }
    return button;
}
#pragma mark - Action
//点击取消
-(void)performPressCancelButton:(UIButton*)button{
    [self dismissViewControllerAnimated:YES completion:nil];
}
//点击确定
-(void)performPressConfirmButton:(UIButton*)button{
    
}

@end

@implementation PickerAction

+(instancetype)actionWithTitle:(nonnull NSString *)title titleColor:(nullable UIColor*)titleColor bgColor:(nullable UIColor*) bgcolor{
    PickerAction *action = [[self alloc] init];
    action.title = title;
    action.titleColor = titleColor;
    action.backgroundColor = bgcolor;
    return action;
}

+(instancetype)actionWithImage:(nonnull UIImage*)image bgColor:(nullable UIColor*)bgcolor{
    PickerAction *action = [[self alloc] init];
    action.image = image;
    action.backgroundColor = bgcolor;
    return action;
}

@end

@implementation PickerSheetPresentation

-(CGRect)frameOfPresentedViewInContainerView{
    [super frameOfPresentedViewInContainerView];
    return CGRectMake(0, kScreenHeight - kPickerViewHeight, kScreenWidth, kPickerViewHeight);
}

@end
