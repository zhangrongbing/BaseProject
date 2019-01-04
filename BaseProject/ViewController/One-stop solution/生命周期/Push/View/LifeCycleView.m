//
//  LifeCycleView.m
//  BaseProject
//
//  Created by 张熔冰 on 2018/8/27.
//  Copyright © 2018年 Lovcreate. All rights reserved.
//

#import "LifeCycleView.h"

@implementation LifeCycleView

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]) {
        DebugLog(@"");
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.contentMode = UIViewContentModeRedraw;
        DebugLog(@"");
    }
    return self;
}
-(void)awakeFromNib{
    [super awakeFromNib];
    DebugLog(@"");
}

-(void)layoutSubviews{
    [super layoutSubviews];
    DebugLog(@"");
}

-(void)layoutSublayersOfLayer:(CALayer *)layer{
    [super layoutSublayersOfLayer:layer];
    DebugLog(@"");
}
-(void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    DebugLog(@"");
}

-(void)willMoveToWindow:(UIWindow *)newWindow{
    [super willMoveToWindow:newWindow];
    DebugLog(@"");
}

-(void)didMoveToWindow{
    [super didMoveToWindow];
    DebugLog(@"");
}

- (void)willMoveToSuperview:(nullable UIView *)newSuperview{
    [super willMoveToSuperview:newSuperview];
    DebugLog(@"");
}

-(void)didMoveToSuperview{
    [super didMoveToSuperview];
    DebugLog(@"");
}


@end
