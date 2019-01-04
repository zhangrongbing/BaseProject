//
//  UIColor+Addition.m
//  BaseProject
//
//  Created by 张熔冰 on 2017/6/13.
//  Copyright © 2017年 lovcreate. All rights reserved.
//

#import "UIColor+Addition.h"

@implementation UIColor (Addition)

-(UIColor*)lc_toColor:(UIColor*)color ratio:(CGFloat)ratio{
    if (ratio > 1)
        ratio = 1;
    if (ratio < 0)
        ratio = 0;
    
    const CGFloat* components1 =  CGColorGetComponents(color.CGColor);
    const CGFloat* components2 = CGColorGetComponents(self.CGColor);
    
    CGFloat r = components1[0] * ratio + components2[0]*(1 - ratio);
    CGFloat g = components1[1] * ratio + components2[1]*(1 - ratio);
    CGFloat b = components1[2] * ratio + components2[2]*(1 - ratio);
    
    return [UIColor colorWithRed:r green:g blue:b alpha:1];
}

+(UIColor*)lc_colorWithRGB:(NSString*)rgbStr alpha:(float) alpha{
    if (rgbStr && rgbStr.length == 6 && alpha >= 0) {
        long red = strtoul([[rgbStr substringWithRange:NSMakeRange(0, 2)] UTF8String], 0, 16);
        long green = strtoul([[rgbStr substringWithRange:NSMakeRange(2, 2)] UTF8String], 0, 16);
        long blue = strtoul([[rgbStr substringWithRange:NSMakeRange(4, 2)] UTF8String], 0, 16);
        [UIColor colorWithRed:red green:green blue:blue alpha:MIN(1, alpha)];
    }else if(rgbStr.length == 8){
        long red = strtoul([[rgbStr substringWithRange:NSMakeRange(2, 2)] UTF8String], 0, 16);
        long green = strtoul([[rgbStr substringWithRange:NSMakeRange(4, 2)] UTF8String], 0, 16);
        long blue = strtoul([[rgbStr substringWithRange:NSMakeRange(5, 2)] UTF8String], 0, 16);
        [UIColor colorWithRed:red green:green blue:blue alpha:MIN(1, alpha)];
    }
    return [UIColor clearColor];
}

+(UIColor*)lc_randomColor{
    return [UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:1];
}

@end
