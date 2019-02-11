//
//  APITableViewController.m
//  BaseProject
//
//  Created by 张熔冰 on 2018/8/28.
//  Copyright © 2018年 Lovcreate. All rights reserved.
//

#import "APITableViewController.h"
#import "WeatherProvinceOperation.h"
#import "WeatherCityTableViewController.h"

@interface APITableViewController ()

@property(nonatomic, strong) NSArray *tableData;

@end

@implementation APITableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupTableView];
    self.tableData = [NSArray array];
    NSMutableDictionary *params = @{}.mutableCopy;
    params[@"key"] = @"610a09989477905e1682436530d72088";
    
    WeatherProvinceOperation *operator = [[WeatherProvinceOperation alloc] initWithTarget:self params:params];
    [[NetworkingManager sharedInstance] asyncOperation:operator handler:^(NSInteger state) {
        if (state == 0) {
            self.tableData = operator.data;
            [self.tableView reloadData];
        }else{
            
        }
    }];
}

-(void)dealloc{
    DebugLog(@"");
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
    ProvinceModel *model = [self.tableData objectAtIndex:indexPath.row];
    cell.textLabel.text = model.province;
    return cell;
}

#pragma mark - UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    ProvinceModel *model = [self.tableData objectAtIndex:indexPath.row];
    WeatherCityTableViewController *controller = [[WeatherCityTableViewController alloc] init];
    controller.provinceModel = model;
    [self.navigationController pushViewController:controller animated:YES];
}
#pragma mark - Public
-(void)setupTableView{
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:CellIdentifier];
}

@end
