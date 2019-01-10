//
//  DialogController.m
//  BaseProject
//
//  Created by 张熔冰 on 2018/12/12.
//  Copyright © 2018年 Lovcreate. All rights reserved.
//

#import "DialogController.h"
#import "UIStackView+Separator.h"

#define RGB(c) [UIColor colorWithRed:((c>>16)&0xFF)/255.0    \
green:((c>>8)&0xFF)/255.0    \
blue:(c&0xFF)/255.0         \
alpha:1]

#define kDialogWidth 270.f
#define kDialogMinHeight 104
#define kActionHeight 44.f
#define kDialogSpacingLineColor RGB(0xCDCECE);

#define kScreenRect [UIScreen mainScreen].bounds

@class DialogPresentationController;
@class DialogAnimatedPresentation;
@class DialogAnimatedDismiss;

@interface DialogController()<UIViewControllerTransitioningDelegate>

@property(nonatomic, strong) NSString *dialogTitle;
@property(nonatomic, strong) NSString *dialogMessage;
@property(nonatomic, strong) NSMutableArray<DialogAction*> *actions;

@end

@implementation DialogController{
    CGRect _originalFrame;//弹窗的初始位置，在键盘弹出和消失布局是使用。
}

+(instancetype)dialogControllerWithTitle:(NSString*)title message:(nullable NSString*)message{
    DialogController *controller = [[DialogController alloc] init];
    controller.dialogTitle = title;
    controller.dialogMessage = message;
    controller.dismissForUserInterraction = YES;
    return controller;
}

-(instancetype)init{
    if (self = [super init]) {
        self.modalPresentationStyle = UIModalPresentationCustom;
        self.transitioningDelegate = self;
        self.actions = @[].mutableCopy;
        _textFields = @[].mutableCopy;
    }
    return self;
}

-(void)viewDidLoad{
    [super viewDidLoad];
    [self.view setTranslatesAutoresizingMaskIntoConstraints:NO];
    self.view.backgroundColor = [UIColor whiteColor];
    [self initTitleMessageStackView];
    [self initOperationStackView];
    [self initTextFieldUI];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShown:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillDismiss:) name:UIKeyboardWillHideNotification object:nil];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //关闭IQKeyboardManager
    Class class = NSClassFromString(@"IQKeyboardManager");
    if (class != nil) {
        SEL selector = NSSelectorFromString(@"sharedManager");
        IMP imp = [class methodForSelector:selector];
        id (*func)(id, SEL) = (void *)imp;
        id manager = func(class, selector);
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
        if ([manager respondsToSelector:@selector(setEnable:)]) {
            [manager performSelector:@selector(setEnable:) withObject:@(NO)];
        }
    }
#pragma clang diagnostic pop
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    _originalFrame = self.view.frame;
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    for (UITextField *textField in _textFields) {
        [textField resignFirstResponder];
    }
    //打开IQKeyboardManager
    Class class = NSClassFromString(@"IQKeyboardManager");
    if (class != nil) {
        SEL selector = NSSelectorFromString(@"sharedManager");
        IMP imp = [class methodForSelector:selector];
        id (*func)(id, SEL) = (void *)imp;
        id manager = func(class, selector);
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
        if ([manager respondsToSelector:@selector(setEnable:)]) {
            [manager performSelector:@selector(setEnable:) withObject:@(YES)];
        }
    }
#pragma clang diagnostic pop
}

