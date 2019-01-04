//
//  CityModel.h
//  BaseProject
//
//  Created by 张熔冰 on 2018/8/28.
//  Copyright © 2018年 Lovcreate. All rights reserved.
//

#import "BaseModel.h"

@interface CityModel : BaseModel

@property(nonatomic, strong) NSString* _id;
@property(nonatomic, strong) NSString* province_id;
@property(nonatomic, strong) NSString* city_name;

@end
