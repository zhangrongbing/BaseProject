//
//  NetworkingManager.h
//  BaseProject
//
//  Created by zhangrongbing on 16/9/26.
//  Copyright © 2016年 lovcreate. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
#import "BaseOperation.h"
#import "Constant.h"

typedef void(^handler)(NSInteger state);

@class  BaseViewController;

@interface NetworkingManager : NSObject

/**
 加入操作类，访问服务器
 
 @param baseOperation 接口操作类
 */
+(void) asyncOperation:(BaseOperation*)baseOperation handler:(handler)handler;


/**
 加入操作类，访问服务器

 @param baseOperation 接口操作类
 @param handler 回调块
 @param headerField 往请求头加入参数
 */
+(void) asyncOperation:(BaseOperation*)baseOperation handler:(handler)handler headerField:(NSDictionary<NSString*, NSString*>*)headerField;
@end

