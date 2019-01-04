//
//  SheetViewController.h
//  BaseProject
//
//  Created by 张熔冰 on 2018/8/14.
//  Copyright © 2018年 Lovcreate. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BasePresentation;

@interface BaseAlertController : UIViewController

@property(nonatomic, assign) BOOL dismissForUserInterraction;//点击外部是否隐藏Controller

@end


@interface BasePresentation : UIPresentationController

@property(nonatomic, assign) BOOL dismissForUserInterraction;//点击外部是否隐藏Controller

@end
