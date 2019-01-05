//
//  ContainerViewController.h
//  BaseProject
//
//  Created by 张熔冰 on 2018/8/6.
//  Copyright © 2018年 Lovcreate. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SegmentControl.h"

@interface ContainerViewController : UIViewController

/**
 当前显示的controller 默认是第0个
 */
@property(nonatomic, strong) UIColor *sliderViewColor;
@property(nonatomic, strong, readonly) SegmentControl *segmentControl;

+(instancetype)containerWithControllers:(NSArray*)controllers defalutControllerIndex:(NSInteger)index;

@end
