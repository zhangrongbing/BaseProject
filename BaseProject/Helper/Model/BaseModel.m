//
//  BaseModel.m
//  BaseProject
//
//  Created by zhangrongbing on 16/9/26.
//  Copyright © 2016年 lovcreate. All rights reserved.
//

#import "BaseModel.h"
#import <MJExtension/MJExtension.h>

@implementation BaseModel

-(id)mj_newValueFromOldValue:(id)oldValue property:(MJProperty *)property{
    if (oldValue == nil || [oldValue isEqual:[NSNull null]]) return @"";
    return oldValue;
}
@end
