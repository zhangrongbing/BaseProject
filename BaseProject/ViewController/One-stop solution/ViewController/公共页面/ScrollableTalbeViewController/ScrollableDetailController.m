//
//  ScrollableTalbeViewController.m
//  BaseProject
//
//  Created by 张熔冰 on 2018/12/5.
//  Copyright © 2018年 Lovcreate. All rights reserved.
//

#import "ScrollableDetailController.h"
#import "ScallableImagesCell.h"
#import "UIImageView+AFNetworking.h"

#define kHeight 222.f//顶部预留高度

@interface ScrollableDetailController ()<UITableViewDelegate, UITableViewDataSource>

@property(nonatomic, strong) UITableView *tableView;

@end

@implementation ScrollableDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.backgroundName = @"mybg";
    [self initTableView];
    [self initImageView];
    [self setNavigationView];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}
#pragma mark - UITalbeViewDataSource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

static NSString *kCellIdentifier = @"Cell";
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ScallableImagesCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier forIndexPath:indexPath];
    return cell;
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    ScallableImagesCell *imageCell = (ScallableImagesCell *)cell;
    [imageCell setSourceData:@[@"1", @"2", @"3", @"4"] selectedBlock:^(NSInteger index) {
        DebugLog(@"点击了 %ld", (long)index);
    }];
}
#pragma mark - UIScrollViewDelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGPoint point = scrollView.contentOffset;
    if (point.y < -kHeight) {
        CGRect rect = [self.tableView viewWithTag:901].frame;
        rect.origin.y = point.y;
        rect.size.height = -point.y;
        [self.tableView viewWithTag:901].frame = rect;
    }
    UIView *navView = [self.view viewWithTag:902];
    UIButton *button = [navView.subviews lastObject];
    CGFloat rate = -scrollView.contentOffset.y/kHeight;
    button.alpha = rate;
    DebugLog(@"%.f",scrollView.contentOffset.y);
}

#pragma mark - Action
-(void)pressLeftButton:(UIButton*)button{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Public
-(void)initImageView{
    UIImageView *backgroundIV = nil;
    if ([self.backgroundName hasPrefix:@"http://"] || [self.backgroundName hasPrefix:@"https://"]) {
        backgroundIV = [[UIImageView alloc] init];
        [backgroundIV setImageWithURL:[NSURL URLWithString:_backgroundName]];
    }else{
        backgroundIV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:_backgroundName]];
    }
    backgroundIV.tag = 901;
    backgroundIV.contentMode = UIViewContentModeScaleAspectFill;
    backgroundIV.frame = CGRectMake(0, -kHeight, CGRectGetWidth(self.view.bounds), kHeight);
    backgroundIV.clipsToBounds = YES;
    [self.tableView addSubview:backgroundIV];
}

-(void)initTableView{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView setContentInset:UIEdgeInsetsMake(kHeight - 20, 0, 0, 0)];
    self.tableView.rowHeight = 80.f;
    self.tableView.estimatedRowHeight = 80.f;
    [self.tableView registerClass:[ScallableImagesCell class] forCellReuseIdentifier: kCellIdentifier];
    [self.view addSubview:self.tableView];
}

-(void)setNavigationView{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 64.f)];
    view.tag = 902;
    view.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.f];
    [self.view addSubview:view];
    
    UIButton *leftButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 60.f, CGRectGetHeight(view.bounds))];
    [leftButton setImage:[UIImage imageNamed:@"back_detail"] forState:UIControlStateNormal];
    [view addSubview:leftButton];
    [leftButton addTarget:self action:@selector(pressLeftButton:) forControlEvents:UIControlEventTouchUpInside];
}

@end
