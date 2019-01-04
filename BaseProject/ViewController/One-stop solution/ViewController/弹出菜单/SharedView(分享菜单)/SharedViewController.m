//
//  SharedViewController.m
//  BaseProject
//
//  Created by 张熔冰 on 2018/8/13.
//  Copyright © 2018年 Lovcreate. All rights reserved.
//

#import "SharedViewController.h"

#define RGB(c) [UIColor colorWithRed:((c>>16)&0xFF)/255.0    \
green:((c>>8)&0xFF)/255.0    \
blue:(c&0xFF)/255.0         \
alpha:1]

@interface SharedViewController ()

@property(nonatomic, strong) NSMutableArray *actions;
@end

@implementation SharedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self initStackView];
    [self initMenuItem];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    self.view.layer.cornerRadius = 8.f;
    
    UIView *mainStackView = [self.view viewWithTag:901];
    mainStackView.frame = self.view.bounds;
}

-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    UIStackView *mainStackView = [self.view viewWithTag:901];
    ///为效果而加
    for (UIStackView *stackView in mainStackView.arrangedSubviews) {
        stackView.spacing = 4.f;
    }
}

-(void)dealloc{
    DebugLog(@"");
}

+(instancetype)controller{
    SharedViewController *controller = [[SharedViewController alloc] init];
    controller.actions = [NSMutableArray array];
    return controller;
}

#pragma mark - UIViewControllerTransitioningDelegate
- (nullable UIPresentationController *)presentationControllerForPresentedViewController:(UIViewController *)presented presentingViewController:(nullable UIViewController *)presenting sourceViewController:(UIViewController *)source{
    return [[SharedPresnetation alloc ] initWithPresentedViewController:presented presentingViewController:presenting];
}

-(void)initStackView{
    UIStackView *stackView = [[UIStackView alloc] init];
    stackView.tag = 901;
    stackView.axis = UILayoutConstraintAxisHorizontal;
    stackView.distribution = UIStackViewDistributionFillEqually;
    stackView.alignment = UIStackViewAlignmentCenter;
    [self.view addSubview:stackView];
}

-(void)initMenuItem{
    if(!self.actions) return;
    for (int i= 0; i < self.actions.count; i++) {
        SharedAction *action = [self.actions objectAtIndex:i];
        NSString *title = action.title;
        UIImage *image = action.image;
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setImage:image forState:UIControlStateNormal];
        btn.tag = 10+i;
        [btn addTarget:self action:@selector(pressButton:) forControlEvents:UIControlEventTouchUpInside];
        
        UILabel *label = [[UILabel alloc] init];
        label.textColor = RGB(0x666666);
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:15.f];
        label.text = title;
        [label addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[label(<=30)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(label)]];
        
        UIStackView *sView = [[UIStackView alloc] initWithArrangedSubviews:@[btn, label]];
        sView.userInteractionEnabled = YES;
        sView.axis = UILayoutConstraintAxisVertical;
        sView.distribution = UIStackViewDistributionFill;
        sView.alignment = UIStackViewAlignmentFill;
        
        UIStackView *mainStack = [self.view viewWithTag:901];
        [mainStack addArrangedSubview:sView];
    }
}

#pragma mark - Public
-(void)addAction:(SharedAction*)action{
    [self.actions addObject:action];
}

#pragma mark - Action
-(void)pressButton:(UIButton*)button{
    NSInteger tag = button.tag - 10;
    SharedAction *action = [self.actions objectAtIndex:tag];
    action.handler(action);
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end

@implementation SharedPresnetation

-(CGRect)frameOfPresentedViewInContainerView{
    CGRect mainFrame = [UIScreen mainScreen].bounds;
    return CGRectMake(10, CGRectGetHeight(mainFrame) - 120.f - 20.f, CGRectGetWidth(mainFrame) - 20.f, 120.f);
}

@end

@implementation SharedAction

+(instancetype)actionWithTitle:(NSString*)title image:(UIImage*)image handler:(void(^)(SharedAction* action)) handler{
    SharedAction *action = [[SharedAction alloc] init];
    action.title = title;
    action.image = image;
    action.handler = handler;
    return action;
}

@end
