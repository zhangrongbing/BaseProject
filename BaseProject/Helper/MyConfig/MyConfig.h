//
//  MyConfig.h
//  BaseProject
//
//  Created by zhangrongbing on 16/9/26.
//  Copyright © 2016年 lovcreate. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "NSObject+Single.h"
#import "UserModel.h"

static NSString* UserKey = @"User";
static NSString* TokenKey = @"Token";

@interface MyConfig : NSObject

SINGLE_H(MyConfig);

@property(nonatomic, readonly) BOOL isLogin;//是否已经登录

//扩展属性----------------------start
@property(nonatomic, strong) UserModel *user;
@property(nonatomic, strong, readonly) UserModel *defaultUser;
@property(nonatomic, strong) NSString *token;
//扩展属性----------------------end

/**
 配置App的基本样式
 */
-(void)configGlobalApperance;
-(void)clean;

@end
