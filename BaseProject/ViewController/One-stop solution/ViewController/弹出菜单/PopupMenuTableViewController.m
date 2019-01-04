//
//  PopupMenuTableViewController.m
//  BaseProject
//
//  Created by 张熔冰 on 2018/8/1.
//  Copyright © 2018年 Lovcreate. All rights reserved.
//

#import "PopupMenuTableViewController.h"
#import "DataPickerViewController.h"
#import "DatePickerViewController.h"
#import "FirstViewController.h"
#import "PopViewController.h"
#import "SharedViewController.h"
#import "SheetController.h"
#import "BottomExpansionViewController.h"
#import "DialogController.h"

@interface PopupMenuTableViewController ()

@property(nonatomic, strong) NSArray *tableData;

@end

@implementation PopupMenuTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"一站式解决方案";
    [self initTalbeView];
    [self initTableData];
    
    //更多
    UIButton *rightButton = [[UIButton alloc] init];
    [rightButton setTitle:@"Button" forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(pressRightButtonItem:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *buttonItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"Item" style:UIBarButtonItemStylePlain target:self action:@selector(pressRightItem:)];
    self.navigationItem.rightBarButtonItems = @[buttonItem, item];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

#pragma mark - UITableViewDataSource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.tableData count];
}

static NSString *CellIdentifier = @"CellIdentifier";
-(UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    NSString *title = [self.tableData objectAtIndex:indexPath.row];
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
    cell.textLabel.text = title;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44.f;
}

#pragma mark - UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSString *title = [self.tableData objectAtIndex:indexPath.row];
    if ([title isEqualToString:@"数据选择器(DataPicker)"]) {
        [self showMutableDataPicker];
    }else if([title isEqualToString:@"日期选择器(DatePicker)"]){
        [self showDatePicker];
    }else if([title isEqualToString:@"时间选择器(TimePicker)"]){
        [self showTimePicker];
    }else if([title isEqualToString:@"日期时间选择器(DatetimePicker)"]){
        [self showDatetimePicker];
    }else if([title isEqualToString:@"提示框(AlertController)"]){
        [self showAlertController];
    }else if([title isEqualToString:@"分享菜单(SharedViewController)"]){
        [self showSharedController];
    }else if([title isEqualToString:@"选择图片(SelectedPictureController)"]){
        [self showSelectPictureController];
    }else if([title isEqualToString:@"底部伸缩菜单(BottomExpansionViewController)"]){
        [self go2BottomExpansionVC];
    }
}

#pragma mark - Action
-(void)pressRightButtonItem:(UIButton*)button{
    MenuItem *item1 = [MenuItem itemWithTitle:@"扫一扫" image:[UIImage imageNamed:@"扫一扫"]];
    MenuItem *item2 = [MenuItem itemWithTitle:@"添加好友" image:[UIImage imageNamed:@"添加好友"]];
    MenuItem *item3 = [MenuItem itemWithTitle:@"收付款" image:[UIImage imageNamed:@"收付款"]];
    PopViewController *vc = [PopViewController controllerWithSourceView:button data:@[item1, item2, item3] handler:^(NSInteger index) {
        [[ToastManager sharedInstance] showMessage:@"点击了第%li个", (long)index];
    }];
    [self presentViewController:vc animated:YES completion:nil];
}
-(void)pressRightItem:(UIBarButtonItem*)item{
    MenuItem *item1 = [MenuItem itemWithTitle:@"扫一扫" image:[UIImage imageNamed:@"扫一扫"]];
    MenuItem *item2 = [MenuItem itemWithTitle:@"添加好友" image:[UIImage imageNamed:@"添加好友"]];
    MenuItem *item3 = [MenuItem itemWithTitle:@"收付款" image:[UIImage imageNamed:@"收付款"]];
    PopViewController *vc = [PopViewController controllerWithBarButtonItem:item data:@[item1, item2, item3] handler:^(NSInteger index) {
        [[ToastManager sharedInstance] showMessage:@"点击了第%li个", (long)index];
    }];
    [self presentViewController:vc animated:YES completion:nil];
}

