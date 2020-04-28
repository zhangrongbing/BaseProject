//
//  Client.h
//  BaseProject
//
//  Created by 张熔冰 on 2019/3/7.
//  Copyright © 2019年 Lovcreate. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSObject+Single.h"
#import <UIKit/UIKit.h>

@class UserModel;
NS_ASSUME_NONNULL_BEGIN

@interface Client : NSObject

@property(nonatomic, assign) BOOL isLogin;
@property(nonatomic, strong) UserModel *userModel;
@property(nonatomic, strong) UINavigationController *nav;
SINGLE_H(Client);

-(void)clean;

@end

@interface UserModel : NSObject

@property(nonatomic, strong) NSString* username;
@property(nonatomic, strong) NSString* passwrod;
@property(nonatomic, strong) NSString* nickname;//昵称
@property(nonatomic, strong) NSString* userId;//用处包括：数据库区分用户的库名
@property(nonatomic, strong) NSString* icon;//头像

@end

NS_ASSUME_NONNULL_END
