//
//  ContainerView.h
//  BaseProject
//
//  Created by 张熔冰 on 2018/8/6.
//  Copyright © 2018年 Lovcreate. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SegmentControl.h"

@interface ContainerView : UIView

@property(nonatomic, strong) UIColor *sliderViewColor;
@property(nonatomic, assign) SegmentControlStyle style;
@property(nonatomic, strong) NSArray *viewControllers;

-(instancetype)initWithFrame:(CGRect)frame style:(SegmentControlStyle)style;
-(void)setViewControllers:(NSArray*)viewControllers defaultIndex:(NSInteger)index;
@end
