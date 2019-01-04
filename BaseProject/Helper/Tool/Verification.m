//
//  Verification.m
//  BaseProject
//
//  Created by 张熔冰 on 2017/6/15.
//  Copyright © 2017年 lovcreate. All rights reserved.
//

#import "Verification.h"

NSString* const kRegexEmail = @"^\\w+([-+.]\\w+)*@\\w+([-.]\\w+)*\\.\\w+([-.]\\w+)*$";//邮箱
NSString* const kRegexIDCard = @"^(^[1-9]\\d{7}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])\\d{3}$)|(^[1-9]\\d{5}[1-9]\\d{3}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])((\\d{4})|\\d{3}[Xx])$)$";//身份证号
NSString* const kRegexPhone = @"^((13[0-9])|(15[^4,\\D])|(18[0,0-9])|(14[579])|(17[013678]))\\d{8}$";//移动电话
NSString* const kRegexTelephone = @"^[0-9]{0,20}$";//国内电话号码
NSString* const kRegexChinese = @"^[\u4e00-\u9fa5]{0,}$";
NSString* const kRegexNumber = @"\\d{0,}";
NSString* const kRegexBankCard = @"\\d{15}|\\d{19}";
NSString* const kRegexMoney = @"^([0-9]+|[0-9]{1,3}(,[0-9]{3})*)(.[0-9]{1,2})?$";
NSString* const kRegexPassword = @"^[a-zA-Z\\d_]{6,16}$";//密码
NSString* const kRegexCode = @"^\\d{4}$|^\\d{6}$";//验证码
NSString* const kRegexName = @"^[\u4e00-\u9fa5a-zA-z]{2,20}$";//真实姓名
NSString* const kRegexNickname = @"^[\u4e00-\u9fa5a-zA-z0-9]{0,15}$";//昵称
NSString* const kRegexAge = @"^[0-9]{1,3}$";//年龄
NSString* const kRegexAddress = @"^[\u4e00-\u9fa5a-zA-z0-9]{0,30}$";//地址

@interface Verification()

@property(nonatomic, strong) NSMutableDictionary* verificationDic;
@property(nonatomic, strong) VerificationModel* curModel;
@property(nonatomic, strong) complateBlock block;

@end

@implementation Verification

#pragma mark - UITextFieldDelegate

-(instancetype)init{
    if (self = [super init]) {
        self.verificationDic = @{}.mutableCopy;
    }
    return self;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    NSArray * keys = self.verificationDic.allKeys;
    for (NSString* key in keys) {
        VerificationModel* model = [self.verificationDic objectForKey:key];
        if (model.textField == textField) {
            self.curModel = model;
            break;
        }
    }
}

-(void)verificationWith:(void(^)(Verification* verification)) block complateBlock:(complateBlock) complateBlock{
    self.block = complateBlock;
    block(self);
}

- (Verification *(^)(UITextField *))textField{
    return ^id(UITextField* textField){
        [textField addTarget:self action:@selector(textDidChanged:) forControlEvents:UIControlEventEditingChanged];
        textField.delegate = self;
        self.curModel = [[VerificationModel alloc] init];
        self.curModel.textField = textField;
        self.curModel.name = @"";
        self.curModel.regex = @"";
        self.curModel.max = NSIntegerMax;
        self.curModel.isNull = YES;
        self.curModel.isValid = YES;
        self.curModel.decimal = -1;
        [self setupMapping];
        return self;
    };
}

-(Verification *(^)(NSString* name))name{
    return ^id(NSString* name){
        self.curModel.name = name;
        [self setupMapping];
        return self;
    };
}

-(Verification *(^)(NSString* regex))regex{
    return ^id(NSString* regex){
        self.curModel.regex = regex;
        [self setupMapping];
        return self;
    };
}

-(Verification *(^)(NSInteger maxLength))max{
    return ^id(NSInteger max){
        self.curModel.max = max;
        [self setupMapping];
        return self;
    };
}

-(Verification *(^)(void))null{
    return ^id(){
        self.curModel.isNull = NO;
        [self setupMapping];
        return self;
    };
}


-(Verification *(^)(NSInteger decimal))decimal{
    return ^id(NSInteger decimal){
        self.curModel.decimal = decimal;
        [self setupMapping];
        return self;
    };
}

