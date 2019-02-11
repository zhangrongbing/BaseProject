//
//  WeatherOperation.m
//  BaseProject
//
//  Created by 张熔冰 on 2018/8/28.
//  Copyright © 2018年 Lovcreate. All rights reserved.
//

#import "WeatherOperation.h"

@implementation WeatherOperation

-(instancetype)init{
    if (self = [super init]) {
        self.action = @"http://v.juhe.cn/historyWeather/weather";
        self.isSerialize = NO;
    }
    return self;
}

-(void)operation:(BaseOperation *)operation baseModel:(BaseModel *)baseModel{
    [super operation:operation baseModel:baseModel];
//    self.model = [WeatherModel mj_objectWithKeyValues:baseModel.mapData];
}

@end
