//
//  DatePickerView.h
//  BaseProject
//
//  Created by 张熔冰 on 2018/8/8.
//  Copyright © 2018年 Lovcreate. All rights reserved.
//

#import "PickerSheetViewController.h"

@interface DatePickerViewController : PickerSheetViewController

@property(nonatomic, strong) UIDatePicker *pickerView;

+(instancetype)datePickerControllerWithTitle:(NSString *) title model:(UIDatePickerMode)model handler:(void(^)(NSDate *date)) handler;
@end
