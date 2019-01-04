//
//  WeatherCityTableViewController.m
//  BaseProject
//
//  Created by 张熔冰 on 2018/8/28.
//  Copyright © 2018年 Lovcreate. All rights reserved.
//

#import "WeatherCityTableViewController.h"
#import "WeatherCityOperation.h"
#import "WeatherDetailViewController.h"

@interface WeatherCityTableViewController ()

@property(nonatomic, strong) NSArray* tableData;

@end

@implementation WeatherCityTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableData = [NSArray array];
    [self setupTalbeView];
    NSMutableDictionary *params = @{}.mutableCopy;
    params[@"key"] = @"610a09989477905e1682436530d72088";
    params[@"province_id"] = self.provinceModel._id;
    
    WeatherCityOperation *operation = [[WeatherCityOperation alloc] initWithTarget:self params:params];
    [NetworkingManager asyncOperation:operation handler:^(NSInteger state) {
        self.tableData = operation.data;
        [self.tableView reloadData];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tableData.count;
}

static NSString *CellIdentifier = @"Cell";
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    CityModel *model = [self.tableData objectAtIndex:indexPath.row];
    cell.textLabel.text = model.city_name;
    return cell;
}

#pragma mark - UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    CityModel *model = [self.tableData objectAtIndex:indexPath.row];
    WeatherDetailViewController *controller = [[WeatherDetailViewController alloc] init];
    controller.cityModel = model;
    [self.navigationController pushViewController:controller animated:YES];
}

#pragma mark - Public
-(void)setupTalbeView{
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:CellIdentifier];
}
@end
