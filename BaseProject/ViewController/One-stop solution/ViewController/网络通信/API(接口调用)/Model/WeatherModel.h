//
//  WeatherModel.h
//  BaseProject
//
//  Created by 张熔冰 on 2018/8/28.
//  Copyright © 2018年 Lovcreate. All rights reserved.
//

#import "BaseModel.h"

@interface WeatherModel : BaseModel

@property(nonatomic, strong) NSString* city_id;//城市地区ID
@property(nonatomic, strong) NSString* city_name;//城市地区名称
@property(nonatomic, strong) NSString* weather_date;//    天气日期
@property(nonatomic, strong) NSString* day_weather;//白天天气
@property(nonatomic, strong) NSString* night_weather;//夜间天气
@property(nonatomic, strong) NSString* day_temp;//白天最高温度
@property(nonatomic, strong) NSString* night_temp;//夜间最高温度
@property(nonatomic, strong) NSString* day_wind;//白天风向
@property(nonatomic, strong) NSString* day_wind_comp;//白天风力
@property(nonatomic, strong) NSString* night_wind;//夜间风向
@property(nonatomic, strong) NSString* night_wind_comp;//夜间风力
@property(nonatomic, strong) NSString* day_weather_id;//白天天气标示
@property(nonatomic, strong) NSString* night_weather_id;//夜间天气标示

@end