-(void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    UIView *mainView = self.view;
    //contentView自动布局
    NSDictionary *hMetrics = @{@"DialogWidth":@(kDialogWidth)};
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[mainView(DialogWidth)]" options:0 metrics:hMetrics views:NSDictionaryOfVariableBindings(mainView)]];
    NSDictionary *vMetrics = @{@"DialogMinHeight":@(kDialogMinHeight)};
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[mainView(>=DialogMinHeight)]" options:0 metrics:vMetrics views:NSDictionaryOfVariableBindings(mainView)]];
    UIView *superView = self.view.superview;
    [superView addConstraint:[NSLayoutConstraint constraintWithItem:self.view attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:superView attribute:NSLayoutAttributeCenterX multiplier:1.f constant:0]];
    [superView addConstraint:[NSLayoutConstraint constraintWithItem:self.view attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:superView attribute:NSLayoutAttributeCenterY multiplier:1.f constant:0]];
    //title和message布局的横向布局
    UIStackView *titleMessageStackView = [self.view viewWithTag:801];
    NSDictionary *titleMessageStackViewSpacing_H = @{@"spacing":@13.f};
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-spacing-[titleMessageStackView]-spacing-|" options:0 metrics:titleMessageStackViewSpacing_H views:NSDictionaryOfVariableBindings(titleMessageStackView)]];
    //分割线布局
    UIView *specingLine = [self.view viewWithTag:501];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[specingLine]-0-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(specingLine)]];
    
    //operation布局
    UIStackView *operationStackView = [self.view viewWithTag:802];
    NSInteger count = operationStackView.arrangedSubviews.count;
    CGFloat operationItemHeight;
    if (count > 2) {
        operationItemHeight = kActionHeight*count;
    }else{
        operationItemHeight = kActionHeight;
    }
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[operationStackView]-0-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(operationStackView)]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-18-[titleMessageStackView]-18-[specingLine(1)]-0-[operationStackView(>=operationItemHeight)]-0-|" options:0 metrics:@{@"operationItemHeight":@(operationItemHeight)} views:NSDictionaryOfVariableBindings(titleMessageStackView, operationStackView, specingLine)]];
}

-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    self.view.layer.cornerRadius = 4.f;
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    DebugLog(@"");
}

#pragma mark - UIViewControllerTransitioningDelegate
- (nullable UIPresentationController *)presentationControllerForPresentedViewController:(UIViewController *)presented presentingViewController:(nullable UIViewController *)presenting sourceViewController:(UIViewController *)source{
    DialogPresentationController *presentation = [[DialogPresentationController alloc] initWithPresentedViewController:presented presentingViewController:presenting];
    presentation.dismissForUserInterraction = self.dismissForUserInterraction;
    return presentation;
}


- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source{
    return [DialogAnimatedPresentation new];
}

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed{
    return [DialogAnimatedDismiss new];
}

#pragma mark - init
-(void)initTitleMessageStackView{
    //标题
    UILabel *titleLabel = [UILabel new];
    titleLabel.text = self.dialogTitle;
    titleLabel.tag = 701;
    titleLabel.textColor = RGB(0x333333);
    titleLabel.font = [UIFont boldSystemFontOfSize:17.f];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.numberOfLines = 1;
    titleLabel.lineBreakMode = NSLineBreakByTruncatingMiddle;
    titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    
    UILabel *messageLabel = [UILabel new];
    messageLabel.text = self.dialogMessage;
    messageLabel.tag = 702;
    messageLabel.textColor = RGB(0x333333);
    messageLabel.font = [UIFont systemFontOfSize:12.f];
    messageLabel.textAlignment = NSTextAlignmentCenter;
    messageLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    messageLabel.numberOfLines = 3;
    messageLabel.translatesAutoresizingMaskIntoConstraints = NO;
    
    UIStackView *stackView = [[UIStackView alloc] initWithArrangedSubviews:@[titleLabel, messageLabel]];
    stackView.translatesAutoresizingMaskIntoConstraints = NO;
    stackView.tag = 801;
    stackView.spacing = 6.f;
    stackView.axis = UILayoutConstraintAxisVertical;
    stackView.distribution = UIStackViewDistributionFill;
    [self.view addSubview:stackView];
    
    UIView *specingLine = [[UIView alloc] init];
    specingLine.translatesAutoresizingMaskIntoConstraints = NO;
    specingLine.backgroundColor = kDialogSpacingLineColor;
    specingLine.tag = 501;
    [self.view addSubview:specingLine];
}

