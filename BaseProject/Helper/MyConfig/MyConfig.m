//
//  MyConfig.m
//  BaseProject
//
//  Created by zhangrongbing on 16/9/26.
//  Copyright © 2016年 lovcreate. All rights reserved.
//

#import "MyConfig.h"
#import "UIImage+Addition.h"
#import "IQKeyboardManager.h"
#import "UIColor+Addition.h"

@implementation MyConfig

SINGLE_M(MyConfig);

-(instancetype)init{
    if (self = [super init]) {
        UserModel* user = [UserModel new];
        user.username = @"17743035566";
        user.userId = @"10086";
        user.passwrod = @"qqq123";
        user.nickname = @"我是好人冰";
        [self setUser:user];
        _defaultUser = user;
    }
    return self;
}

-(void)configGlobalApperance{
    IQKeyboardManager* manager = [IQKeyboardManager sharedManager];
    [manager setEnableAutoToolbar:NO];
    manager.shouldResignOnTouchOutside = YES;
    [manager setEnable:NO];
    
    //APP样式
    [UITableView appearance].keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    [UITableView appearance].separatorColor = [UIColor tableViewSeparatorColor];
}

//UserModel
-(void)setUser:(UserModel *)userModel{
    if (!userModel) {
        userModel = [UserModel new];
    }
    NSData* userData = [NSKeyedArchiver archivedDataWithRootObject:userModel];
    [[NSUserDefaults standardUserDefaults] setObject:userData forKey:UserKey];
}

-(UserModel*)user{
    NSData* userData = [[NSUserDefaults standardUserDefaults] objectForKey:UserKey];
    UserModel* userModel = [NSKeyedUnarchiver unarchiveObjectWithData:userData];
    if (!userModel) {
        userModel = [UserModel new];
    }
    return userModel;
}

-(void)setToken:(NSString *)token{
    if (!token) {
        token = @"";
    }
    [[NSUserDefaults standardUserDefaults] setObject:token forKey:TokenKey];
}

-(NSString*)token{
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:TokenKey];
    return token;
}

//判断是否登录了
-(BOOL)isLogin{
    if ([self.token isEqualToString:@""] || self.token == nil) {
        return NO;
    }
    return YES;
}

-(void)clean{
    self.token = nil;
    self.user = nil;
}

@end
