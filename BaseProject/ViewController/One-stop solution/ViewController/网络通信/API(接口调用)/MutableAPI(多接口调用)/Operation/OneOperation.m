//
//  OneOperation.m
//  BaseProject
//
//  Created by 张熔冰 on 2018/11/14.
//  Copyright © 2018年 Lovcreate. All rights reserved.
//

#import "OneOperation.h"

@implementation OneOperation

-(instancetype)init{
    if (self = [super init]) {
        self.action = @"http://v.juhe.cn/historyWeather/province";
        self.isSerialize = NO;
        self.isShowLog = NO;
    }
    return self;
}

-(void)operation:(BaseOperation *)operation baseModel:(BaseModel *)baseModel{
    [super operation:operation baseModel:baseModel];
    @synchronized (self) {
        DebugLog(@"----------接口返回数据:----------\n%@", baseModel.mj_JSONString);
    }
}

@end
