//
//  OperationViewController.m
//  BaseProject
//
//  Created by 张熔冰 on 2018/9/4.
//  Copyright © 2018年 Lovcreate. All rights reserved.
//

#import "OperationViewController.h"

@interface OperationViewController ()

@end

@implementation OperationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)executeInMainThread
{
    DebugLog(@"创建添加任务%@",[NSThread currentThread]);
//    NSOperationQueue *customQueue = [NSOperationQueue mainQueue];
    NSOperationQueue *customQueue = [[NSOperationQueue alloc]init];
    customQueue.maxConcurrentOperationCount = 20;
    NSInvocationOperation *op1 = [[NSInvocationOperation alloc]initWithTarget:self selector:@selector(task:) object:@"1"];
    
    NSInvocationOperation *op2 = [[NSInvocationOperation alloc]initWithTarget:self selector:@selector(task:) object:@"2"];
    
    NSInvocationOperation *op3 = [[NSInvocationOperation alloc]initWithTarget:self selector:@selector(task:) object:@"3"];
    
    NSInvocationOperation *op4 = [[NSInvocationOperation alloc]initWithTarget:self selector:@selector(task:) object:@"4"];
    NSInvocationOperation *op5 = [[NSInvocationOperation alloc]initWithTarget:self selector:@selector(task:) object:@"5"];
    
    [customQueue addOperation:op1];
    [customQueue addOperation:op2];
    [customQueue addOperation:op3];
    [customQueue addOperation:op4];
    [customQueue addOperation:op5];
    DebugLog(@"%ld个线程",customQueue.operationCount);
}

- (void)executeInMainThread1
{
    DebugLog(@"创建操作:%@",[NSThread currentThread]);
    NSBlockOperation *op1 = [NSBlockOperation blockOperationWithBlock:^{
        [self task:@"op1"];
    }];
    //NSBlockOperation该操作有个方法能在该操作中持续添加操作任务addExecutionBlock，直到全部的block中的任务都执行完成后，该操作op才算执行完毕。当该操作在addExecutionBlock加入比较多的任务时，该op的block中的（包括blockOperationWithBlock和addExecutionBlock中的操作）会在新开的线程中执行。不一定在创建该op的线程中执行。
    [op1 addExecutionBlock:^{
        [self task:@"op1 - block1"];
    }];
    [op1 addExecutionBlock:^{
        [self task:@"op1 - block2"];
    }];
    
    NSBlockOperation *op2 = [NSBlockOperation blockOperationWithBlock:^{
        [self task:@"op2"];
    }];
    
    [op2 addExecutionBlock:^{
        [self task:@"op2 - block1"];
    }];
    [op2 addExecutionBlock:^{
        [self task:@"op2 - block2"];
    }];
    
    NSBlockOperation *op3 = [NSBlockOperation blockOperationWithBlock:^{
        [self task:@"op3"];
    }];
    
    [op2 addExecutionBlock:^{
        [self task:@"op3 - block1"];
    }];
    [op2 addExecutionBlock:^{
        [self task:@"op3 - block2"];
    }];
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [queue addOperation:op1];
    [queue addOperation:op2];
    [queue addOperation:op3];
}

/**
 在子线程中执行
 */
- (void)executeInNewThread
{
    DebugLog(@"创建操作:%@",[NSThread currentThread]);
    [NSThread detachNewThreadSelector:@selector(executeInMainThread) toTarget:self withObject:nil];
}

- (void)task:(NSString*)order
{
    for (NSInteger i = 0; i < 3; i++) {
         DebugLog(@"任务:-%@-%@", order, [NSThread currentThread]);
    }
}

#pragma mark - Action
-(IBAction)pressOperationButton:(id)sender{
    [self executeInMainThread];
}

-(IBAction)pressBlockButton:(id)sender{
    [self executeInMainThread1];
}
@end
