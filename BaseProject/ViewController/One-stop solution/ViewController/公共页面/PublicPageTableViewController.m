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
#import "TopicDetailViewController.h"

@interface PublicPageTableViewController ()

@property(nonatomic, strong) NSMutableArray *tableData;
@property(nonatomic, strong) NSArray *imageData;

@end

@implementation PublicPageTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableData = @[@"设置", @"登录",@"容器",@"子控制器", @"手势密码", @"图片查看器", @"侧边栏",@"过场动画", @"伪搜索", @"城市", @"导航栏", @"详情页", @"网页交互", @"图片选取", @"新闻详情"].mutableCopy;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:CellIdentifier];
    NSString * str = @"abcd?1234?!@#";
    NSRange range = [str rangeOfString:@"?"];
    NSLog(@"range.length = %ld", range.length);
    NSLog(@"range.location = %ld", range.location);
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
        UIViewController *ctrl1 = [[NSClassFromString(@"FirstViewController") alloc] init];
        ctrl1.title = @"关注";
        UIViewController * ctrl2 = [[NSClassFromString(@"FirstViewController") alloc] init];
        ctrl2.title = @"精选";
        UIViewController * ctrl3 = [[NSClassFromString(@"FirstViewController") alloc] init];
        ctrl3.title = @"军事";
        UIViewController *ctrl4 = [[NSClassFromString(@"FirstViewController") alloc] init];
        ctrl4.title = @"体育";
        UIViewController * ctrl5 = [[NSClassFromString(@"FirstViewController") alloc] init];
        ctrl5.title = @"长春";
        UIViewController * ctrl6 = [[NSClassFromString(@"FirstViewController") alloc] init];
        ctrl6.title = @"财经";
        UIViewController * ctrl7 = [[NSClassFromString(@"FirstViewController") alloc] init];
        ctrl7.title = @"懂车帝";
        UIViewController * ctrl8 = [[NSClassFromString(@"FirstViewController") alloc] init];
        ctrl8.title = @"房产";
        UIViewController * ctrl9 = [[NSClassFromString(@"FirstViewController") alloc] init];
        ctrl9.title = @"国际";
        ContainerViewController *container = [ContainerViewController containerWithControllers:@[ctrl1, ctrl2, ctrl3, ctrl4, ctrl5, ctrl6, ctrl7, ctrl8, ctrl9] defalutControllerIndex:1];
        container.segmentControl.style = SegmentControlStylePlain;
        container.segmentControl.sliderWidthStyle = SegmentControlSliderWidthStyleTextWidth;
        container.title = title;
        [self.navigationController pushViewController:container animated:YES];
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
    }else if([title isEqualToString:@"新闻详情"]){
        TopicDetailViewController *controller = [[TopicDetailViewController alloc] init];
        controller.title = title;
        [self.navigationController pushViewController:controller animated:YES];
    }
}
@end
