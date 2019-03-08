//
//  NSDictionary+Extension.h
//  ICUnicodeDemo
//
//  Created by andy  on 15/8/8.
//  Copyright (c) 2015年 andy . All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (Addition)


/**
 打印log专用方法

 @param locale 要打印的字典
 @return 转为字符串输出x
 */
-(NSString *)descriptionWithLocale:(id)locale;


/**
 字符串转字典

 @param string 字符串
 @return 字典
 */
-(NSDictionary*)_dictionaryWithString:(NSString*)string;


/**
 字典转字符串

 @return json字符串
 */
-(NSString*)_toJson;

@end
