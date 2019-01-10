//
//  WidgetTableViewController.m
//  BaseProject
//
//  Created by 张熔冰 on 2018/8/15.
//  Copyright © 2018年 Lovcreate. All rights reserved.
//

#import "WidgetTableViewController.h"
#import "CycleViewController.h"
#import "ButtonViewController.h"
#import "SegmentCodeViewController.h"
#import "TextFieldViewController.h"
#import "ColorLineViewController.h"
#import "TabViewController.h"
#import "ImageZoomViewController.h"
#import "DialogController.h"

@interface WidgetTableViewController ()

@property(nonatomic, strong) NSArray *tableData;

@end

@implementation WidgetTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableData = @[@"轮播图", @"按钮", @"分段验证码", @"输入框", @"自定义UIView", @"选项卡"].mutableCopy;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:CellIdentifier];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"评价" style:UIBarButtonItemStylePlain target:self action:@selector(pressRightItem:)];
    self.navigationItem.rightBarButtonItem = rightItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tableData.count;
}

static NSString *CellIdentifier = @"Cell";
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    NSString *title = [self.tableData objectAtIndex:indexPath.row];
    cell.textLabel.text = title;
    return cell;
}

#pragma mark - UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSString *title = [self.tableData objectAtIndex:indexPath.row];
    if ([title isEqualToString:@"轮播图"]) {
        CycleViewController *controller = [[CycleViewController alloc] init];
        controller.title = title;
        [self.navigationController pushViewController:controller animated:YES];
    }else if ([title isEqualToString:@"按钮"]) {
        ButtonViewController *controller = [[ButtonViewController alloc] init];
        controller.title = title;
        [self.navigationController pushViewController:controller animated:YES];
    }else if ([title isEqualToString:@"分段验证码"]) {
        SegmentCodeViewController *controller = [[SegmentCodeViewController alloc] init];
        controller.title = title;
        [self.navigationController pushViewController:controller animated:YES];
    }else if ([title isEqualToString:@"输入框"]) {
        TextFieldViewController *controller = [[TextFieldViewController alloc] init];
        controller.title = title;
        [self.navigationController pushViewController:controller animated:YES];
    }else if ([title isEqualToString:@"自定义UIView"]) {
        ColorLineViewController *controller = [[ColorLineViewController alloc] init];
        controller.title = title;
        [self.navigationController pushViewController:controller animated:YES];
    }else if ([title isEqualToString:@"选项卡"]) {
        TabViewController *controller = [[TabViewController alloc] init];
        controller.title = title;
        [self.navigationController pushViewController:controller animated:YES];
    }else if ([title isEqualToString:@"图片缩放"]) {
        ImageZoomViewController *controller = [[ImageZoomViewController alloc] init];
        controller.title = title;
        [self.navigationController pushViewController:controller animated:YES];
    }
}

#pragma mark - Action
-(void)pressRightItem:(UIBarButtonItem*)item{
    [EvaluateController showControllerForPresentingController:self];
}
@end
