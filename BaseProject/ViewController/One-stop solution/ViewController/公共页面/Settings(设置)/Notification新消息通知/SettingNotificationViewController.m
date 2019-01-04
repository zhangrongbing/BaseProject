//
//  SettingNotificationViewController.m
//  BaseProject
//
//  Created by 张熔冰 on 2018/8/10.
//  Copyright © 2018年 Lovcreate. All rights reserved.
//

#import "SettingNotificationViewController.h"

@interface SettingNotificationViewController ()

@property(nonatomic, strong) UIView *cellView;
@property(nonatomic, strong) UILabel *titleLabel;
@property(nonatomic, strong) UILabel *subTitleLabel;
@property(nonatomic, strong) UILabel *explainLabel;

@end

@implementation SettingNotificationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = LCGetStringWithKeyFromTable(@"接受新消息通知", nil);
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    [self.view addSubview:self.cellView];
    [self.cellView addSubview:self.titleLabel];
    [self.cellView addSubview:self.subTitleLabel];
    [self.view addSubview:self.explainLabel];
    
    [self setupNotificationSettings];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setupNotificationSettings) name:UIApplicationDidBecomeActiveNotification object:nil];
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear: animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    BOOL isTranslucent = self.navigationController.navigationBar.isTranslucent;
    CGFloat y = 0.f;
    if (isTranslucent) {
        y = 64.f;
    }
    self.cellView.frame = CGRectMake(0, y+16, CGRectGetWidth(self.view.frame), 44.f);
    self.titleLabel.frame = CGRectMake(16, 0, CGRectGetWidth(self.titleLabel.frame), CGRectGetHeight(self.cellView.frame));
    self.subTitleLabel.frame = CGRectMake(CGRectGetWidth(self.view.frame) - CGRectGetWidth(self.subTitleLabel.frame) - 16, 0, CGRectGetWidth(self.subTitleLabel.frame), CGRectGetHeight(self.cellView.frame));
    [self.explainLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.cellView.mas_bottom).with.offset(16.f);
        make.left.mas_equalTo(16.f);
        make.right.mas_equalTo(-16.f);
    }];
}

#pragma mark - Getter and Setter
-(UIView*)cellView{
    if (!_cellView) {
        _cellView = [[UIView alloc] init];
        _cellView.backgroundColor = [UIColor whiteColor];
    }
    return _cellView;
}

-(UILabel*)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.text = LCGetStringWithKeyFromTable(@"接受新消息通知", nil);
        _titleLabel.font = [UIFont systemFontOfSize:15.f];
        _titleLabel.textColor = RGB(0x333333);
        [_titleLabel sizeToFit];
    }
    return _titleLabel;
}

-(UILabel*)subTitleLabel{
    if (!_subTitleLabel) {
        _subTitleLabel = [UILabel new];
        _subTitleLabel.text = LCGetStringWithKeyFromTable(@"未开启", nil);
        _subTitleLabel.font = [UIFont systemFontOfSize:15.f];
        _subTitleLabel.textColor = RGB(0x666666);
        [_subTitleLabel sizeToFit];
    }
    return _subTitleLabel;
}

-(UILabel*)explainLabel{
    if (!_explainLabel) {
        _explainLabel = [UILabel new];
        _explainLabel.font = [UIFont systemFontOfSize:15.f];
        _explainLabel.text = LCGetStringWithKeyFromTable(@"要开启或关闭_您可以在设置-通知中更改", nil);
        _explainLabel.numberOfLines = 0;
        _explainLabel.textColor = RGB(0x999999);
    }
    return _explainLabel;
}

#pragma mark - Public
-(void)setupNotificationSettings{
    UIUserNotificationSettings *setting = [[UIApplication sharedApplication] currentUserNotificationSettings];
    if (setting.types != UIUserNotificationTypeNone) {
        self.subTitleLabel.text = LCGetStringWithKeyFromTable(@"已开启", nil);
    }else{
        self.subTitleLabel.text = LCGetStringWithKeyFromTable(@"未开启", nil);
    }
}
@end
