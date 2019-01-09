//
//  WebSocketManager.h
//  OrderCar
//
//  Created by zhangrongbing on 2017/1/16.
//  Copyright © 2017年 lovcreate. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSObject+Single.h"

@class WebSocketManager;

@protocol WebSocketManagerDelegate <NSObject>

-(void)webSocketManager:(WebSocketManager*)manager didReceiveMessage:(id)target message:(NSString*)message;

@end


@interface WebSocketManager : NSObject

@property(nonatomic, strong) id target;//用来区分模块

@property(nonatomic, weak) id<WebSocketManagerDelegate> delegate;

SINGLE_H(WebSocketManager);

//建立长连接
- (void)close;
-(void)sendData:(id)data;
@end
