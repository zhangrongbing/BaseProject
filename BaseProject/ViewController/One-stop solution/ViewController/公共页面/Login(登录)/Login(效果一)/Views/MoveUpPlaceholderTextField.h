//
//  MoveUpPlaceholderTextField.h
//  BaseProject
//
//  Created by 张熔冰 on 2018/9/12.
//  Copyright © 2018年 Lovcreate. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, VerificationStyle){
    VerificationStyleNormal = 0,
    VerificationStylePass,
    VerificationStyleNoPass
};

typedef void(^textChangedBlock)(NSString *text, BOOL matched);

@interface MoveUpPlaceholderTextField : UIView

@property(nonatomic, strong) NSString *placeholder;
@property(nonatomic, strong) UIColor *placeholderColor;

@property(nonatomic, strong, readonly) UITextField *textField;
@property(nonatomic, strong) UIColor *textColor;
@property(nonatomic, strong) NSString* regex;

@property(nonatomic, assign) VerificationStyle style;
@property(nonatomic, strong) textChangedBlock textChangedBlock;

@end
