//
//  ViewController.m
//  BaseProject
//
//  Created by 张熔冰 on 2018/8/1.
//  Copyright © 2018年 Lovcreate. All rights reserved.
//

#import "ViewController.h"
#import "UIColor+Addition.h"
#import "IPManager.h"
#import <UserNotifications/UserNotifications.h>
#import "AppDelegate+RemoteNotification.h"
#import "Masonry.h"

@interface ViewController ()

@property(nonatomic, strong) NSArray *tableData;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"一站式解决方案";
    [self initTalbeView];
    [self initTableData];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"OperUrl" style:UIBarButtonItemStylePlain target:self action:@selector(pressRightItem:)];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    UIBarButtonItem * leftItem = [[UIBarButtonItem alloc] initWithTitle:@"发送本地通知" style:UIBarButtonItemStylePlain target:self action:@selector(pressLeftItem:)];
    self.navigationItem.leftBarButtonItem = leftItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    DebugLog(@"");
}

-(void)dealloc{
    DebugLog(@"");
}

#pragma mark - UITableViewDataSource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.tableData.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSDictionary *dic = [self.tableData objectAtIndex:section];
    NSArray *rows = [[dic allValues] lastObject];
    return [rows count];
}

static NSString *CellIdentifier = @"CellIdentifier";
-(UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    NSArray *rows = [[self.tableData objectAtIndex:indexPath.section] allValues].firstObject;
    NSString *className = [[rows objectAtIndex:indexPath.row] allValues].firstObject;
    NSString *title = [[rows objectAtIndex:indexPath.row] allKeys].firstObject;
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.detailTextLabel.lineBreakMode = NSLineBreakByCharWrapping;
        cell.detailTextLabel.numberOfLines = 0;
        cell.detailTextLabel.font = [UIFont systemFontOfSize:12];
        cell.detailTextLabel.textColor = [UIColor lightGrayColor];
        cell.textLabel.font = [UIFont systemFontOfSize:13];
        cell.textLabel.textColor = [UIColor blackColor];
    }
    
    cell.detailTextLabel.text = className;
    cell.textLabel.text = title;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44.f;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30.f;
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UILabel *label = [[UILabel alloc] init];
    label.font = [UIFont systemFontOfSize:14];
    label.textColor = RGB(0x297FCA);
    label.text = [[self.tableData objectAtIndex:section] allKeys].firstObject;
    label.numberOfLines = 1;
    [label sizeToFit];
    
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = RGB(0xE4F1FD);
    [view addSubview:label];
    //布局
    UIEdgeInsets padding = UIEdgeInsetsMake(0, 10, 0, 10);
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(view).insets(padding);
    }];
    return view;
}

#pragma mark - UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSArray *rows = [[self.tableData objectAtIndex:indexPath.section] allValues].firstObject;
    NSString *className = [[rows objectAtIndex:indexPath.row] allValues].firstObject;
    NSString *title = [[rows objectAtIndex:indexPath.row] allKeys].firstObject;
    
    UIViewController *subViewController = [[NSClassFromString(className) alloc] init];
    subViewController.title = title;
    [self.navigationController pushViewController:subViewController animated:YES];
}

#pragma mark - Public
-(void)initTalbeView{
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:CellIdentifier];
}

-(void)initTableData{
    self.tableData = @[@{@"菜单":@[@{@"弹出菜单":@"PopupMenuTableViewController"}]},
                       @{@"列表":@[@{@"列表操作":@"TableViewController"}]},
                       @{@"页面":@[@{@"公共页面":@"PublicPageTableViewController"}]},
                       @{@"验证":@[@{@"各种验证":@"VerificationTableViewController"}]},
                       @{@"控件":@[@{@"控件":@"WidgetTableViewController"}]},
                       @{@"加密":@[@{@"各种加密":@"CiphertextViewController"}]},
                       @{@"生命周期":@[@{@"生命周期":@"LifeCycleAViewController"}]},
                       @{@"网络通信":@[@{@"Socket通信":@"SocketViewController"},
                                   @{@"单接口调用":@"APITableViewController"},
                                   @{@"多接口同时调用":@"MutableViewController"}]},
                       @{@"并发":@[@{@"NSOperation并发":@"OperationViewController"},
                                 @{@"GCD":@"GCDViewController"},
                                 @{@"线程锁":@"ThreadLockViewController"}]},
                       @{@"传感器":@[@{@"传感器":@"SensorViewController"},
                                  @{@"语音提示":@"SpeechViewController"}]},
                       @{@"二维码":@[@{@"生成二维码":@"CreateQRCodeController"},
                                  @{@"读取二维码":@"ScanQRCodeController"}]},
                       @{@"多媒体":@[@{@"流媒体":@"SteamingMediaController"}]},
                       @{@"控件点击":@[@{@"ClickEvent":@"ClickEventViewController"}]},
                       @{@"代码块":@[@{@"Block":@"BlockViewController"}]},
    @{@"功能":@[@{@"定位":@"LocationViewController"}]}];
}

#pragma mark - Action
-(void)pressRightItem:(UIBarButtonItem*)item{
    //打开其他App
    NSString *schemaStr = @"lovcreate://account=ice&pwd=qqq123";
    NSURL *url = [NSURL URLWithString:schemaStr];
    if (@available(iOS 10.0, *)) {
        [[UIApplication sharedApplication] openURL:url options:@{@"key1":@"value1"} completionHandler:^(BOOL success) {
            if (!success) {
                UIAlertController *controller = [UIAlertController alertControllerWithTitle:LCGetStringWithKeyFromTable(@"提示", nil) message:@"您没有安装" preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *cancelButton = [UIAlertAction actionWithTitle:LCGetStringWithKeyFromTable(@"取消", nil) style:UIAlertActionStyleCancel handler:nil];
                [controller addAction:cancelButton];
                [self presentViewController:controller animated:YES completion:nil];
            }
        }];
    } else {
        if ([[UIApplication sharedApplication] canOpenURL:url]) {
            [[UIApplication sharedApplication] openURL:url];
        }else{
            UIAlertController *controller = [UIAlertController alertControllerWithTitle:LCGetStringWithKeyFromTable(@"提示", nil) message:@"您没有安装" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *cancelButton = [UIAlertAction actionWithTitle:LCGetStringWithKeyFromTable(@"取消", nil) style:UIAlertActionStyleCancel handler:nil];
            [controller addAction:cancelButton];
            [self presentViewController:controller animated:YES completion:nil];
        }
    }
}

-(void)pressLeftItem:(UIBarButtonItem*)item{
    AppDelegate *appDelegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
    [appDelegate sendLocalNotification];
}

-(void)refreshTabView:(UIRefreshControl*)ctrl{
}
@end
