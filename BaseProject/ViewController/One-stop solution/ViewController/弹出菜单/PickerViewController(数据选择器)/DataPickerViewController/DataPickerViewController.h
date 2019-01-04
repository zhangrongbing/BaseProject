//
//  DataPickerViewController.h
//  BaseProject
//
//  Created by 张熔冰 on 2018/7/3.
//  Copyright © 2018年 Lovcreate. All rights reserved.
//

#import "PickerSheetViewController.h"

@interface DataPickerViewController : PickerSheetViewController

@property(nonatomic, strong) UIColor *backgroundColor;


+(instancetype)dataPickerControllerWithTitle:(NSString *) title data:(NSArray*) data handler:(void(^)(NSInteger index)) handler;

@end
