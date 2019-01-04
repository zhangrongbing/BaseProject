//
//  WeatherDetailViewController.m
//  BaseProject
//
//  Created by 张熔冰 on 2018/8/28.
//  Copyright © 2018年 Lovcreate. All rights reserved.
//

#import "WeatherDetailViewController.h"
#import "WeatherOperation.h"

@interface WeatherDetailViewController ()

@property(nonatomic, weak) IBOutlet UILabel *detailLabel;

@end

@implementation WeatherDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSMutableDictionary *params = @{}.mutableCopy;
    params[@"key"] = @"610a09989477905e1682436530d72088";
    params[@"city_id"] = self.cityModel._id;
    params[@"weather_date"] = @"2018-08-27";
    
    WeatherOperation *operation = [[WeatherOperation alloc] initWithTarget:self params:params];
    [NetworkingManager asyncOperation:operation handler:^(NSInteger state) {
        WeatherModel *model = operation.model;
        self.detailLabel.text = model.mj_JSONString;
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
