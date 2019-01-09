//
//  WebSocketManager.m
//  OrderCar
//
//  Created by zhangrongbing on 2017/1/16.
//  Copyright © 2017年 lovcreate. All rights reserved.
//

#import "WebSocketManager.h"

#import "AFNetworking.h"
#import "SocketRocket.h"
#import "MyConfig.h"
#import "NSString+Addition.h"
#import "Constant.h"

typedef void(^reConnectblock)(void);

@interface WebSocketManager()<SRWebSocketDelegate>

@property(nonatomic, strong) NSTimer* pingTimer;
@property(nonatomic, strong) AFNetworkReachabilityManager* reachabilityManager;//判断网络状态
@property(nonatomic, strong) SRWebSocket* webSocket;

@end

@implementation WebSocketManager

SINGLE_M(WebSocketManager);

-(instancetype)init{
    if (self = [super init]) {
        self.reachabilityManager = [AFNetworkReachabilityManager sharedManager];
        __weak __block typeof(self) weakSelf = self;
        [self.reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
            if (status == AFNetworkReachabilityStatusReachableViaWWAN|| status == AFNetworkReachabilityStatusReachableViaWiFi) {
                [weakSelf.webSocket open];
            }else{
                [weakSelf.pingTimer setFireDate:[NSDate distantFuture]];
            }
        }];
        [self.reachabilityManager startMonitoring];
    }
    return self;
}

- (void)close {
    [self.webSocket close];
    _pingTimer.fireDate = [NSDate distantFuture];
}

#pragma mark - 赖加载

-(SRWebSocket*)webSocket{
    if (!_webSocket) {
        NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:kLongConnection]];
        NSString* token = [MyConfig sharedInstance].token;
        [request setValue:token forHTTPHeaderField:@"token"];
        [request setValue:@"2" forHTTPHeaderField:@"userType"];
        _webSocket = [[SRWebSocket alloc] initWithURLRequest:request];
        _webSocket.delegate = self;
    }
    return _webSocket;
}

-(NSTimer*)pingTimer{
    if (!_pingTimer) {
        _pingTimer = [NSTimer timerWithTimeInterval:3.f target:self selector:@selector(pingTimerMethod:) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:_pingTimer forMode:NSDefaultRunLoopMode];
    }
    return _pingTimer;
}

#pragma mark - Public

//selector
-(void)pingTimerMethod:(NSTimer*)timer{
    if (self.webSocket.readyState == SR_OPEN) {
        [self.webSocket send:nil];
    }
}

#pragma mark - SRWebSocketDelegate
- (void)webSocket:(SRWebSocket *)webSocket didReceiveMessage:(id)message{
    DebugLog(@"message = %@",message);
    if (self.delegate && [self.delegate respondsToSelector:@selector(webSocketManager:didReceiveMessage:message:)]) {
        [self.delegate webSocketManager:self didReceiveMessage:self.target message:message];
    }
}

//链接成功
- (void)webSocketDidOpen:(SRWebSocket *)webSocket{
    DebugLog(@"webSocket= %@", webSocket);
    [self.pingTimer setFireDate:[NSDate distantPast]];
}

//链接失败
- (void)webSocket:(SRWebSocket *)webSocket didFailWithError:(NSError *)error{
    DebugLog(@"error= %@", error);
    //1.连接失败 停止发送ping， 2.5秒后发起连接
    [self.webSocket close];
    self.webSocket.delegate = self;
    self.webSocket = nil;
    
    [self.webSocket performSelector:@selector(open) withObject:nil afterDelay:5.f];
}


- (void)webSocket:(SRWebSocket *)webSocket didCloseWithCode:(NSInteger)code reason:(NSString *)reason wasClean:(BOOL)wasClean{
    DebugLog(@"reason = %@",reason);
    _pingTimer.fireDate = [NSDate distantFuture];
}

//收到了心跳
- (void)webSocket:(SRWebSocket *)webSocket didReceivePong:(NSData *)pongPayload{
    NSString* pongStr = [[NSString alloc] initWithData:pongPayload encoding:NSUTF8StringEncoding];
    DebugLog(@"pong = %@",pongStr);
}

#pragma mark - Public

//发送消息
-(void)sendData:(id)data{
    if (self.webSocket.readyState == SR_OPEN) {
        [self.webSocket send:data];
    }else{
        if (data) {
            DebugLog(@"发送消息失败");
        }else{
            DebugLog(@"发送ping失败");
        }
        
    }
}
@end
