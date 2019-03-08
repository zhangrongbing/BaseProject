//
//  BaseViewController.h
//  BaseProject
//
//  Created by zhangrongbing on 2016/11/22.
//  Copyright © 2016年 lovcreate. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SwipeBack.h"
#import "UIView+Addition.h"
#import "UIColor+Addition.h"
#import "NSString+Addition.h"
#import "NetworkingManager.h"
#import "Verification.h"
#import "Masonry.h"
#import "UIViewController+PrensentAnimation.h"
#import "UINavigationController+PushAnimation.h"
#import "BaseNavigationController.h"
#import "BaseOperation.h"
#import "Constant.h"
#import "ToastManager.h"

@interface BaseViewController : UIViewController

-(void)showLoadingView;

-(void)hideLoadingView;

@end
