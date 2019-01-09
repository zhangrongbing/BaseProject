//
//  LCStarEvaluator.m
//  OrderCar-Driver
//
//  Created by 伯明利 on 17/2/9.
//  Copyright © 2017年 lovcreate. All rights reserved.
//

#import "LCStarEvaluator.h"

@interface LCStarEvaluator ()
/**
 *一个星星+间隙的宽度
 */
@property (nonatomic, assign) CGFloat aWidth;
/**
 *一个星星的宽度
 */
@property (nonatomic, assign) CGFloat aStarWidth;
/**
 *手势所在的点的距离
 */
@property (nonatomic, assign) CGFloat touchX;

@end

@implementation LCStarEvaluator

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.currentValue = 0;
        self.starSpace = 1;
        self.backgroundColor = [UIColor clearColor];
        [self setNeedsDisplay];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    self.currentValue = 0;
    self.starSpace = 1;
    self.backgroundColor = [UIColor clearColor];
    [self setNeedsDisplay];
}

// 外界赋值时,将评分转换成点位置,进而绘制出评分星星
- (void)setCurrentValue:(float)currentValue {
    _currentValue = currentValue;
    
    if (currentValue != floorf(currentValue) && _isInteger == NO) {
        currentValue = floorf(currentValue) + 0.5;
        _currentValue = currentValue;
    }
    
    CGFloat width = (self.bounds.size.width - _starSpace * 4) / 5;
    self.touchX = (int)currentValue * (width + _starSpace) + (currentValue - (int)currentValue) * width;
    [self setNeedsDisplay];
}

// 手势点击时评分动态变化
- (BOOL)beginTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event {
    CGPoint touchPoint = [touch locationInView:self];
    
    int t = (int)(touchPoint.x / self.aWidth);
    float f = (touchPoint.x - t * _starSpace - t * self.aStarWidth) / self.aStarWidth;
    f = f>1.0?1.0:f;
    self.currentValue = t + f;
    
    self.touchX = touchPoint.x;
    
    //取整
    if (_isInteger) {
        self.currentValue = t + 1;
        
        CGFloat width = (self.bounds.size.width - _starSpace * 4) / 5;
        self.touchX = (width + _starSpace) * self.currentValue;
    }
    
    [self setNeedsDisplay];
    
    return YES;
}

// 手势移动时评分动态变化
- (BOOL)continueTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event {
    CGPoint touchPoint = [touch locationInView:self];
    
    // 防止越界
    if (touchPoint.x >= self.frame.size.width) {
        touchPoint.x = self.frame.size.width;
    }
    
    if (touchPoint.x <= 0) {
        touchPoint.x = 0;
    }
    
    //根据拖动的位置计算出分数
    int t = (int)(touchPoint.x / self.aWidth);
    float f = (touchPoint.x - t * _starSpace - t * self.aStarWidth) / self.aStarWidth;
    f = f > 1.0 ? 1.0 : f;
    self.currentValue = t + f;
    
    self.touchX = touchPoint.x;
    
    //取整
    if (_isInteger) {
        self.currentValue = t + 1;
        
        CGFloat width = (self.bounds.size.width - _starSpace * 4) / 5;
        self.touchX = (width + _starSpace) * self.currentValue;
    }
    
    [self setNeedsDisplay];
    
    return YES;
}

// 绘制出评分星星
- (void)drawRect:(CGRect)rect {
    
    CGFloat width = (self.bounds.size.width - _starSpace * 4) / 5;
    
    self.aStarWidth = width;
    self.aWidth = width + _starSpace;
    
    UIImage *image = [UIImage imageNamed:@"waiting-arrive-evaluation-star-pre"];
    for (int i = 0; i < 5; i ++) {
        CGRect rect = CGRectMake(i * (width + _starSpace), 0, width, width);
        [image drawInRect:rect];
    }
    
    //未评分区间颜色
    [[UIColor lightGrayColor] setFill];
    UIRectFillUsingBlendMode(rect, kCGBlendModeSourceIn);
    
    //评分区间颜色
    CGRect newRect = CGRectMake(0, 0, self.touchX, rect.size.height);
    [RGBA(0xFBB84C,1) set];
    UIRectFillUsingBlendMode(newRect, kCGBlendModeSourceIn);
    
    if ([self.delegate respondsToSelector:@selector(starEvaluator:currentValue:)]) {
        [self.delegate starEvaluator:self currentValue:self.currentValue];
    }
}
@end
