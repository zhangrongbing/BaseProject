//
//  LoginUserView.m
//  BaseProject
//
//  Created by 张熔冰 on 2018/12/10.
//  Copyright © 2018年 Lovcreate. All rights reserved.
//

#import "LoginUserView.h"

#define kSpacing 4.f

@interface LoginUserView()

@property(nonatomic, strong) UIImageView *iconView;
@property(nonatomic, strong) UILabel *nicknameLabel;

@end

@implementation LoginUserView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.clipsToBounds = YES;
    }
    return self;
}

-(void)showUserIcon:(UIImage*)image nickName:(NSString*)nickName{
    if (_iconView || _nicknameLabel) {
        [self hide];
    }
    UILabel *nicknameLabel = [[UILabel alloc] init];
    nicknameLabel.text = nickName;
    nicknameLabel.font = [UIFont systemFontOfSize:12.f];
    nicknameLabel.alpha = 0.f;
    [nicknameLabel sizeToFit];
    CGRect nicknameFrame = nicknameLabel.frame;
    nicknameFrame.origin.y = CGRectGetHeight(self.frame) - CGRectGetHeight(nicknameFrame);
    nicknameFrame.origin.x = CGRectGetWidth(self.frame) - nicknameFrame.size.width*1.5;
    nicknameLabel.frame = nicknameFrame;
    [self addSubview:nicknameLabel];
    
    self.nicknameLabel = nicknameLabel;
    
    CGFloat imageHeight = CGRectGetHeight(self.frame) - CGRectGetHeight(nicknameFrame) - kSpacing;
    UIImageView *iconView = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.frame) - imageHeight, -imageHeight/2.f, imageHeight, imageHeight)];
    [iconView setImage:image];
    iconView.layer.masksToBounds = YES;
    iconView.layer.cornerRadius = imageHeight/2.f;
    iconView.alpha = 0.f;
    iconView.contentMode = UIViewContentModeScaleAspectFill;
    [self addSubview:iconView];
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:.3 animations:^{
        iconView.frame = CGRectMake(CGRectGetWidth(weakSelf.frame) - imageHeight, 0, imageHeight, imageHeight);
        iconView.alpha = 1.f;
    }];
    CGFloat right = 0.f;
    if (CGRectGetWidth(nicknameFrame) > imageHeight) {
        right = 0.f;
    }else{
        right = (imageHeight - CGRectGetWidth(nicknameFrame))/2.f;
    }
    [UIView animateWithDuration:.3 delay:.2 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        nicknameLabel.frame = CGRectMake(CGRectGetWidth(weakSelf.frame) - CGRectGetWidth(nicknameFrame) - right, CGRectGetMinY(nicknameFrame), CGRectGetWidth(nicknameFrame), CGRectGetHeight(nicknameFrame));
        nicknameLabel.alpha = 1.f;
    } completion:nil];
    
    self.iconView = iconView;
}

-(void)hide{
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    self.nicknameLabel = nil;
    self.iconView = nil;
}
@end
