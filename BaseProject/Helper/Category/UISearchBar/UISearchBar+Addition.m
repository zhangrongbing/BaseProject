//
//  UISearchBar+Addition.m
//  sparrow
//
//  Created by 张熔冰 on 2018/3/10.
//  Copyright © 2018年 lovcreate. All rights reserved.
//

#import "UISearchBar+Addition.h"

@implementation UISearchBar (Addition)

-(void)_cornerRadius:(CGFloat)cornerRadius{
    for (UIView *view in self.subviews.lastObject.subviews) {
        if([view isKindOfClass:NSClassFromString(@"UISearchBarTextField")]) {
            UITextField *textField = (UITextField *)view;
            
            textField.clipsToBounds = YES;
            textField.layer.masksToBounds = YES;
            textField.clipsToBounds = YES;
            textField.layer.cornerRadius = cornerRadius;
            break;
        }
    }
}

-(void)_borderWidth:(CGFloat)width color:(UIColor*)color{
    for (UIView *view in self.subviews.lastObject.subviews) {
        if([view isKindOfClass:NSClassFromString(@"UISearchBarTextField")]) {
            UITextField *textField = (UITextField *)view;
            
            textField.clipsToBounds = YES;
            textField.layer.masksToBounds = YES;
            textField.layer.borderColor = color.CGColor;
            textField.layer.borderWidth = width;
            break;
        }
    }
}
@end
