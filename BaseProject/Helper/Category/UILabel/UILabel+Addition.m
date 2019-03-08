//
//  UILabel+Addition.m
//  BaseProject
//
//  Created by zhangrongbing on 2016/11/8.
//  Copyright © 2016年 lovcreate. All rights reserved.
//

#import "UILabel+Addition.h"

@implementation UILabel (Addition)

- (CGFloat)_textWith {
    CGFloat stringWidth = 0;
    CGSize size = CGSizeMake(MAXFLOAT, MAXFLOAT);
    if (self.text.length > 0) {
#if defined(__IPHONE_OS_VERSION_MAX_ALLOWED) && __IPHONE_OS_VERSION_MAX_ALLOWED >= 70000
        stringWidth =[self.text
                      boundingRectWithSize:size
                      options:NSStringDrawingUsesLineFragmentOrigin
                      attributes:@{NSFontAttributeName:self.font}
                      context:nil].size.width;
#else
        
        stringWidth = [self.text sizeWithFont:self.font
                            constrainedToSize:size
                                lineBreakMode:NSLineBreakByCharWrapping].width;
#endif
    }
    return stringWidth;
}

@end
