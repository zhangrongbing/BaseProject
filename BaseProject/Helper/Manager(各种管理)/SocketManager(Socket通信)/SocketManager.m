//
//  SocketManager.m
//  BaseProject
//
//  Created by 张熔冰 on 2018/8/27.
//  Copyright © 2018年 Lovcreate. All rights reserved.
//

#import "SocketManager.h"
#import "GCDAsyncSocket.h"

@interface SocketManager()<GCDAsyncSocketDelegate>

@property(nonatomic, strong) GCDAsyncSocket *socket;

@end

@implementation SocketManager

SINGLE_M(SocketManager);

-(void)connectToHost:(NSString *)host onPort:(NSString*)port{    
    self.socket = [[GCDAsyncSocket alloc] initWithDelegate:self delegateQueue:dispatch_get_main_queue()];
    NSError *error = nil;
    BOOL success = [self.socket connectToHost:host onPort:[port integerValue] error:&error];
    if (success == NO || error != nil) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(socketManager:failedWithCode:error:)]) {
            [self.delegate socketManager:self failedWithCode:ConnectFailed error:error];
        }
    }
}

-(void)disconnect{
    [self.socket disconnect];
}

-(void)sendMessage:(NSString*)msg{
    NSData *msgData = [msg dataUsingEncoding:NSASCIIStringEncoding];
    [self.socket writeData:msgData withTimeout:-1 tag:200];
}

-(void)sendData:(NSData*)data{
    [self.socket writeData:data withTimeout:-1 tag:200];
}

#pragma mark - GCDAsyncSocketDelegate
-(void)socket:(GCDAsyncSocket *)sock didConnectToHost:(NSString *)host port:(uint16_t)port{
    DebugLog(@"链接成功 host = %@, port = %hu", host, port);
    if (self.delegate && [self.delegate respondsToSelector:@selector(socketManager:didConnectToHost:onPort:)]) {
        [self.delegate socketManager:self didConnectToHost:host onPort:[NSString stringWithFormat:@"%d", port]];
        [self.socket readDataWithTimeout:-1 tag:0];
    }
}

-(void)socketDidDisconnect:(GCDAsyncSocket *)sock withError:(NSError *)err{
    DebugLog(@"断开链接 err = %@", err);
    if (self.delegate && [self.delegate respondsToSelector:@selector(socketManager:failedWithCode:error:)]) {
        [self.delegate socketManager:self failedWithCode:Disconnect error:err];
    }
}

-(void)socket:(GCDAsyncSocket *)sock didWriteDataWithTag:(long)tag{
    [self.socket readDataWithTimeout:-1 tag:0];
    DebugLog(@"数据发送成功 tag = %ld", tag);
    if (self.delegate && [self.delegate respondsToSelector:@selector(didSendMessageForSocketManager:)]) {
        [self.delegate didSendMessageForSocketManager:self];
    }
}

-(void)socket:(GCDAsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag{
    NSString *dataStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    if (self.delegate && [self.delegate respondsToSelector:@selector(socketManager:didReceiveMessage:)]) {
        [self.delegate socketManager:self didReceiveMessage:dataStr];
    }
    [self.socket readDataWithTimeout:-1 tag:0];
    DebugLog(@"数据接收成功 tag = %ld; data = %@", tag, dataStr);
}
@end
