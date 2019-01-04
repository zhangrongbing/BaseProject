//
//  BaseTableViewController.m
//  BaseProject
//
//  Created by zhangrongbing on 2016/11/22.
//  Copyright © 2016年 lovcreate. All rights reserved.
//

#import "BaseTableViewController.h"
#import "MJRefresh.h"
#import <SwipeBack/SwipeBack.h>

@interface BaseTableViewController()

@property(nonatomic, strong) void(^completionBlock)(void);
@property(nonatomic, assign) BOOL flag;

@end

@implementation BaseTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.backgroundColor = [UIColor whiteColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Public
-(void)endMJRefreshing{
    if (self.tableView.mj_header.isRefreshing) {
        [self.tableView.mj_header endRefreshing];
    }
    if (self.tableView.mj_footer.isRefreshing) {
        [self.tableView.mj_footer endRefreshing];
    }
}

@end
