//
//  MenuItem.m
//  BaseProject
//
//  Created by 张熔冰 on 2017/12/8.
//  Copyright © 2017年 lovcreate. All rights reserved.
//

#import "MenuItem.h"

@interface MenuItem()

@end

@implementation MenuItem

+(instancetype)itemWithTitle:(NSString*)title{
    MenuItem *item = [[MenuItem alloc] init];
    item.title = title;
    return item;
}
+(instancetype)itemWithImage:(UIImage*)image{
    MenuItem *item = [[MenuItem alloc] init];
    item.image = image;
    return item;
}

+(instancetype)itemWithTitle:(NSString*)title image:(UIImage*)image{
    MenuItem *item = [[MenuItem alloc] init];
    item.title = title;
    item.image = image;
    return item;
}

-(UIColor*)titleNormalColor{
    if (!_titleNormalColor) {
        return [UIColor blackColor];
    }
    return _titleNormalColor;
}
-(UIFont*) font{
    if (!_font) {
        return [UIFont systemFontOfSize:15.f];
    }
    return _font;
}
@end
