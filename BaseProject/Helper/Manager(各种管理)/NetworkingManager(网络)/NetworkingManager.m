//
//  NetworkingManager.m
//  BaseProject
//
//  Created by zhangrongbing on 16/9/26.
//  Copyright © 2016年 lovcreate. All rights reserved.
//

#import "NetworkingManager.h"
#import "UIView+Addition.h"
#import "UIImage+Addition.h"
#import "NSObject+Addition.h"
#import "BaseModel.h"
#import "ToastManager.h"
#import "Constant.h"
#import "MyConfig.h"

static NSInteger kunLoginState = -1;

@interface NetworkingManager()

@end

@implementation NetworkingManager

+(AFHTTPSessionManager*)manager{
    NSString* baseUrlString;
    BOOL isDebug = YES;
#ifdef _DEBUG
    baseUrlString = kBaseUrlString_DEV;
    isDebug = YES;
#else
    baseUrlString = kBaseUrlString_DIS;
    isDebug = NO;
#endif
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:baseUrlString]];
    manager.securityPolicy.allowInvalidCertificates = isDebug;
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.requestSerializer.timeoutInterval = 6.f;
    [manager.requestSerializer setValue:[MyConfig sharedInstance].token forHTTPHeaderField:@"token"];
    return manager;
}

+(void) asyncOperation:(BaseOperation*)baseOperation handler:(handler)handler{
    [[self class] asyncOperation:baseOperation handler:handler headerField:nil];
}


+(void)_successWithOperation:(BaseOperation*)baseOperation jsonObject:(id)responseObject block:(handler)block{
    __block id jsonObjcect = @"";
    if ([responseObject isKindOfClass:[NSString class]]) {
        jsonObjcect = responseObject;
    }else if([responseObject isKindOfClass:[NSData class]]){
        NSData* data = [[NSData alloc] initWithData:responseObject];
        jsonObjcect = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    }else if([responseObject isKindOfClass:[NSDictionary class]]){
        jsonObjcect = (NSDictionary*)responseObject;
    }
    BaseModel* baseModel = [BaseModel mj_objectWithKeyValues:jsonObjcect];
    [baseOperation operation:baseOperation baseModel:baseModel];
    
    //token是否过期了
    if (baseOperation.baseModel.state == kunLoginState && baseOperation.autoLogin) {
        //弹出登录界面
        [[NSNotificationCenter defaultCenter] postNotificationName:kNotification_Logout object:nil];
    }else{
        if (block) {
            block(baseOperation.baseModel.state);
        }
    }
}

+(void)_failureWithBaseOperation:(BaseOperation*)baseOperation error:(NSError*)error block:(handler) block{
    BaseModel* baseModel = [BaseModel new];
    baseModel.state = -100;
    baseModel.message = [self _errorMessage:error];
    baseModel.returnStatus = @"";
    baseModel.mapData = @{};
    [baseOperation operation:baseOperation baseModel:baseModel];
    [[ToastManager sharedInstance] showMessage:@"%@",baseModel.message];
    
    NSData *data = error.userInfo[@"com.alamofire.serialization.response.error.data"] ;
    NSString *errorStr = [[ NSString alloc ] initWithData:data encoding:NSUTF8StringEncoding];
    DebugLog(@"----------访问失败ERROR：----------\n%@\n错误信息:%@", error, errorStr);
    if (block) {
        block(baseModel.state);
    }
}

+(void) asyncOperation:(BaseOperation*)baseOperation handler:(handler)handler headerField:(NSDictionary<NSString*, NSString*>*)headerField{
    AFHTTPSessionManager* manager = [[self class] manager];
    for (NSString *key in headerField) {
        NSString *value = [headerField valueForKey:key];
        [manager.requestSerializer setValue:value forHTTPHeaderField:key];
    }
    if (headerField) {
        NSEnumerator* enumerator = [headerField keyEnumerator];
        NSString* key;
        while ((key = [enumerator nextObject])) {
            NSString *value = [headerField valueForKey:key];
            [manager.requestSerializer setValue:value forHTTPHeaderField:key];
        }
    }
    if ([baseOperation.target isKindOfClass:[UIViewController class]]) {
        UIViewController* controller = ((UIViewController*)baseOperation.target);
        if (baseOperation.isHiddenKeyboard) {
            [controller.view endEditing:YES];
        }
    }
    //显示等待视图
    [baseOperation willRequestForOperation:baseOperation];
    //请求是否序列化
    if (baseOperation.isSerialize) {
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
    }
    //设置请求头
    NSDictionary* dic = baseOperation.headerKeyValues;
    for (NSString* key in dic) {
        [manager.requestSerializer setValue:dic[key] forHTTPHeaderField:key];
    }
    
    manager.requestSerializer.timeoutInterval = baseOperation.timeoutInterval;
    if ([baseOperation.method isEqualToString:@"get"]) {
        [manager GET:baseOperation.action parameters:baseOperation.params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            [self _successWithOperation:baseOperation jsonObject:responseObject block:handler];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [self _failureWithBaseOperation:baseOperation error:error block:handler];
        }];
    }else if([baseOperation.method isEqualToString:@"post"]){
        [manager POST:baseOperation.action parameters:baseOperation.params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            [self _successWithOperation:baseOperation jsonObject:responseObject block:handler];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [self _failureWithBaseOperation:baseOperation error:error block:handler];
        }];
    }else if([baseOperation.method isEqualToString:@"put"]){
        [manager PUT:baseOperation.action parameters:baseOperation.params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            [self _successWithOperation:baseOperation jsonObject:responseObject block:handler];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [self _failureWithBaseOperation:baseOperation error:error block:handler];
        }];
    }else if([baseOperation.method isEqualToString:@"delete"]){
        [manager DELETE:baseOperation.action parameters:baseOperation.params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            [self _successWithOperation:baseOperation jsonObject:responseObject block:handler];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [self _failureWithBaseOperation:baseOperation error:error block:handler];
        }];
    }else{
        NSAssert(NO, @"---你在逗我玩---");
    }
}

+ (NSString *)_errorMessage:(NSError *)error {
    NSString *msg;
    if (error.code == -1) {
        msg = @"服务器打瞌睡了";
    }else if (error.code == -1001 || error.code == -2000) {
        msg = @"当前网络不佳，请稍后重试";
    }else {
        msg = @"网络未连接，请检查网络";
    }
    return msg;
}


@end

