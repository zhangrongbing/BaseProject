//
//  LockViewController.m
//  BaseProject
//
//  Created by 张熔冰 on 2019/2/1.
//  Copyright © 2019年 Lovcreate. All rights reserved.
//

#import "ThreadLockViewController.h"

@interface ThreadLockViewController ()

@end

@implementation ThreadLockViewController{
    int _ticketCount;//总票数
    
    int _soldCount;//已经卖了多少张票
    
    NSLock *_lock;//数据锁
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    _ticketCount = 100;
    
    _soldCount = 0;
    
    //初始化锁
    _lock = [[NSLock alloc] init];
    
    //第一窗口
    NSThread *thread1 = [[NSThread alloc] initWithTarget:self selector:@selector(soldTicket) object:nil];
    
    thread1.name = @"thread_1";
    
    [thread1 start];
    
    //第二窗口
    NSThread *thread2 = [[NSThread alloc] initWithTarget:self selector:@selector(soldTicket) object:nil];
    
    thread2.name = @"thread_2";
    
    [thread2 start];
    
    //第三窗口
    NSThread *thread3 = [[NSThread alloc] initWithTarget:self selector:@selector(soldTicket) object:nil];
    
    thread3.name = @"thread_3";
    
    [thread3 start];
}
-(void)soldTicket
{
    //加锁
    [_lock lock];
    
    int current = _ticketCount;
    
    if (current == 0) {
        
        NSLog(@"------%@ 剩余票数：%d",[[NSThread currentThread] name],_ticketCount);
        
        NSLog(@"-------卖的总票数：%d",_soldCount);
        
        [_lock unlock];
        
        return;
    }
    
    //延时卖票
    [NSThread sleepForTimeInterval:0.3];
    
    _ticketCount = current-1;
    
    _soldCount++;
    
    NSLog(@"------%@ 剩余票数：%d",[[NSThread currentThread] name],_ticketCount);
    
    //解锁
    [_lock unlock];
    
    //一直卖票
    [self soldTicket];
}

@end
