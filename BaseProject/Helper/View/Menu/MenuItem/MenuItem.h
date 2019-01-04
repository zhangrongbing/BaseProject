//
//  MenuItem.h
//  BaseProject
//
//  Created by 张熔冰 on 2017/12/8.
//  Copyright © 2017年 lovcreate. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface MenuItem : NSObject

@property(nonatomic, strong) NSString* title;//菜单标题文字
@property(nonatomic, strong) UIFont* font;//菜单标题文字
@property(nonatomic, strong) UIColor* titleNormalColor;//菜单标题文字
@property(nonatomic, strong) UIColor* titleSelectedColor;//菜单标题文字
@property(nonatomic, strong) UIImage* image;
@property(nonatomic, strong) UIColor* backgroundColor;//背景颜色
@property(nonatomic, strong) void(^handler)(MenuItem*);//回调块

+(instancetype)itemWithTitle:(NSString*)title;
+(instancetype)itemWithImage:(UIImage*)image;
+(instancetype)itemWithTitle:(NSString*)title image:(UIImage*)image;
@end
