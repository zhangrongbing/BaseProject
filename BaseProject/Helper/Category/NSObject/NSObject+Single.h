//
//  NSObject+Single.h
//  BaseProject
//
//  Created by 张熔冰 on 2018/6/17.
//  Copyright © 2018年 lovcreate. All rights reserved.
//

#import <Foundation/Foundation.h>


//单例
#define SINGLE_H(_type_) + (_type_ *)sharedInstance;\
+(instancetype) alloc __attribute__((unavailable("我是单例，请尊重我!")));\
+(instancetype) new __attribute__((unavailable("我是单例，请尊重我!")));\
-(instancetype) copy __attribute__((unavailable("我是单例，请尊重我!")));\
-(instancetype) mutableCopy __attribute__((unavailable("我是单例，请尊重我!")));\

#define SINGLE_M(_type_) + (_type_ *)sharedInstance{\
static _type_ *theSharedInstance = nil;\
static dispatch_once_t onceToken;\
dispatch_once(&onceToken, ^{\
theSharedInstance = [[super alloc] init];\
});\
return theSharedInstance;\
}

@interface NSObject (Single)

@end
