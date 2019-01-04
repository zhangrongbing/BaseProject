//
//  Verification.h
//  BaseProject
//  一个验证控件是否匹配正则的工具类
//  Created by 张熔冰 on 2017/6/15.
//  Copyright © 2017年 lovcreate. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

extern NSString* const kRegexEmail;
extern NSString* const kRegexIDCard;
extern NSString* const kRegexPhone;
extern NSString* const kRegexTelephone;
extern NSString* const kRegexChinese;
extern NSString* const kRegexNumber;
extern NSString* const kRegexBankCard;
extern NSString* const kRegexMoney;
extern NSString* const kRegexPassword;
extern NSString* const kRegexCode;
extern NSString* const kRegexName;
extern NSString* const kRegexNickname;
extern NSString* const kRegexAge;
extern NSString* const kRegexAddress;

@class VerificationModel;

typedef void(^complateBlock)(VerificationModel* model);

@interface Verification : NSObject<UITextFieldDelegate>

-(void)verificationWith:(void(^)(Verification* verification)) block complateBlock:(complateBlock) complateBlock;
- (Verification *(^)(UITextField *))textField;
-(Verification *(^)(NSString* name))name;
-(Verification *(^)(NSString* regex))regex;
-(Verification *(^)(NSInteger maxLength))max;
-(Verification *(^)(void))null;
-(Verification *(^)(NSInteger decimal))decimal;

-(VerificationModel*)isValid;

@end

#pragma mark - VerificationModel CLASS

@interface VerificationModel : NSObject<NSCopying>

@property(nonatomic, strong) UITextField* textField;//监听的控件
@property(nonatomic, strong) NSString* name;//控件名称-也是唯一标识符。
@property(nonatomic, strong) NSString* regex;//正则表达式
@property(nonatomic, assign) NSInteger max;//最大字符数量
@property(nonatomic, assign) BOOL isNull;//是否允许为空
@property(nonatomic, assign) BOOL isValid;//是否验证通过
@property(nonatomic, strong) NSString* msg;//如果不通过的错误信息
@property(nonatomic, assign) NSInteger decimal;//保留几位小数
@property(nonatomic, strong) NSString* text;//内容

@end
