//
//  BaseOperation.h
//  BaseProject
//
//  Created by 张熔冰 on 2017/12/25.
//  Copyright © 2017年 lovcreate. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MyConfig.h"
#import "BaseModel.h"
#import "MJExtension.h"
#import "NSObject+Addition.h"

@class BaseViewController;

@interface BaseOperation : NSObject

@property(nonatomic, strong) id target;//UIViewController 或者 UIView
@property(nonatomic, strong) NSString* action; //接口地址
@property(nonatomic, strong) NSString* extensibleAction; //接口地址 扩展
@property(nonatomic, strong) id params; //接口传入参数
@property(nonatomic, strong) NSString* method;//请求方法 update delete put post get 
@property(nonatomic, strong) BaseModel* baseModel;
@property(nonatomic) BOOL autoLogin;//访问接口是否需要 登录状态  默认为YES
@property(nonatomic, assign) BOOL isSerialize; //请求参数是否需要序列化
@property(nonatomic, assign) NSTimeInterval timeoutInterval;//默认超时时间 6s
@property(nonatomic, assign) BOOL isHiddenKeyboard;//访问接口时收回键盘
@property(nonatomic, assign) BOOL isShowHud;
@property(nonatomic, assign) BOOL isShowLog;

//初始化方法
-(instancetype)initWithTarget:(id)target params:(id)params;

/**
 解析接口

 @param operation 接口操作类
 @param baseModel 返回基类对象
 */
-(void)operation:(BaseOperation*)operation baseModel:(BaseModel*)baseModel;

/**
 接口将要被访问、此时可以弹菊花

 @param operation 接口操作类
 */
-(void)willRequestForOperation:(BaseOperation*)operation;

/**
 在请求头部中加入参数

 @return 要加入的参数
 */
-(NSMutableDictionary*)headerKeyValues;

@end