-(void)initOperationStackView{
    NSMutableArray *buttons = [NSMutableArray arrayWithCapacity:self.actions.count];
    for (int i = 0; i < self.actions.count; i++) {
        DialogAction *action = [self.actions objectAtIndex:i];
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
        btn.tag = i;
        [btn setTitle:action.title forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:17.f];
        [btn addTarget:self action:@selector(_pressActionButton:) forControlEvents:UIControlEventTouchUpInside];
        [buttons addObject:btn];
    }
    UIStackView *stackView = [[UIStackView alloc] initWithArrangedSubviews:buttons];
    stackView.spacing = 1.f;
    stackView.separatorColor = kDialogSpacingLineColor;
    stackView.separatorLength = CGFLOAT_MAX;
    stackView.separatorThickness = 1.f;
    stackView.translatesAutoresizingMaskIntoConstraints = NO;
    if (buttons.count > 2) {
        stackView.axis = UILayoutConstraintAxisVertical;
    }else{
        stackView.axis = UILayoutConstraintAxisHorizontal;
    }
    stackView.tag = 802;
    stackView.distribution = UIStackViewDistributionFillEqually;
    [self.view addSubview:stackView];
}

-(void)initTextFieldUI{
    UIStackView *stackView = [self.view viewWithTag:801];
    for (UITextField *textField in _textFields) {
        [textField addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[textField(==25)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(textField)]];
        [stackView addArrangedSubview:textField];
    }
}
#pragma mark - Selector
-(void)_pressActionButton:(UIButton*)button{
    NSInteger tag = button.tag;
    DialogAction *action = [self.actions objectAtIndex:tag];
    action.handler(action);
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)keyboardWillShown:(NSNotification*)notification{
    CGRect keyboardFrame = [[notification.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    NSTimeInterval time = [[notification.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    CGFloat difference = keyboardFrame.origin.y - CGRectGetMaxY(self.view.frame);
    __weak typeof(self) weakSelf = self;
    CGRect newFrame = self.view.frame;
    newFrame.origin.y += difference;
    if (difference < 0) {//Dialog被遮挡
        [UIView animateWithDuration:time animations:^{
            weakSelf.view.frame = newFrame;
        }];
    }
}

-(void)keyboardWillDismiss:(NSNotification*)notification{
    NSTimeInterval time = [[notification.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:time animations:^{
        weakSelf.view.frame = self->_originalFrame;
    }];
}
#pragma mark - Public
//添加操作按钮
-(void)addAction:(DialogAction*)action{
    [self.actions addObject:action];
}
//添加输入框
- (void)addTextFieldWithConfigurationHandler:(void (^ __nullable)(UITextField *textField))configurationHandler{
    UITextField *textfield = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, kDialogWidth, 25.f)];
    textfield.backgroundColor = [UIColor whiteColor];
    textfield.clearButtonMode = UITextFieldViewModeWhileEditing;
    textfield.layer.borderColor = RGB(0xCCCCCC).CGColor;
    textfield.layer.borderWidth = 1.f;
    textfield.borderStyle = UITextBorderStyleNone;
    textfield.leftViewMode = UITextFieldViewModeAlways;
    textfield.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 7, 0)];
    textfield.font = [UIFont systemFontOfSize:13.f];
    configurationHandler(textfield);
    textfield.translatesAutoresizingMaskIntoConstraints = NO;
    [_textFields addObject:textfield];
    //如果有输入框了就默认点击背景不消失
    self.dismissForUserInterraction = NO;
}
@end

@implementation DialogAction

+(instancetype)actionWithTitle:(NSString*)title handler:(void(^ __nullable)(DialogAction* action))handler{
    DialogAction *action = [[DialogAction alloc] initWithTitle:title handler:handler];
    return action;
}

-(instancetype)initWithTitle:(NSString*)title handler:(void(^ __nullable)(DialogAction* action))handler{
    if (self = [super init]) {
        _title = title;
        _handler = handler;
    }
    return self;
}

@end

#pragma mark - 弹出过度效果
@implementation DialogPresentationController{
    UIVisualEffectView *_visualView;
    UITapGestureRecognizer *_tap;
}

- (instancetype)initWithPresentedViewController:(UIViewController *)presentedViewController presentingViewController:(nullable UIViewController *)presentingViewController{
    if (self = [super initWithPresentedViewController:presentedViewController presentingViewController:presentingViewController]) {
        //磨玻璃效果
        UIBlurEffect *blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
        _visualView = [[UIVisualEffectView alloc] initWithEffect:blur];
        _visualView.alpha = 0;
    }
    return self;
}

- (CGRect)frameOfPresentedViewInContainerView{
    return CGRectZero;
}
//将要展示
-(void)presentationTransitionWillBegin{
    _visualView.frame = self.containerView.bounds;
    [self.containerView addSubview:_visualView];
    
    id<UIViewControllerTransitionCoordinator> coordinator = self.presentingViewController.transitionCoordinator;
    if (coordinator.animated) {
        [coordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
            self->_visualView.alpha = .6;
        } completion:nil];
    }else{
        _visualView.alpha = .6;
    }
    self.presnetAnimated = coordinator.animated;
}

