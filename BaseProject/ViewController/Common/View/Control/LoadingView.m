//
//  LoadingView.m
//  BaseProject
//
//  Created by 张熔冰 on 2019/2/12.
//  Copyright © 2019年 Lovcreate. All rights reserved.
//

#define kNoticStrings @[@"正在拼命加载",@"前方发现楼主",@"年轻人,不要着急",@"让我飞一会儿",@"大爷,您又来了?",@"楼主正在抓皮卡丘，等他一会儿吧",@"爱我，就等我一万年",@"未满18禁止入内",@"正在前往 花村",@"正在前往 阿努比斯神殿",@"正在前往 沃斯卡娅工业区",@"正在前往 观测站：直布罗陀",@"正在前往 好莱坞",@"正在前往 66号公路",@"正在前往 国王大道",@"正在前往 伊利奥斯",@"正在前往 漓江塔",@"正在前往 尼泊尔"]

#import "LoadingView.h"

@interface LoadingView()

@property(nonatomic, strong) UIActivityIndicatorView *indicatorView;
@property(nonatomic, strong) UILabel *noticeLabel;

@end

@implementation LoadingView

- (instancetype)init{
    if (self = [super init]) {
        self.translatesAutoresizingMaskIntoConstraints = NO;
        self.indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        self.indicatorView.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:self.indicatorView];
        
        self.noticeLabel = [[UILabel alloc] init];
        self.noticeLabel.translatesAutoresizingMaskIntoConstraints = NO;
        self.noticeLabel.text = kNoticStrings[arc4random() % ([kNoticStrings count] - 1)];
        self.noticeLabel.font = [UIFont systemFontOfSize:10.f];
        self.noticeLabel.textColor = [UIColor grayColor];
        [self.noticeLabel sizeToFit];
        [self addSubview:self.noticeLabel];
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    if (self.indicatorView) {
        NSLayoutConstraint *consCenterY = [NSLayoutConstraint constraintWithItem:self.indicatorView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0];
        NSLayoutConstraint *consCenterX = [NSLayoutConstraint constraintWithItem:self.indicatorView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0];
        [self addConstraints:@[consCenterX, consCenterY]];
    }
    if(self.noticeLabel){
        UILabel *noticLabel = self.noticeLabel;
        UIActivityIndicatorView *indicatorView = self.indicatorView;
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[indicatorView]-8-[noticLabel]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(noticLabel, indicatorView)]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:noticLabel attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1.f constant:0]];
    }
}

-(void)willMoveToSuperview:(UIView *)newSuperview{
    [super willMoveToSuperview:newSuperview];
    [self.indicatorView startAnimating];
}
@end
