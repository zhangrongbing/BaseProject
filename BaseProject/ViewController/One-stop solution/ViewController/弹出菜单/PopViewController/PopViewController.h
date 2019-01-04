//
//  PopTableViewController.h
//  BaseProject
//
//  Created by 张熔冰 on 2018/8/9.
//  Copyright © 2018年 Lovcreate. All rights reserved.
//

#import "PopoverViewController.h"
#import "MenuItem.h"

@interface PopViewController : PopoverViewController


+(instancetype)controllerWithSourceView:(UIView*)sourceView data:(NSArray<MenuItem*>*)items handler:(void(^)(NSInteger index)) handler;

+(instancetype)controllerWithBarButtonItem:(UIBarButtonItem*)barItem data:(NSArray<MenuItem*>*)items handler:(void(^)(NSInteger index)) handler;

@end
