//
//  PickerSheetViewController.h
//  BaseProject
//
//  Created by 张熔冰 on 2018/8/9.
//  Copyright © 2018年 Lovcreate. All rights reserved.
//

#import "BaseAlertController.h"

#define kTitleViewHeight 40.f //标题高度

@class PickerAction;
@interface PickerSheetViewController : BaseAlertController

@property(nonatomic, strong) PickerAction* cancelAction;
@property(nonatomic, strong) PickerAction* confirmAction;
@property(nonatomic, strong) UILabel *titleLabel;


/**
 子类复写，确定按钮

 @param button 确定按钮
 */
-(void)performPressConfirmButton:(UIButton*)button;

@end

@interface PickerAction : NSObject

@property(nonatomic, strong) NSString *title;
@property(nonatomic, strong) UIColor *titleColor;
@property(nonatomic, strong) UIColor *backgroundColor;
@property(nonatomic, strong) UIImage *image;

-(instancetype)init NS_UNAVAILABLE;

+(instancetype)actionWithTitle:(nonnull NSString *)title titleColor:(nullable UIColor*)titleColor bgColor:(nullable UIColor*) bgcolor;
+(instancetype)actionWithImage:(nonnull UIImage*)image bgColor:(nullable UIColor*)bgcolor;

@end

@interface PickerSheetPresentation: BasePresentation

@end
