//
//  NSArray+Addition.h
//  BaseProject
//
//  Created by zhangrongbing on 2016/9/29.
//  Copyright © 2016年 lovcreate. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSArray (Addition)

/**
 数组转字符串，通过separator字符隔开

 @param separator 间隔符

 @return 字符串
 */
-(NSString*)_stringBySeparator:(NSString*)separator;

/**
 复杂类型数组，根据数组里面的model的key值来组成一个字符串

 @param key       model中的属性名称
 @param separator 分隔符

 @return 字符串
 */
-(NSString*)_stringByKey:(NSString*)key separator:(NSString*)separator;

/**
 复杂类型数组，根据数组里面的model的key值来组成一个新的集合

 @param key model中的属性名称

 @return 复杂类型对象对应key值 生成的数组
 */
-(NSArray*)_arrayByKey:(NSString *)key;


@end

@interface NSMutableArray(Addition)

-(void)_removeObjectByKey:(NSString*)key value:(NSString*)value;

@end
