//
//  LoginListController.m
//  BaseProject
//
//  Created by 张熔冰 on 2018/12/10.
//  Copyright © 2018年 Lovcreate. All rights reserved.
//

#import "LoginListController.h"
#import "LoginOneViewController.h"
#import "LoginTwoViewController.h"

@interface LoginListController ()

@property(nonatomic, strong) NSArray *tableSource;

@end

@implementation LoginListController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"技术积累与体验优化一";
    self.tableSource = @[@"效果一", @"效果二", @"效果三", @"效果四"];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:CellIdentifier];
    self.tableView.rowHeight = 44.f;
    self.tableView.estimatedRowHeight = 44.f;
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tableSource.count;
}

static NSString *CellIdentifier = @"Cell";
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    NSString *str = [self.tableSource objectAtIndex:indexPath.row];
    cell.textLabel.text = str;
    return cell;
}

#pragma mark - UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSString *str = [self.tableSource objectAtIndex:indexPath.row];
    if ([str isEqualToString:@"效果一"]) {
        LoginOneViewController *controller = [[LoginOneViewController alloc] init];
        [self _presentViewController:controller animationType:KPrensentAnimationTypePush direction:KPrensentAnimationDirectionBottom completion:nil];
//        [self presentViewController:controller animated:YES completion:nil];
    }else if ([str isEqualToString:@"效果二"]){
        LoginTwoViewController *controller = [[LoginTwoViewController alloc] init];
        [self.navigationController pushViewController:controller animated:YES];
    }else if ([str isEqualToString:@"效果三"]){
        
    }else if ([str isEqualToString:@"效果四"]){
        
    }
}
@end
