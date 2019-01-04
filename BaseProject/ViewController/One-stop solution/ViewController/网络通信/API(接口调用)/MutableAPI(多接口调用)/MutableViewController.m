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
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    NSMutableDictionary *oneParams = @{}.mutableCopy;
    oneParams[@"key"] = @"610a09989477905e1682436530d72088";
    
    OneOperation *one = [[OneOperation alloc] initWithTarget:self params:oneParams];
    [NetworkingManager asyncOperation:one handler:^(NSInteger state) {
        
    }];
    NSMutableDictionary *twoParams = @{}.mutableCopy;
    twoParams[@"key"] = @"610a09989477905e1682436530d72088";
    twoParams[@"province_id"] = @"15";
    TwoOperation *two = [[TwoOperation alloc] initWithTarget:self params:twoParams];
    [NetworkingManager asyncOperation:two handler:^(NSInteger state) {
        
    }];
    NSMutableDictionary *threeParams = @{}.mutableCopy;
    threeParams[@"key"] = @"610a09989477905e1682436530d72088";
    threeParams[@"city_id"] = @"1066";
    threeParams[@"weather_date"] = @"2018-11-13";
    ThreeOperation *three = [[ThreeOperation alloc] initWithTarget:self params:threeParams];
    [NetworkingManager asyncOperation:three handler:^(NSInteger state) {
        
    }];
}

@end
