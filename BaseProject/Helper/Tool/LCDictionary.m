//
//  EEDODictionary.m
//  EEDOPHONE
//  {@"":[]}
//  Created by zhangrongbing on 16/6/29.
//  Copyright © 2016年 HuiHai. All rights reserved.
//

#import "LCDictionary.h"

@implementation LCDictionary{
    NSMutableArray* values;
    NSMutableDictionary* dic;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        dic = @{}.mutableCopy;
    }
    return self;
}

-(void)addObjectForKey:(NSString*)key value:(id) value{
    if (!value) {
        return;
    }
    //判断该KEY 是否有对应的值，有就继续插入链表，无则建立链表
    values = [dic objectForKey:key];
    if (values) {
        if ([value isKindOfClass:[NSArray class]]) {
            [values addObjectsFromArray:value];
        }else{
            [values addObject:value];
        }
    }else{
        values = @[].mutableCopy;
        if ([value isKindOfClass:[NSArray class]]) {
            [values addObjectsFromArray:value];
        }else {
            [values addObject:value];
        }
    }
    [dic setObject:values forKey:key];
}

-(NSArray*)objectForKey:(NSString*)key{
    if (dic) {
        return [dic objectForKey:key];
    }
    return nil;
}

-(NSArray*)allKeys{
    return [dic allKeys];
}

-(NSArray*)allObjects{
    NSMutableArray* tempArr = @[].mutableCopy;
    NSArray* allKeys = [self allKeys];
    for (int i = 0 ; i < allKeys.count; i++) {
        NSArray* data = [self objectForKey:allKeys[i]];
        [tempArr addObjectsFromArray:data];
    }
    return tempArr;
}
-(NSInteger)dataCount{
    int count = 0;
    for (NSString* key in [self allKeys]) {
        count += [self objectForKey:key].count;
    }
    return count;
}

-(void)addObjects:(LCDictionary*)eedoDictionary{
    NSArray* allKey = [eedoDictionary allKeys];
    for (int i = 0; i < allKey.count; i++) {
        for (int j = 0; j < [eedoDictionary objectForKey:allKey[i]].count; j++) {
            [self addObjectForKey:allKey[i] value:[eedoDictionary objectForKey:allKey[i]][j]];
        }
    }
}
-(void)removeAll{
    [dic removeAllObjects];
}

@end
