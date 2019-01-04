//
//  TableViewController.m
//  BaseProject
//
//  Created by 张熔冰 on 2018/8/1.
//  Copyright © 2018年 Lovcreate. All rights reserved.
//

#import "TableViewController.h"
#import "MGSwipeTableCell.h"

@interface TableViewController ()

@property(nonatomic, strong) NSMutableArray *tableData;

@end

@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableData = @[@"左滑删除1",@"左滑删除2",@"左滑删除3",@"左滑删除4"].mutableCopy;
    [self.tableView registerClass:[MGSwipeTableCell class] forCellReuseIdentifier:CellIdentifier];
    self.tableView.rowHeight = 60.f;
    self.tableView.estimatedRowHeight = 60.f;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - UITalbeIVewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tableData.count;
}

static NSString *CellIdentifier = @"Cell";
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MGSwipeTableCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    NSString *title = [self.tableData objectAtIndex:indexPath.row];
    cell.textLabel.text = title;
    NSString *btnTitle = LCGetStringWithKeyFromTable(@"删除", nil);
    MGSwipeButton *btn = [MGSwipeButton buttonWithTitle:btnTitle icon:[UIImage imageNamed:@"删除"] backgroundColor:[UIColor redColor]];
    [btn centerIconOverText];
    cell.rightButtons = @[btn];
    return cell;
}
@end
