//
//  DataPickerViewController.m
//  BaseProject
//
//  Created by 张熔冰 on 2018/7/3.
//  Copyright © 2018年 Lovcreate. All rights reserved.
//

#import "DataPickerViewController.h"

@interface DataPickerViewController ()<UIPickerViewDelegate, UIPickerViewDataSource>

@property(nonatomic, strong) UIPickerView *pickerView;
@property(nonatomic, strong) NSArray *data;
@property(nonatomic, assign) NSInteger curIndex;
@property(nonatomic, strong) void(^handler)(NSInteger index);

@end

@implementation DataPickerViewController

+(instancetype)dataPickerControllerWithTitle:(NSString *) title data:(NSArray*) data handler:(void(^)(NSInteger index)) handler{
    DataPickerViewController* controller = [[DataPickerViewController alloc] init];
    controller.handler = handler;
    controller.data = data;
    controller.titleLabel.text = title;
    controller.backgroundColor = [UIColor clearColor];
    controller.cancelAction = [PickerAction actionWithImage:[UIImage imageNamed:@"小关闭"] bgColor:nil];
    controller.confirmAction = [PickerAction actionWithImage:[UIImage imageNamed:@"对勾"] bgColor:nil];
    return controller;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initPickerView];
}

//VFL
-(void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    UIPickerView *pickerView = self.pickerView;
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[pickerView]-0-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(pickerView)]];
    
    UIView *titleLabel = self.titleLabel;
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[titleLabel]-0-[pickerView]-0-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(titleLabel, pickerView)]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Action
//点击确定
-(void)performPressConfirmButton:(UIButton*)button{
    [super performPressConfirmButton: button];
    if (self.handler) {
        self.handler(self.curIndex);
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark - Public
//初始化
-(void)initPickerView{
    //picker
    self.pickerView = [[UIPickerView alloc] init];
    self.pickerView.translatesAutoresizingMaskIntoConstraints = NO;
    self.pickerView.delegate = self;
    self.pickerView.dataSource = self;
    self.pickerView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.pickerView];
}

#pragma mark - UIPickerViewDataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return [self.data count];
}

- (nullable NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    NSString *title = [self.data objectAtIndex:row];
    return title;
}

- (nullable NSAttributedString *)pickerView:(UIPickerView *)pickerView attributedTitleForRow:(NSInteger)row forComponent:(NSInteger)component{
    NSString *string = nil;
    NSArray *arr = (NSArray*)self.data;
    string = [arr objectAtIndex:row];
    NSMutableDictionary *dic = @{}.mutableCopy;
    dic[NSForegroundColorAttributeName] = [UIColor redColor];
    NSAttributedString *attrString = [[NSAttributedString alloc] initWithString:string attributes:dic];
    return attrString;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    self.curIndex = row;
}
@end
