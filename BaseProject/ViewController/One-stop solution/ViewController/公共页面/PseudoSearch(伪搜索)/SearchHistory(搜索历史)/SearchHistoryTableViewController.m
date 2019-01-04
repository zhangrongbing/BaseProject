//
//  SearchHistoryTableViewController.m
//  BaseProject
//
//  Created by 张熔冰 on 2018/8/31.
//  Copyright © 2018年 Lovcreate. All rights reserved.
//

#import "SearchHistoryTableViewController.h"
#import "SearchHistoryTableViewCell.h"
#import "SearchHistoryTitleTableViewCell.h"
#import "DataBaseManager.h"
#import "SearchResultViewController.h"

@interface SearchHistoryTableViewController ()<UITextFieldDelegate, UITableViewDataSource, UITableViewDelegate>

@property(nonatomic, strong) UITableView *tableView;
@property(nonatomic, strong) NSMutableArray *tableData;

@end

@implementation SearchHistoryTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createTableView];

    NSString *rightItemTitle = LCGetStringWithKeyFromTable(@"取消", nil);
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:rightItemTitle style:UIBarButtonItemStylePlain target:self action:@selector(pressRightItem:)];
    self.navigationItem.rightBarButtonItem = rightItem;
    self.textField.tintColor = [UIColor blueColor];
    [self.textField becomeFirstResponder];
    self.textField.returnKeyType = UIReturnKeySearch;
    self.textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.textField.placeholder = LCGetStringWithKeyFromTable(@"搜索", nil);
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tableData = [[DataBaseManager sharedInstance] queryHistoryKeywords];
    self.navigationItem.leftBarButtonItem = nil;
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)dealloc{
    DebugLog(@"");
}

#pragma mark - Action
-(void)pressRightItem:(UIBarButtonItem*)item{
    [self dismissViewControllerAnimated:NO completion:nil];
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    NSString *keywords = textField.text;
    [[DataBaseManager sharedInstance] insertHistoryKeywords:keywords];
    SearchResultViewController *controller = [[SearchResultViewController alloc] init];
    controller.keywords = keywords;
    [self.navigationController pushViewController:controller animated:YES];
    return YES;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.tableData.count == 0) {
        return 0;
    }
    return self.tableData.count + 1;
}

static NSString *TitleCellIdentifier = @"TitleCellIdentifier";
static NSString *CellIdentifier = @"CellIdentifier";
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        __weak typeof(self) weakSelf = self;
        SearchHistoryTitleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:TitleCellIdentifier forIndexPath:indexPath];
        [cell setClearHandler:^{
            [weakSelf.tableData removeAllObjects];
            [[DataBaseManager sharedInstance] removeHistoryForCurrentUser];
            [tableView reloadData];
        }];
        return cell;
    }
    NSString *keywords = [self.tableData objectAtIndex:indexPath.row - 1];
    SearchHistoryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    [cell setTitle:keywords];
    return cell;
}

#pragma mark - UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 0) {
        return;
    }
    NSString *keywords = [self.tableData objectAtIndex:indexPath.row - 1];
    [[DataBaseManager sharedInstance] insertHistoryKeywords:keywords];
    SearchResultViewController *controller = [[SearchResultViewController alloc] init];
    controller.keywords = keywords;
    [self.textField resignFirstResponder];
    [self.navigationController pushViewController:controller animated:YES];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return 48.f;
    }
    return 46.f;
}

#pragma mark - Public
-(void)createTableView{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    UINib *cellNib = [UINib nibWithNibName:@"SearchHistoryTableViewCell" bundle:nil];
    [self.tableView registerNib:cellNib forCellReuseIdentifier:CellIdentifier];
    UINib *titleNib = [UINib nibWithNibName:@"SearchHistoryTitleTableViewCell" bundle:nil];
    [self.tableView registerNib:titleNib forCellReuseIdentifier:TitleCellIdentifier];
    self.tableView.tableFooterView = [UIView new];
    self.tableView.separatorInset = UIEdgeInsetsMake(0, 16, 0, 16);
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.view addSubview:self.tableView];
}
@end
