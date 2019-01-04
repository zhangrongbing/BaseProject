//
//  UserModel.h
//  BaseProject
//
//  Created by zhangrongbing on 2016/11/28.
//  Copyright © 2016年 lovcreate. All rights reserved.
//

#import "BaseModel.h"

@interface UserModel : BaseModel

@property(nonatomic, strong) NSString* username;
@property(nonatomic, strong) NSString* passwrod;
@property(nonatomic, strong) NSString* nickname;//昵称
@property(nonatomic, strong) NSString* userId;//用处包括：数据库区分用户的库名
@property(nonatomic, strong) NSString* icon;//头像

@end