-(void)setupMapping{
    if (![self.curModel.name isEqualToString:@""]) {
        VerificationModel* model = [self.curModel copy];
        [self.verificationDic setObject:model forKey:self.curModel.name];
    }
}

-(VerificationModel*)isValid{
    NSArray* keys = [self.verificationDic allKeys];
    for (NSString* key in keys) {
        VerificationModel* model = [self.verificationDic objectForKey:key];
        if (model.isNull) {//允许为空
            if (!model.isValid) {
                [self.curModel.textField resignFirstResponder];
                return model;
            }
        }else if(model.textField.text.length == 0 && !model.isNull){
            model.msg = [NSString stringWithFormat:@"%@不能为空",model.name];
            [self.curModel.textField resignFirstResponder];
            return model;
        }else if (!model.isValid) {
            [self.curModel.textField resignFirstResponder];
            return model;
        }
        
    }
    return nil;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    NSString* content = [textField.text stringByReplacingCharactersInRange:range withString:string];
    
    //判断小数
    if (self.curModel.decimal != -1) {
        if ([textField.text containsString:@"."]) {
            if ([string isEqualToString:@"."]) {
                return NO;
            }
            NSArray* strArr = [content componentsSeparatedByString:@"."];
            if (strArr.count == 2) {
                NSString* decimalStr = [strArr lastObject];
                if (decimalStr.length > self.curModel.decimal) {
                    return NO;
                }
            }
        }
    }
    
    NSString* lang = [textField.textInputMode primaryLanguage];
    if ([lang isEqualToString:@"zh-Hans"]) {//中文输入
        //获取高亮部分
        UITextRange* selectedRange = [textField markedTextRange];
        UITextPosition* position = [textField positionFromPosition:selectedRange.start offset:0];
        if (!position) {
            if (content.length > self.curModel.max) {
//                textField.text = [string substringToIndex:self.curModel.max];
                return NO;
            }
        }
    }else{
        if (content.length > self.curModel.max) {
            NSRange rangeIndex = [content rangeOfComposedCharacterSequenceAtIndex:self.curModel.max];
            if (rangeIndex.length == 1) {
//                textField.text = [string substringToIndex:self.curModel.max];
                return NO;
            }else{
                NSRange rangeRange = [content rangeOfComposedCharacterSequencesForRange:NSMakeRange(0, self.curModel.max)];
                textField.text = [content substringWithRange:rangeRange];
            }
        }
    }
    return YES;
}

-(void)textDidChanged:(UITextField*) textField{
    NSString* string = textField.text;
    if (string.length == 0) {
        if (!self.curModel.isNull) {
            self.curModel.isValid = NO;
            self.curModel.msg = [NSString stringWithFormat:@"%@不能为空",self.curModel.name];
        }
        if (self.block) {
            self.block(self.curModel);
        }
        return;
    }
    
    self.curModel.text = textField.text;
    NSString* entiretyRegex = self.curModel.regex;
    if ([entiretyRegex isEqualToString:@""]) {
        if (self.curModel.isNull == (string.length == 0)) {
            self.curModel.isValid = YES;
            self.curModel.msg = @"";
        }
        if (self.block) {
            self.block(self.curModel);
        }
        return;
    }
    NSPredicate *prd2  = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", entiretyRegex];
    BOOL entiretyEnable = [prd2 evaluateWithObject:textField.text];
    if (!entiretyEnable) {
        self.curModel.isValid = NO;
        self.curModel.msg = [NSString stringWithFormat:@"%@格式错误", self.curModel.name];
        if (self.block) {
            self.block(self.curModel);
        }
    }else{
        self.curModel.isValid = YES;
        self.curModel.msg = @"";
        if (self.block) {
            self.block(self.curModel);
        }
    }
}

@end

#pragma mark - VerificationModel CLASS

@implementation VerificationModel

- (id)copyWithZone:(nullable NSZone *)zone{
    VerificationModel* model = [[VerificationModel allocWithZone:zone] init];
    model.regex = self.regex;
    model.name = self.name;
    model.textField = self.textField;
    model.max = self.max;
    model.msg = self.msg;
    model.isNull = self.isNull;
    model.isValid = self.isValid;
    model.decimal = self.decimal;
    return model;
}

#pragma mark - OverWrite
-(BOOL)isEqual:(id)object{
    Verification *v = (Verification*)object;
    return [v.name isEqualToString:self.name];
}

@end
