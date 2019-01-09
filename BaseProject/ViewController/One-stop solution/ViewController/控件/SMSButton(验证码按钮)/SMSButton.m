//
//  SMSButton.m
//  BaseProject
//
//  Created by 张熔冰 on 2018/6/24.
//  Copyright © 2018年 Lovcreate. All rights reserved.
//

#import "SMSButton.h"
#import "Constant.h"

#define kDefaultMaxTime 5

@interface SMSButton()

@property(nonatomic, strong) NSTimer *timer;//倒计时器
@property(nonatomic, strong) NSRunLoop *loop;
@property(nonatomic, assign) NSInteger second;//当前秒数

@end

@implementation SMSButton

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]) {
        [self setup];
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}

-(void)setup{
    NSString* title = LCGetStringWithKeyFromTable(@"获取验证码", nil);
    [self setTitle:title forState:UIControlStateNormal];
    [self addTarget:self action:@selector(performTapMethod:) forControlEvents:UIControlEventTouchUpInside];
    self.second = kDefaultMaxTime + 1;
    //定时器
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSDefaultRunLoopMode];
    [self.timer setFireDate:[NSDate distantFuture]];
}

#pragma mark - Action

//点击事件
-(void)performTapMethod:(UIButton*)button{
    [self setEnabled:NO];
    [self setTitle:[self compoundTitle] forState:UIControlStateDisabled];
    [self.timer setFireDate:[NSDate distantPast]];
}

//循环调用，计算倒计时
-(void)performCalculateTime{
    self.second --;
    if (self.second >= 0) {
        [self setTitle:[self compoundTitle] forState:UIControlStateDisabled];
    }else{
        [self setEnabled:YES];
        [self.timer setFireDate:[NSDate distantFuture]];
        self.second = kDefaultMaxTime;
    }
}

#pragma mark - Getter and Setter
-(NSTimer*)timer{
    if (!_timer) {
        _timer = [NSTimer timerWithTimeInterval:1.f target:self selector:@selector(performCalculateTime) userInfo:nil repeats:YES];
    }
    return _timer;
}

#pragma mark - Public
//合成标题
-(NSString *)compoundTitle{
    NSString *placeholder = LCGetStringWithKeyFromTable(@"s 后重试", nil);
    NSString *compoundTitle = [NSString stringWithFormat:@"%li%@", (long)self.second, placeholder];
    return compoundTitle;
}
@end
