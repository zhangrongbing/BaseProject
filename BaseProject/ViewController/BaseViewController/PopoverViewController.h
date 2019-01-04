//
//  PopoverController.h
//  BaseProject
//
//  Created by 张熔冰 on 2018/8/9.
//  Copyright © 2018年 Lovcreate. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kMenuItemHeight 44.f

@interface PopoverViewController : UIViewController<UIPopoverPresentationControllerDelegate>

@property(nonatomic, assign) CGSize contentSize;
@property(nonatomic, strong) UIView *sourceView;
@property(nonatomic, strong) UIBarButtonItem *barItem;

@end
