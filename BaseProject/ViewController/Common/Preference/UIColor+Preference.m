//
//  UIColor+Preference.m
//  BaseProject
//
//  Created by 张熔冰 on 2019/1/9.
//  Copyright © 2019年 Lovcreate. All rights reserved.
//

#import "UIColor+Preference.h"

#define RGBA(c,a) [UIColor colorWithRed:((c>>16)&0xFF)/255.0    \
green:((c>>8)&0xFF)/255.0    \
blue:(c&0xFF)/255.0         \
alpha:a]

@implementation UIColor (Preference)

+(UIColor *)tableViewSeparatorColor{
    return RGBA(0xF3F3F3, 1);
}

@end
