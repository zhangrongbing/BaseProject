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

+(id)mj_replacedKeyFromPropertyName121:(NSString *)propertyName{
    if ([propertyName isEqualToString:@"_id"]) {
        return @"id";
    }else if ([propertyName isEqualToString:@"state"]) {
        return @"error_code";
    }else if ([propertyName isEqualToString:@"message"]) {
        return @"reason";
    }else if ([propertyName isEqualToString:@"mapData"]) {
        return @"result";
    }
    return propertyName;
}

-(id)mj_newValueFromOldValue:(id)oldValue property:(MJProperty *)property{
    if (oldValue == nil || [oldValue isEqual:[NSNull null]]) return @"";
    return oldValue;
}

-(id)returnData{
//    return [self.mapData objectForKey:@"_Return_Data_"];
    return _mapData;
}
@end
