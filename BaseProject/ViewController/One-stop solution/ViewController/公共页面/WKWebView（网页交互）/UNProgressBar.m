//
//  UNProgressBar.m
//  BaseProject
//
//  Created by bing liu on 2018/10/25.
//  Copyright © 2018 Lovcreate. All rights reserved.
//

#import "UNProgressBar.h"
#import "UIView+Frame.h"

#define  ScreenWidth [[UIScreen mainScreen] bounds].size.width
#define UIColorFromHex(rgbValue)            [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16)) / 255.0 green:((float)((rgbValue & 0xFF00) >> 8)) / 255.0 blue:((float)(rgbValue & 0xFF)) / 255.0 alpha:1.0]

@interface UNProgressBar ()

@property(nonatomic, strong) NSTimer *progressTimer;

@end

@implementation UNProgressBar

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.progressView];
    }
    return self;
}

- (void)progressUpdate:(CGFloat)progress {
    if (!_isLoading) { return; }
    
    if (progress == 1) {
        if (ScreenWidth > 0) {
            [self finishProgress];
        }
    } else {
        _progress = progress;
        [self initProgressTimer];
    }
}

- (void)setProgressZero {
    [self deallocProgressTimer];
    _progressView.width = 0;
}

- (void)initProgressTimer {
    if (!_progressTimer || !_progressTimer.isValid) {
        _progressTimer = [NSTimer scheduledTimerWithTimeInterval:.02 target:self selector:@selector(progressTimerAction:) userInfo:nil repeats:YES];
    }
}

- (void)finishProgress {
    [self deallocProgressTimer];
    NSTimeInterval inter = .2;
    if (_progressView.width < ScreenWidth * 0.5) {
        inter = .3;
    }
    
    if (_progressView.width > 0) {
        [UIView animateWithDuration:inter animations:^{
            self.progressView.width = ScreenWidth;   //先滑到最后再消失
        } completion:^(BOOL finished) {
            self.progressView.width = 0;
        }];
    }
}

- (void)deallocProgressTimer {
    [_progressTimer invalidate];
    _progressTimer = nil;
}

- (void)progressTimerAction:(NSTimer *)timer {
    if (!_isLoading) {
        [self finishProgress];
        return;
    }
    
    CGFloat viewWidth = ScreenWidth;
    CGFloat progressWidth = viewWidth * 0.005; //千分之五,4s钟走完
    CGFloat currentProgressWidth = _progressView.width;
    CGFloat currentProgress = currentProgressWidth / viewWidth;
    
    if (currentProgress < _progress) {
        //当前的进度比真实进度慢，快速加载
        progressWidth = viewWidth * 0.01;
    }
    
    if (currentProgressWidth < viewWidth * 0.98) {
        //到达99%的时候等待网页进度
        _progressView.width = currentProgressWidth + progressWidth;
    } else {
        if (!_isLoading) {
            [self finishProgress];
        }
    }
}

#pragma mark - Getter

- (UIView *)progressView {
    if (!_progressView) {
        _progressView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 2)];
        _progressView.backgroundColor = UIColorFromHex(0xff9f51);
    }
    return _progressView;
}


@end
