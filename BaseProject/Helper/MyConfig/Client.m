//
//  Client.m
//  BaseProject
//
//  Created by 张熔冰 on 2019/3/7.
//  Copyright © 2019年 Lovcreate. All rights reserved.
//

#import "Client.h"
#import "MJExtension.h"
#import "NetworkingManager.h"

@implementation Client

MJCodingImplementation

-(void)setUserModel:(UserModel *)userModel{
    NSAssert(userModel, @"userModel is not nil");
    kSetUserDefaults(userModel, @"UserModel");
}

-(UserModel*)userModel{
    UserModel *userModel = kGetUserDefaults(@"UserModel");
    if (kISNullObject(userModel)) {
        return [UserModel new];
    }
    return userModel;
}

SINGLE_M(Client);
-(void)clean{
    [NetworkingManager sharedInstance].token = @"";
    self.userModel = [UserModel new];
}

-(BOOL)isLogin{
    NSString *username = self.userModel.username;
    return !kISNullString(username);
}
@end

@implementation UserModel

MJCodingImplementation

@end
