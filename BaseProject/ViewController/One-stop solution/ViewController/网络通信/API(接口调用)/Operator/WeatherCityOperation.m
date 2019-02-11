//
//  WeatherCityOperation.m
//  BaseProject
//
//  Created by 张熔冰 on 2018/8/28.
//  Copyright © 2018年 Lovcreate. All rights reserved.
//

#import "WeatherCityOperation.h"

@implementation WeatherCityOperation

-(instancetype)init{
    if (self = [super init]) {
        self.action = @"http://v.juhe.cn/historyWeather/citys";
        self.isSerialize = NO;
    }
    return self;
}

-(void)operation:(BaseOperation *)operation baseModel:(BaseModel *)baseModel{
    [super operation:operation baseModel:baseModel];
//    NSArray *citys = baseModel.mapData;
//    self.data = [CityModel mj_objectArrayWithKeyValuesArray:citys];
}

@end
