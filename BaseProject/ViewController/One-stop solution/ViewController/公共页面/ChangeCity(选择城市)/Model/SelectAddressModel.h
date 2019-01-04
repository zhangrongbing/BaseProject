//
//  SelectAddressModel.h
//  BaseProject
//
//  Created by 张熔冰 on 2018/8/30.
//  Copyright © 2018年 Lovcreate. All rights reserved.
//

#import "BaseModel.h"

@interface SelectAddressModel : BaseModel

@property(nonatomic, strong) NSString* label;
@property(nonatomic, strong) NSString* name;
@property(nonatomic, strong) NSString* pinyin;
@property(nonatomic, strong) NSString* zip;

@end
