//
//  BaseCellModel.h
//  BaseProject
//
//  Created by 张熔冰 on 2017/11/6.
//  Copyright © 2017年 lovcreate. All rights reserved.
//

#import "BaseModel.h"

@interface BaseCellModel : BaseModel

@property(nonatomic, strong) NSString* title;
@property(nonatomic, strong) NSString* content;
@property(nonatomic, strong) NSString* placeholder;
@property(nonatomic, assign) BOOL isSelected;
@property(nonatomic, assign) BOOL isAssonary;

@end
