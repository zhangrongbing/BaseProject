//
//  BaseTableViewController.h
//  BaseProject
//
//  Created by zhangrongbing on 2016/11/22.
//  Copyright © 2016年 lovcreate. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIViewController+PrensentAnimation.h"
#import "UINavigationController+PushAnimation.h"
#import "NetworkingManager.h"
#import "Constant.h"
#import "ToastManager.h"
#import "UIView+Addition.h"

@interface BaseTableViewController : UITableViewController

@property(nonatomic, strong) void(^handler)(void);
/**
 停止MJ刷新
 */
-(void)endMJRefreshing;

@end
