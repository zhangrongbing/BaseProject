//
//  WeatherCityOperation.h
//  BaseProject
//
//  Created by 张熔冰 on 2018/8/28.
//  Copyright © 2018年 Lovcreate. All rights reserved.
//

#import "BaseOperation.h"
#import "CityModel.h"

@interface WeatherCityOperation : BaseOperation

@property(nonatomic, strong) NSArray<CityModel*> *data;

@end
