//
//  EEDODictionary.h
//  EEDOPHONE
//
//  Created by zhangrongbing on 16/6/29.
//  Copyright © 2016年 HuiHai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LCDictionary : NSObject

//添加对象
-(void)addObjectForKey:(NSString*)key value:(id) value;

//获取key对应的链表
-(NSArray*)objectForKey:(NSString*)key;

//所有的KEY值
-(NSArray*)allKeys;

//总的对象的数量
-(NSInteger)dataCount;

//添加同类对象
-(void)addObjects:(LCDictionary*)eedoDictionary;//key - value(NSArray)

//删除所有对象
-(void)removeAll;

//获取所有对象
-(NSArray*)allObjects;

@end
