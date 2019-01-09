//
//  PopTableViewController.h
//  BaseProject
//
//  Created by 张熔冰 on 2018/8/9.
//  Copyright © 2018年 Lovcreate. All rights reserved.
//

#import "PopoverViewController.h"

@class PopAction;
@interface PopViewController : PopoverViewController

+(instancetype)controllerWithSourceView:(UIView*)sourceView actions:(NSArray<PopAction*>*)actions handler:(void(^)(NSInteger index)) handler;

+(instancetype)controllerWithBarButtonItem:(UIBarButtonItem*)barItem actions:(NSArray<PopAction*>*)actions handler:(void(^)(NSInteger index)) handler;

@end

@interface PopAction : NSObject

@property(nonatomic, strong) UIImage *image;
@property(nonatomic, strong) NSString *title;

+(instancetype)actionWithTitle:(NSString*)title image:(UIImage *)image;

@end
