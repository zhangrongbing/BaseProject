//
//  MutableViewController.m
//  BaseProject
//
//  Created by 张熔冰 on 2018/11/14.
//  Copyright © 2018年 Lovcreate. All rights reserved.
//

#import "MutableViewController.h"
#import "NetworkingManager.h"
#import "OneOperation.h"
#import "TwoOperation.h"
#import "ThreeOperation.h"

@interface MutableViewController ()

@end

@implementation MutableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [NSTimer scheduledTimerWithTimeInterval:.3f target:self selector:@selector(getData) userInfo:nil repeats:YES];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

-(void)getData{
    
    NSMutableDictionary *oneParams = @{}.mutableCopy;
    oneParams[@"key"] = @"610a09989477905e1682436530d72088";
    
    OneOperation *one = [[OneOperation alloc] initWithTarget:self params:oneParams];
    [[NetworkingManager sharedInstance] asyncOperation:one handler:^(NSInteger state) {
        DebugLog(@"接口一请求，%@解析", one.name);
    }];
    NSMutableDictionary *twoParams = @{}.mutableCopy;
    twoParams[@"key"] = @"610a09989477905e1682436530d72088";
    twoParams[@"province_id"] = @"15";
    TwoOperation *two = [[TwoOperation alloc] initWithTarget:self params:twoParams];
    [[NetworkingManager sharedInstance] asyncOperation:two handler:^(NSInteger state) {
        DebugLog(@"接口二请求，%@解析", two.name);
    }];
    [NSThread sleepForTimeInterval:0.3];
    NSMutableDictionary *threeParams = @{}.mutableCopy;
    threeParams[@"key"] = @"610a09989477905e1682436530d72088";
    threeParams[@"city_id"] = @"1066";
    threeParams[@"weather_date"] = @"2018-11-13";
    ThreeOperation *three = [[ThreeOperation alloc] initWithTarget:self params:threeParams];
    [[NetworkingManager sharedInstance] asyncOperation:three handler:^(NSInteger state) {
        DebugLog(@"接口三请求，%@解析", three.name);
    }];
}

@end
