//
//  SettingsTableViewController.m
//  BaseProject
//
//  Created by 张熔冰 on 2018/8/2.
//  Copyright © 2018年 Lovcreate. All rights reserved.
//

#import "SettingsTableViewController.h"
#import "UIColor+Addition.h"
#import "UIView+Addition.h"
#import "Masonry.h"
#import "SwitchTableViewCell.h"
#import "SubTitleTableViewCell.h"
#import "FileManager.h"
#import "AppDelegate.h"
#import "LoginViewController.h"
#import "SettingNotificationViewController.h"
#import "MyConfig.h"

@interface SettingsTableViewController ()

@property(nonatomic, strong) NSMutableArray *tableData;
@end

@implementation SettingsTableViewController

-(instancetype)initWithStyle:(UITableViewStyle)style{
    if (self = [super initWithStyle:UITableViewStyleGrouped]) {
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = LCGetStringWithKeyFromTable(@"设置", nil);
    self.tableData = @[@"清楚缓存", @"消息提醒", @"开关"].mutableCopy;
    [self initTalbeView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)dealloc{
    DebugLog(@"");
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tableData.count;
}

static NSString *SubTitleCellIdentifier = @"SubTitleCellIdentifier";
static NSString *SwitchCellIdentifier = @"SwitchCellIdentifier";
static NSString *NotificationCellIdentifier = @"NotificationCellIdentifier";
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        SubTitleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SubTitleCellIdentifier forIndexPath:indexPath];
        cell.titleLabel.text = LCGetStringWithKeyFromTable(@"清除缓存", nil);
        float size = [[FileManager sharedInstance] sizeOfCaches];
        cell.subTitleLabel.text = [NSString stringWithFormat:@"%.3f",size];
        return cell;
    }else if(indexPath.row == 1){
        SwitchTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SwitchCellIdentifier forIndexPath:indexPath];
        cell.titleLabel.text = LCGetStringWithKeyFromTable(@"这个是开关", nil);
        [cell setValueChangedBlock:^(BOOL isOn) {
            if (isOn) {
                [[ToastManager sharedInstance] showMessage:@"开关打开"];
            }else{
                [[ToastManager sharedInstance] showMessage:@"开关关闭"];
            }
        }];
        return cell;
    }else if(indexPath.row == 2){
        SubTitleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NotificationCellIdentifier forIndexPath:indexPath];
        cell.titleLabel.text = LCGetStringWithKeyFromTable(@"接受新消息通知", nil);
        cell.subTitleLabel.text = @"";
        return cell;
    }
    return [UITableViewCell new];
}

#pragma mark - UITableViewDelegate
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 16.f;
    }
    return 22.f;
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return nil;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 0) {//清楚缓存
        NSString *msg = LCGetStringWithKeyFromTable(@"\n所有本地信息将会被清除\n", nil);
        NSString *cancelActionTitle = LCGetStringWithKeyFromTable(@"取消", nil);
        NSString *confirmActionTitle = LCGetStringWithKeyFromTable(@"清除", nil);
        NSString *alertTitle = LCGetStringWithKeyFromTable(@"提醒", nil);
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:alertTitle message:msg preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:cancelActionTitle style:UIAlertActionStyleDefault handler:nil];
        
        UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:confirmActionTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
            [[FileManager sharedInstance] removeCaches];
            [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        }];
        [alert addAction:cancelAction];
        [alert addAction:confirmAction];
        [self presentViewController:alert animated:YES completion:nil];
    }else if(indexPath.row == 2){
        SettingNotificationViewController *controller = [[SettingNotificationViewController alloc] init];
        [self.navigationController pushViewController:controller animated:YES];
    }
}

#pragma mark - Action
//退出
-(void)performLogoutAction:(UIButton*)button{
    NSString *alertTitle = LCGetStringWithKeyFromTable(@"提醒", nil);
    NSString *cancelActionTitle = LCGetStringWithKeyFromTable(@"取消", nil);
    NSString *confirmActionTitle = LCGetStringWithKeyFromTable(@"退出", nil);
    NSString *msg = LCGetStringWithKeyFromTable(@"\n退出当前账号\n", nil);
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:alertTitle message:msg preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:cancelActionTitle style:UIAlertActionStyleDefault handler:nil];
    UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:confirmActionTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
        AppDelegate *appDelegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
        LoginViewController *controller = [[LoginViewController alloc] init];
        BaseNavigationController *nav = [[BaseNavigationController alloc] initWithRootViewController:controller];
        appDelegate.window.rootViewController = nav;
        [appDelegate.window makeKeyAndVisible];
        [[MyConfig sharedInstance] clean];
    }];
    [alert addAction:cancelAction];
    [alert addAction:confirmAction];
    [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark - Public
-(void)initTalbeView{
    UIButton *logoutBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    logoutBtn.frame = CGRectMake(0, 0, kScreenWidth, 44.f);
    logoutBtn.backgroundColor = RGB(0xDAEEFF);
    [logoutBtn setTitle:LCGetStringWithKeyFromTable(@"退出", nil) forState:UIControlStateNormal];
    [logoutBtn setTitleColor:RGB(0x3FA2F7) forState:UIControlStateNormal];
    logoutBtn.titleLabel.font = [UIFont systemFontOfSize:16.f];
    [logoutBtn addTarget:self action:@selector(performLogoutAction:) forControlEvents:UIControlEventTouchUpInside];
    self.tableView.rowHeight = 44.f;
    self.tableView.estimatedRowHeight = 44.f;
    [self.tableView registerNib:[UINib nibWithNibName:@"SubTitleTableViewCell" bundle:nil] forCellReuseIdentifier:SubTitleCellIdentifier];
    [self.tableView registerNib:[UINib nibWithNibName:@"SwitchTableViewCell" bundle:nil] forCellReuseIdentifier:SwitchCellIdentifier];
    [self.tableView registerNib:[UINib nibWithNibName:@"SubTitleTableViewCell" bundle:nil] forCellReuseIdentifier:NotificationCellIdentifier];
    [self.tableView setTableFooterView:logoutBtn];
    self.tableView.separatorInset = UIEdgeInsetsMake(0, 16, 0, 16);
    self.tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
}

@end
