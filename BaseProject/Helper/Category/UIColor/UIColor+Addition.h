//
//  UIColor+Addition.h
//  BaseProject
//
//  Created by 张熔冰 on 2017/6/13.
//  Copyright © 2017年 lovcreate. All rights reserved.
//

#import <UIKit/UIKit.h>

#define RGBA(c,a) [UIColor colorWithRed:((c>>16)&0xFF)/255.0	\
                                 green:((c>>8)&0xFF)/255.0	\
                                  blue:(c&0xFF)/255.0         \
                                 alpha:a]
#define RGB(c) RGBA(c,1)

@interface UIColor (Addition)

-(UIColor*)_toColor:(UIColor*)color ratio:(CGFloat)ratio;

+(UIColor*)_colorWithRGB:(NSString*)rgbStr alpha:(float) alpha;

+(UIColor*)_randomColor;
@end
