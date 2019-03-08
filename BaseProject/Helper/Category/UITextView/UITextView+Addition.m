//
//  UITextView+Addition.m
//  BaseProject
//
//  Created by 张熔冰 on 2017/12/8.
//  Copyright © 2017年 lovcreate. All rights reserved.
//

#import "UITextView+Addition.h"

@implementation UITextView (Addition)

-(void)_placeholder:(NSString*)placeholder{
    UILabel *placeHolderLabel = [[UILabel alloc] init];
    placeHolderLabel.text = placeholder;
    placeHolderLabel.numberOfLines = 0;
    placeHolderLabel.textColor = [UIColor lightGrayColor];
    [placeHolderLabel sizeToFit];
    [self addSubview:placeHolderLabel];
    
    placeHolderLabel.font = self.font;
    [self setValue:placeHolderLabel forKey:@"_placeholderLabel"];
}

@end
