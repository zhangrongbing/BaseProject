//
//  TwoOperation.m
//  BaseProject
//
//  Created by 张熔冰 on 2018/11/14.
//  Copyright © 2018年 Lovcreate. All rights reserved.
//

#import "TwoOperation.h"

@implementation TwoOperation

-(instancetype)init{
    if (self = [super init]) {
        self.action = @"http://v.juhe.cn/historyWeather/citys";
        self.isSerialize = NO;
        self.isShowLog = NO;
        self.isShowHud = NO;
        self.name = @"接口二";
    }
    return self;
}

-(void)operation:(BaseOperation *)operation baseModel:(BaseModel *)baseModel{
    [super operation:operation baseModel:baseModel];
}

@end
