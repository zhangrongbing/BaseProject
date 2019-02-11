//
//  PushManager.h
//  BaseProject
//
//  Created by 张熔冰 on 2019/1/9.
//  Copyright © 2019年 Lovcreate. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSObject+Single.h"

NS_ASSUME_NONNULL_BEGIN
@class PushManager;

@protocol PushManagerDelegate <NSObject>


@optional
/**
 接收到远程通知

 @param manager 管理对象
 @param userInfo 推送内容
 */
-(void)manager:(PushManager*)manager receiveRemoteNotification:(NSDictionary*)userInfo;

/**
 接受到三方透传消息

 @param manager 管理对象
 @param message 透传消息内容
 */
-(void)manager:(PushManager*)manager receiveRemoteMessgae:(NSString*)message;

@end

@interface PushManager : NSObject

SINGLE_H(PushManager);

@property(nonatomic, strong) id<PushManagerDelegate> delegate;


/**
 接受远程通知

 @param userInfo 通知内容
 */
-(void)didReceivePushData:(NSDictionary*)userInfo;

/**
 接受透传消息

 @param data 透传消息内容
 */
-(void)didReceiveMessageData:(NSString*)data;
@end

NS_ASSUME_NONNULL_END
