//
//  NavigationBarViewController.m
//  BaseProject
//
//  Created by 张熔冰 on 2018/8/24.
//  Copyright © 2018年 Lovcreate. All rights reserved.
//

#import "NavigationBarViewController.h"
#import "UIImage+Addition.h"

@interface NavigationBarViewController ()<UITableViewDelegate, UITableViewDataSource>

@property(nonatomic, strong) UITableView *tableView;

@end

@implementation NavigationBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    [self createItem];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 50;
}

static NSString *CellIdentifier = @"Cell";
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:@"第%li行", (long)indexPath.row];
    return cell;
}

#pragma mark - UIScrollViewDelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGPoint offset = scrollView.contentOffset;
    CGFloat offsetY = offset.y;
    
    float percent = 1 - MAX(130 - offsetY, 0)/130.1f;
    UIColor *color = RGBA(0xFF0000, percent);
    UIImage *image = [UIImage _imageWithColor:color];
    [self.navigationController.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
}
#pragma mark - Getter and Setter

-(UITableView*)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStylePlain];
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:CellIdentifier];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.rowHeight = 44.f;
        _tableView.estimatedRowHeight = 44.f;
    }
    return _tableView;
}

#pragma mark - Public
-(void)createItem{
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(pressLeftItem:)];
    self.navigationItem.leftBarButtonItem = leftItem;
}

#pragma mark - Action
-(void)pressLeftItem:(UIBarButtonItem*)item{
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
