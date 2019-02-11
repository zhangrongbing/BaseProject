//
//  BaseOperation.m
//  BaseProject
//
//  Created by 张熔冰 on 2017/12/25.
//  Copyright © 2017年 lovcreate. All rights reserved.
//

#import "BaseOperation.h"
#import "ToastManager.h"
#import "HudManager.h"
#import "NetworkingManager.h"
#import "MyConfig.h"

@implementation BaseOperation

-(instancetype)init{
    if (self = [super init]) {
        self.action = @"";
        self.method = @"post";
        self.timeoutInterval = 6;
        self.isSerialize = YES;
        self.isHiddenKeyboard = YES;
        self.autoLogin = YES;
        self.isShowHud = YES;
        self.isShowLog = YES;
    }
    return self;
}

-(instancetype)initWithTarget:(id)target{
    return [self initWithTarget:target params:@{}];
}

-(instancetype)initWithTarget:(id)target params:(id)params{
    if (self = [self init]) {
        self.target = target;
        self.params = params;
    }
    return self;
}

-(NSString*)action{
    NSAssert(_action, @"action is not nil!!");
    
    NSString* action = nil;
    if ([_params isKindOfClass:[NSDictionary class]]) {
        _params = [_params mutableCopy];
    }
    if ([_action hasPrefix:@"http:"] || [_action hasPrefix:@"https:"]) {
        action = _action;
    }else {
        action = [NSString stringWithFormat:@"%@", _action];
    }
    return action;
}

#pragma mark - Public
//即将要访问接口
-(void)willRequestForOperation:(BaseOperation*)operation{
    //开始转菊花
    if (self.isShowHud) {
        [[HudManager sharedInstance] showHud:YES];
    }
    if (self.isShowLog) {
        DebugLog(@"----------接口地址:%@----------\n***********传入参数***********token：%@\n%@\n", operation.action,[MyConfig sharedInstance].token, operation.params);
    }
}
//解析接口数据
-(void)operation:(BaseOperation*)operation baseModel:(BaseModel*)baseModel{
    if (self.isShowHud) {
        [[HudManager sharedInstance] hide:YES];
    }
    if (self.isShowLog) {
        DebugLog(@"----------接口返回数据:----------\n%@", baseModel.mj_JSONString);
    }
}

-(NSMutableDictionary*)headerKeyValues{
    NSString *token = [MyConfig sharedInstance].token;
    if (token) {
        return @{@"token":token}.mutableCopy;
    }
    return @{}.mutableCopy;
}

-(void)dealloc{
    DebugLog(@"");
}
@end

