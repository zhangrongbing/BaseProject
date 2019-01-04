//
//  SideViewController.h
//  BaseProject
//
//  Created by 张熔冰 on 2018/8/16.
//  Copyright © 2018年 Lovcreate. All rights reserved.
//

#import "BaseAlertController.h"

@interface SideViewController : BaseAlertController


@end

@interface SidePresentedAnimated : NSObject <UIViewControllerAnimatedTransitioning>



@end

@interface SideDismissedAnimated : NSObject <UIViewControllerAnimatedTransitioning>

@end

@interface SideController : BasePresentation

@end
