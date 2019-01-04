//
//  DataPickerViewController.m
//  BaseProject
//
//  Created by 张熔冰 on 2018/7/3.
//  Copyright © 2018年 Lovcreate. All rights reserved.
//

#import "DatePickerViewController.h"

#define RGB(c) [UIColor colorWithRed:((c>>16)&0xFF)/255.0    \
green:((c>>8)&0xFF)/255.0    \
blue:(c&0xFF)/255.0         \
alpha:1]

#define kTitleViewHeight 40.f //标题高度

@interface DatePickerViewController ()

@property(nonatomic, assign) UIDatePickerMode datePickerMode;
@property(nonatomic, strong) NSDate *curDate;
@property(nonatomic, strong) void(^handler)(NSDate *date);

@end

@implementation DatePickerViewController

+(instancetype)datePickerControllerWithTitle:(NSString *) title model:(UIDatePickerMode)model handler:(void(^)(NSDate *date)) handler{
    DatePickerViewController* controller = [[DatePickerViewController alloc] init];
    controller.handler = handler;
    controller.datePickerMode = model;
    controller.titleLabel.text = title;
    controller.titleLabel.backgroundColor = RGB(0xF3F3F3);
    controller.cancelAction = [PickerAction actionWithImage:[UIImage imageNamed:@"小关闭"] bgColor:nil];
    controller.confirmAction = [PickerAction actionWithImage:[UIImage imageNamed:@"对勾"] bgColor:nil];
    return controller;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initPickerView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    UIDatePicker *pickerView = self.pickerView;
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[pickerView]-0-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(pickerView)]];
    
    UIView *titleLabel = self.titleLabel;
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[titleLabel]-0-[pickerView]-0-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(titleLabel, pickerView)]];
}
#pragma mark - Action
//点击确定
-(void)performPressConfirmButton:(UIButton*)button{
    [super performPressConfirmButton: button];
    if (self.handler) {
        self.handler(self.curDate);
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)performDateChanged:(UIDatePicker*)picker {
    self.curDate = picker.date;
}
#pragma mark - Public
//初始化
-(void)initPickerView{
    self.curDate = [NSDate date];
    //picker
    self.pickerView = [[UIDatePicker alloc] init];
    self.pickerView.translatesAutoresizingMaskIntoConstraints = NO;
    self.pickerView.backgroundColor = [UIColor whiteColor];
    self.pickerView.datePickerMode = self.datePickerMode;
    [self.pickerView setCalendar:[NSCalendar currentCalendar]];
    [self.pickerView addTarget:self action:@selector(performDateChanged:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:self.pickerView];
}
@end
