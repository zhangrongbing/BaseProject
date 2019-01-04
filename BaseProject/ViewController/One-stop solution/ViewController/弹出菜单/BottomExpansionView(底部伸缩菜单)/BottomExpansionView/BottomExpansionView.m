//
//  DropUpView.m
//  hydra
//
//  Created by 张熔冰 on 2018/2/26.
//  Copyright © 2018年 lovcreate. All rights reserved.
//

#import "BottomExpansionView.h"
#import "UIView+Addition.h"
#import "UIColor+Addition.h"
#import "Masonry.h"

static CGFloat ButtonHeight = 40.f;
static CGFloat DefaultTitleHeight = 20.f;

@interface BottomExpansionView()<UITableViewDataSource, UITableViewDelegate>

@property(nonatomic, strong) NSArray* menuData;
@property(nonatomic, strong) UITableView* tableView;

@property(nonatomic, strong) UILabel* label;
@property(nonatomic, strong) UIButton* button;

@property(nonatomic, strong) void(^selectedBlock)(NSInteger index);
@property(nonatomic, assign) CGFloat heightOffset;
@end
@implementation BottomExpansionView

-(instancetype)initWithDefaultTitle:(NSString*)defaultTitle title:(NSString*)title data:(NSArray*)data selectedBlock:(void(^)(NSInteger index))block{
    if(self = [super initWithFrame:CGRectMake(0, kScreenHeight, kScreenWidth, ButtonHeight)]){
        self.backgroundColor = [UIColor whiteColor];
        self.layer.shadowColor = [UIColor blackColor].CGColor;
        self.layer.shadowOffset = CGSizeMake(0, -3);
        self.layer.shadowRadius = 3.f;
        self.layer.shadowOpacity = .2f;
        
        self.menuData = data;
        self.heightOffset = MIN(kScreenHeight/2.f+70, 136*self.menuData.count);
        self.selectedBlock = block;
        
        if (data.count > 0) {
            self.lc_h = 70.f;
            UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, DefaultTitleHeight)];
            label.textColor = RGBA(0x333333, 1);
            label.textAlignment = NSTextAlignmentCenter;
            label.font = [UIFont systemFontOfSize:16.f];
            label.text = title;
            [self addSubview:label];
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.right.top.equalTo(self);
                make.height.mas_equalTo(30.f);
            }];
            UIButton* button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, ButtonHeight)];
            [button setImage:[UIImage imageNamed:@"多上箭头"] forState:UIControlStateNormal];
            [button setImage:[UIImage imageNamed:@"多下箭头"] forState:UIControlStateSelected];
            [button addTarget:self action:@selector(pressOpenButton:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:button];
            [button mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.right.bottom.equalTo(self);
                make.height.mas_equalTo(ButtonHeight);
            }];
            self.label =label;
            self.button = button;
        }else{
            self.lc_h = ButtonHeight;
            UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, ButtonHeight)];
            label.text = defaultTitle;
            label.textAlignment = NSTextAlignmentCenter;
            label.textColor = RGBA(0x333333, 1);
            label.font = [UIFont systemFontOfSize:16.f];
            [self addSubview:label];
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.left.bottom.right.equalTo(self);
            }];
        }
    }
    return self;
}

-(void)didMoveToSuperview{
    CGFloat offsetY = 0.f;
    if (self.menuData.count > 0) {
        offsetY = 70.f;
    }else{
        offsetY = 40.f;
    }
    [UIView animateWithDuration:.3 animations:^{
        self.lc_y -= offsetY;
    } completion:^(BOOL finished) {
        
    }];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.menuData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [UITableViewCell new];
    cell.backgroundColor = [UIColor yellowColor];
    return cell;
}

#pragma mark - UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.selectedBlock) {
        self.selectedBlock(indexPath.row);
    }
}
#pragma mark - Action
//打开菜单
-(void)pressOpenButton:(UIButton*)button{
    self.userInteractionEnabled = NO;
    if (!button.isSelected) {//打开
        [self open];
    }else{//关闭
        [self close];
    }
    [button setSelected:!button.isSelected];
}

-(void)open{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, .1f) style:UITableViewStylePlain];
    [self.tableView setTableFooterView:[UIView new]];
    if (self.heightOffset == (kScreenHeight/2.f+70)) {
        self.tableView.scrollEnabled = YES;
    }else{
        self.tableView.scrollEnabled = NO;
    }
    self.tableView.rowHeight = 136.f;
    self.tableView.delegate = self;
    [self.tableView registerNib:[UINib nibWithNibName:@"InspectionStationListTableViewCell" bundle:nil] forCellReuseIdentifier:@"Cell"];
    [self addSubview:self.tableView];
    self.tableView.dataSource = self;
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.label.mas_bottom);
        make.left.right.equalTo(self);
        make.bottom.equalTo(self.button.mas_top);
    }];
    [UIView animateWithDuration:.3f animations:^{
        self.lc_y -= self.heightOffset;
        self.lc_h += self.heightOffset;
    } completion:^(BOOL finished) {
        self.userInteractionEnabled = YES;
    }];
    
}

-(void)close{
    [UIView animateWithDuration:.3f animations:^{
        self.lc_y += self.heightOffset;
        self.lc_h -= self.heightOffset;
    } completion:^(BOOL finished) {
        self.userInteractionEnabled = YES;
        self.tableView.dataSource = nil;
        [self.tableView removeFromSuperview];
    }];
}
@end
