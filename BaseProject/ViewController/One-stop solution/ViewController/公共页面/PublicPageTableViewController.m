//
//  PublicPageTableViewController.m
//  BaseProject
//
//  Created by 张熔冰 on 2018/8/2.
//  Copyright © 2018年 Lovcreate. All rights reserved.
//

#import "PublicPageTableViewController.h"
#import "SettingsTableViewController.h"
#import "LoginListController.h"
#import "ContainerViewController.h"
#import "ChildViewController.h"
#import "LockViewController.h"
#import "ImageBrowserViewController.h"
#import "SideViewContainer.h"
#import "TransitioningViewController.h"
#import "SearchViewController.h"
#import "CityPickerController.h"
#import "NavigationBarViewController.h"
#import "CustomNavigationController.h"
#import "SoundViewController.h"
#import "ScrollableDetailController.h"
#import "LCWebBrowserViewController.h"
#import "PickPhotoViewController.h"

@interface PublicPageTableViewController ()

@property(nonatomic, strong) NSMutableArray *tableData;
@property(nonatomic, strong) NSArray *imageData;

@end

@implementation PublicPageTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableData = @[@"设置", @"登录",@"容器",@"子控制器", @"手势密码", @"图片查看器", @"侧边栏",@"过场动画", @"伪搜索", @"城市", @"导航栏", @"详情页", @"网页交互", @"图片选取"].mutableCopy;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:CellIdentifier];
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
    if ([title isEqualToString:@"设置"]) {
        SettingsTableViewController *controller = [[SettingsTableViewController alloc] init];
        controller.title = title;
        [self.navigationController pushViewController:controller animated:YES];
    }else if([title isEqualToString:@"登录"]){
        LoginListController *controller = [[LoginListController alloc] init];
        controller.title = title;
        [self.navigationController pushViewController:controller animated:YES];
    }else if([title isEqualToString:@"容器"]){
        ContainerViewController*controller = [[ContainerViewController alloc] init];
        controller.title = title;
        [self.navigationController pushViewController:controller animated:YES];
    }else if([title isEqualToString:@"子控制器"]){
        ChildViewController*controller = [[ChildViewController alloc] init];
        controller.title = title;
        [self.navigationController pushViewController:controller animated:YES];
    }else if([title isEqualToString:@"手势密码"]){
        LockViewController*controller = [[LockViewController alloc] init];
        controller.title = title;
        [self.navigationController pushViewController:controller animated:YES];
    }else if([title isEqualToString:@"图片查看器"]){
        ImageBrowserViewController *controller = [[ImageBrowserViewController alloc] init];
        controller.title = title;
        [self.navigationController pushViewController:controller animated:YES];
    }else if([title isEqualToString:@"侧边栏"]){
        SideViewContainer *controller = [[SideViewContainer alloc] init];
        controller.title = title;
        BaseNavigationController *nav = [[BaseNavigationController alloc] initWithRootViewController:controller];
        [self presentViewController:nav animated:YES completion:nil];
    }else if([title isEqualToString:@"过场动画"]){
        TransitioningViewController *controller = [[TransitioningViewController alloc] init];
        controller.title = title;
        [self.navigationController pushViewController:controller animated:YES];
    }else if([title isEqualToString:@"伪搜索"]){
        SearchViewController *controller = [[SearchViewController alloc] init];
        controller.title = title;
        [self.navigationController pushViewController:controller animated:YES];
    }else if([title isEqualToString:@"城市"]){
        CityPickerController *controller = [[CityPickerController alloc] init];
        controller.title = title;
        [self.navigationController pushViewController:controller animated:YES];
    }else if([title isEqualToString:@"导航栏"]){
        NavigationBarViewController *controller = [[NavigationBarViewController alloc] init];
        controller.title = title;
        CustomNavigationController *nav = [[CustomNavigationController alloc] initWithRootViewController:controller];
        [self presentViewController:nav animated:YES completion:nil];
    }else if([title isEqualToString:@"详情页"]){
        ScrollableDetailController *controller = [[ScrollableDetailController alloc] init];
        controller.title = title;
        [self.navigationController pushViewController:controller animated:YES];
    }else if([title isEqualToString:@"网页交互"]){
        LCWebBrowserViewController *controller = [[LCWebBrowserViewController alloc] init];
        controller.title = title;
        [self.navigationController pushViewController:controller animated:YES];
    }else if([title isEqualToString:@"图片选取"]){
        PickPhotoViewController *controller = [[PickPhotoViewController alloc] init];
        controller.title = title;
        [self.navigationController pushViewController:controller animated:YES];
    }
}
@end
