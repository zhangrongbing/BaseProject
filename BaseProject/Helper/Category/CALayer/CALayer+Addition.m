//
//  CALayer+Addition.m
//  OrderCar
//
//  Created by zhangrongbing on 2016/12/20.
//  Copyright © 2016年 lovcreate. All rights reserved.
//

#import "CALayer+Addition.h"

@implementation CALayer (Addition)

- (void)setBorderUIColor:(UIColor *)color{
    self.borderColor = color.CGColor;
}

-(void)setShadowUIColor:(UIColor*)color{
    self.shadowColor = color.CGColor;
}

@end
