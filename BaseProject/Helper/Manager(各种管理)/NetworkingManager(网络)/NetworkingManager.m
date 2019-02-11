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
#import "AFNetworkReachabilityManager.h"

static NSInteger kunLoginState = -1;

@interface NetworkingManager()

@property(nonatomic, strong) AFHTTPSessionManager * manager;

@end

@implementation NetworkingManager

SINGLE_M(NetworkingManager);

-(instancetype)init{
    if (self = [super init]) {
        NSString* baseUrlString;
        BOOL isDebug = YES;
#ifdef DEBUG
        baseUrlString = kBaseUrlString_DEV;
        isDebug = YES;
#else
        baseUrlString = kBaseUrlString_DIS;
        isDebug = NO;
#endif
        self.manager = [AFHTTPSessionManager manager];
        self.manager.securityPolicy.allowInvalidCertificates = isDebug;
        self.manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        self.manager.requestSerializer.timeoutInterval = 6.f;
        [self.manager.requestSerializer setValue:[MyConfig sharedInstance].token forHTTPHeaderField:@"token"];
        
        AFNetworkReachabilityManager *reachabilityManager = [AFNetworkReachabilityManager sharedManager];
        static dispatch_once_t token;
        dispatch_once(&token, ^{
            [reachabilityManager startMonitoring];
            [reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
                
            }];
        });
    }
    return self;
}

-(void) asyncOperation:(BaseOperation*)baseOperation handler:(handler)handler{
    [self asyncOperation:baseOperation handler:handler headerField:nil];
}


-(void)_successWithOperation:(BaseOperation*)baseOperation jsonObject:(id)responseObject block:(handler)block{
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
    if (baseOperation.baseModel.code == kunLoginState && baseOperation.autoLogin) {
        //弹出登录界面
        [[NSNotificationCenter defaultCenter] postNotificationName:kNotification_Logout object:nil];
    }else{
        if (block) {
            block(baseOperation.baseModel.code);
        }
    }
}

-(void)_failureWithBaseOperation:(BaseOperation*)baseOperation error:(NSError*)error block:(handler) block{
    BaseModel* baseModel = [BaseModel new];
    baseModel.code = -100;
    baseModel.msg = [self _errorMessage:error];
    baseModel.data = @{};
    [baseOperation operation:baseOperation baseModel:baseModel];
    [[ToastManager sharedInstance] showMessage:@"%@",baseModel.msg];
    
    NSData *data = error.userInfo[@"com.alamofire.serialization.response.error.data"] ;
    NSString *errorStr = [[ NSString alloc ] initWithData:data encoding:NSUTF8StringEncoding];
    DebugLog(@"----------访问失败ERROR：----------\n%@\n错误信息:%@", error, errorStr);
    if (block) {
        block(baseModel.code);
    }
}

-(void) asyncOperation:(BaseOperation*)baseOperation handler:(handler)handler headerField:(NSDictionary<NSString*, NSString*>*)headerField{
    for (NSString *key in headerField) {
        NSString *value = [headerField valueForKey:key];
        [self.manager.requestSerializer setValue:value forHTTPHeaderField:key];
    }
    if (headerField) {
        NSEnumerator* enumerator = [headerField keyEnumerator];
        NSString* key;
        while ((key = [enumerator nextObject])) {
            NSString *value = [headerField valueForKey:key];
            [self.manager.requestSerializer setValue:value forHTTPHeaderField:key];
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
        self.manager.requestSerializer = [AFJSONRequestSerializer serializer];
    }
    //设置请求头
    NSDictionary* dic = baseOperation.headerKeyValues;
    for (NSString* key in dic) {
        [self.manager.requestSerializer setValue:dic[key] forHTTPHeaderField:key];
    }
    
    self.manager.requestSerializer.timeoutInterval = baseOperation.timeoutInterval;
    if ([baseOperation.method isEqualToString:@"get"]) {
        [self.manager GET:baseOperation.action parameters:baseOperation.params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            [self _successWithOperation:baseOperation jsonObject:responseObject block:handler];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [self _failureWithBaseOperation:baseOperation error:error block:handler];
        }];
    }else if([baseOperation.method isEqualToString:@"post"]){
        [self.manager POST:baseOperation.action parameters:baseOperation.params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            [self _successWithOperation:baseOperation jsonObject:responseObject block:handler];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [self _failureWithBaseOperation:baseOperation error:error block:handler];
        }];
    }else if([baseOperation.method isEqualToString:@"put"]){
        [self.manager PUT:baseOperation.action parameters:baseOperation.params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            [self _successWithOperation:baseOperation jsonObject:responseObject block:handler];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [self _failureWithBaseOperation:baseOperation error:error block:handler];
        }];
    }else if([baseOperation.method isEqualToString:@"delete"]){
        [self.manager DELETE:baseOperation.action parameters:baseOperation.params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            [self _successWithOperation:baseOperation jsonObject:responseObject block:handler];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [self _failureWithBaseOperation:baseOperation error:error block:handler];
        }];
    }else{
        NSAssert(NO, @"---你在逗我玩---");
    }
}

- (NSString *)_errorMessage:(NSError *)error {
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