-(void)presentationTransitionDidEnd:(BOOL)completed{
    if (completed) {
        if (self.dismissForUserInterraction) {
            _tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(_performActionForDissmiss:)];
            _tap.delegate = self;
            [self.presentedViewController.view addGestureRecognizer:_tap];
        }
    }
}

-(void)dismissalTransitionWillBegin{
    id<UIViewControllerTransitionCoordinator> coordinator = self.presentingViewController.transitionCoordinator;
    if (coordinator.isAnimated) {
        [coordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
            self->_visualView.alpha = 0.0;
        } completion:nil];
    }else{
        _visualView.alpha = 0.0;
    }
}

-(void)dismissalTransitionDidEnd:(BOOL)completed{
    [_visualView removeFromSuperview];
    _visualView = nil;
    [self.containerView removeGestureRecognizer:_tap];
}
#pragma mark - Selector
-(void)_performActionForDissmiss:(UITapGestureRecognizer*)tap{
    if ([tap.view isDescendantOfView:self.presentedView]) {
        [self.presentedViewController dismissViewControllerAnimated:YES completion:nil];
    }
}

#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    if (touch.view == self.presentedViewController.view) {
        return YES;
    }
    return NO;
}
@end

@implementation DialogAnimatedPresentation

- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext{
    return .2f;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext{
    UIView *containerView = [transitionContext containerView];
    UIViewController *toController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *toView = toController.view;
    [containerView addSubview:toView];
    
    toView.transform = CGAffineTransformMakeScale(1.1, 1.1);
    toView.alpha = 0.f;
    [UIView animateWithDuration:.2 animations:^{
        toView.transform = CGAffineTransformMakeScale(1, 1);
        toView.alpha = 1.f;
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:YES];
    }];
}
@end

@implementation DialogAnimatedDismiss

- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext{
    return .2f;
}
- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext{
    UIView *containerView = [transitionContext containerView];
    UIViewController *fromController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIView *fromView = fromController.view;
    [containerView addSubview:fromView];
    
    fromView.alpha = 1.f;
    fromView.transform = CGAffineTransformMakeScale(1, 1);
    [UIView animateWithDuration:.2 animations:^{
        fromView.transform = CGAffineTransformMakeScale(1.1, 1.1);
        fromView.alpha = 0.f;
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:YES];
        
    }];
}
@end

@implementation EvaluateController

+(void)showControllerForPresentingController:(UIViewController*)controller{
    DialogAction *spitAction = [DialogAction actionWithTitle:@"我要吐槽" handler:^(DialogAction * _Nonnull action) {
        
    }];
    DialogAction *rejectAction = [DialogAction actionWithTitle:@"残忍拒绝" handler:nil];
    //由于没有开发账号，这里先跳转到设置界面。
    DialogAction *goodAction = [DialogAction actionWithTitle:@"五星好评" handler:^(DialogAction * _Nonnull action) {
        if (@available(iOS 10, *)) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString] options:@{} completionHandler:^(BOOL success) {
                
            }];
        }else if(@available(iOS 8, *)){
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
        }else{
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"prefs:General&path=Reset"]];
        }
    }];
    DialogController *dialog = [DialogController dialogControllerWithTitle:@"提示" message:@"去给我们一些评价吧"];
    [dialog addAction:spitAction];
    [dialog addAction:rejectAction];
    [dialog addAction:goodAction];
    [controller presentViewController:dialog animated:YES completion:nil];
}

@end