#pragma mark - Public
-(void)initTalbeView{
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:CellIdentifier];
}
-(void)initTableData{
    self.tableData = @[@"数据选择器(DataPicker)", @"日期选择器(DatePicker)",@"时间选择器(TimePicker)", @"日期时间选择器(DatetimePicker)",@"提示框(AlertController)", @"分享菜单(SharedViewController)", @"选择图片(SelectedPictureController)", @"底部伸缩菜单(BottomExpansionViewController)"];
}
//数据选择器
-(void)showMutableDataPicker{
    DataPickerViewController *controller = [DataPickerViewController dataPickerControllerWithTitle:@"标题" data:@[@"菜单一", @"菜单二", @"菜单三", @"菜单四"] handler:^(NSInteger index) {
        [[ToastManager sharedInstance] showMessage:@"点击了菜单第%li个",(long)index];
    }];
    [self presentViewController:controller animated:YES completion:nil];
}
//日期选择器
-(void)showDatePicker{
    DatePickerViewController *controller = [DatePickerViewController datePickerControllerWithTitle:@"选择日期" model:UIDatePickerModeDate handler:^(NSDate *date) {
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"yyyy-MM-dd";
        NSString* dateStr = [formatter stringFromDate:date];
        [[ToastManager sharedInstance] showMessage:@"日期是：%@", dateStr];
    }];
    [self presentViewController:controller animated:YES completion:nil];
}
//时间选择器
-(void)showTimePicker{
    DatePickerViewController *controller = [DatePickerViewController datePickerControllerWithTitle:@"选择时间" model:UIDatePickerModeTime handler:^(NSDate *date) {
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"HH:mm";
        NSString* dateStr = [formatter stringFromDate:date];
        [[ToastManager sharedInstance] showMessage:@"时间是：%@", dateStr];
    }];
    [self presentViewController:controller animated:YES completion:nil];
}
//日期时间选择器
-(void)showDatetimePicker{
    DatePickerViewController *controller = [DatePickerViewController datePickerControllerWithTitle:@"选择日期和时间" model:UIDatePickerModeDateAndTime handler:^(NSDate *date) {
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"yyyy-MM-dd HH:mm";
        NSString* dateStr = [formatter stringFromDate:date];
        [[ToastManager sharedInstance] showMessage:@"时间是：%@", dateStr];
    }];
    [self presentViewController:controller animated:YES completion:nil];
}
//提示框
-(void)showAlertController{
    DialogController *dialog = [DialogController dialogControllerWithTitle:@"Title" message:@"Message"];
    
    DialogAction *action = [DialogAction actionWithTitle:@"Action" handler:^(DialogAction * _Nonnull action) {
        
    }];
    
    [dialog addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        
    }];
    [dialog addAction:action];
    [self presentViewController:dialog animated:YES completion:^(){
        
    }];
}
//分享菜单
-(void)showSharedController{
    SharedAction *WXFriend = [SharedAction actionWithTitle:@"微信好友" image:[UIImage imageNamed:@"shared_微信好友"] handler:^(SharedAction *action) {
        DebugLog(@"微信好友");
    }];
    SharedAction *Weibo = [SharedAction actionWithTitle:@"微博" image:[UIImage imageNamed:@"shared_微博"] handler:^(SharedAction *action) {
        DebugLog(@"微博");
    }];
    SharedAction *WXCircle = [SharedAction actionWithTitle:@"朋友圈" image:[UIImage imageNamed:@"shared_朋友圈"] handler:^(SharedAction *action) {
        DebugLog(@"朋友圈");
    }];
    SharedViewController *controller = [SharedViewController controller];
    [controller addAction:WXFriend];
    [controller addAction:Weibo];
    [controller addAction:WXCircle];
    
    [self presentViewController:controller animated:YES completion:nil];
}

-(void)showSelectPictureController{
    SheetAction *takePhotosAction = [SheetAction actionWithTitle:@"拍照" image:nil handler:^(SheetAction *action) {
        DebugLog(@"拍照");
    }];
    SheetAction *albumAction = [SheetAction actionWithTitle:@"从手机相册选择" image:nil handler:^(SheetAction *action) {
        DebugLog(@"从相册选择");
    }];
    SheetController *controller = [SheetController controllerWithCancelTitle:@"取消"];
    [controller addAction:takePhotosAction];
    [controller addAction:albumAction];
    [self presentViewController:controller animated:YES completion:nil];
}

-(void)go2BottomExpansionVC{
    BottomExpansionViewController *controller = [[BottomExpansionViewController alloc] init];
    [self.navigationController pushViewController:controller animated:YES];
}
@end
