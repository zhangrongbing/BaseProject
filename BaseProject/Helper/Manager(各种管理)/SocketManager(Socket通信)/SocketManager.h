//
//  SocketManager.h
//  BaseProject
//
//  Created by 张熔冰 on 2018/8/27.
//  Copyright © 2018年 Lovcreate. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSObject+Single.h"

typedef NS_ENUM(NSInteger, SocketManagerFailedCode){
    ConnectFailed = 0,//初始化失败
    Disconnect,//断开连接
};

@class SocketManager;
@protocol SocketManagerDelegate <NSObject>

@optional

-(void)socketManager:(SocketManager*)manager didConnectToHost:(NSString*) host onPort:(NSString*)port;
-(void)socketManager:(SocketManager *)manager didReceiveMessage:(NSString*)message;
-(void)socketManager:(SocketManager*)manager failedWithCode:(SocketManagerFailedCode)code error:(NSError *)error;
-(void)didSendMessageForSocketManager:(SocketManager*)manager;

@end

@interface SocketManager : NSObject

SINGLE_H(SocketManager);

@property(nonatomic, strong) id<SocketManagerDelegate> delegate;

-(void)connectToHost:(NSString *)host onPort:(NSString*)port;
-(void)disconnect;
-(void)sendMessage:(NSString*)msg;
-(void)sendData:(NSData*)data;
@end
