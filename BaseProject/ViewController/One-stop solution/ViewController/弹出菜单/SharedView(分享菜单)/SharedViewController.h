//
//  SharedViewController.h
//  BaseProject
//
//  Created by 张熔冰 on 2018/8/13.
//  Copyright © 2018年 Lovcreate. All rights reserved.
//

#import "BaseAlertController.h"

@class SharedAction;

@interface SharedViewController : BaseAlertController

@property(nonatomic, assign) CGFloat cornerRadius;
@property(nonatomic, assign) UIRectCorner rectCorner;

+(instancetype)controller;
-(void)addAction:(SharedAction *)action;

@end

@interface SharedPresnetation : BasePresentation

@end

@interface SharedAction : NSObject

@property(nonatomic, strong) NSString *title;
@property(nonatomic, strong) UIImage *image;
@property(nonatomic, strong) void(^handler)(SharedAction* action);

+(instancetype)actionWithTitle:(NSString*)title image:(UIImage*)image handler:(void(^)(SharedAction* action)) handler;

@end
