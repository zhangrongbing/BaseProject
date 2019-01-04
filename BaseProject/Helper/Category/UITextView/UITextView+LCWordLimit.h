//
//  UITextView+LCWordLimit.h
//  BaseProject
//
//  Created by 张熔冰 on 2018/4/19.
//  Copyright © 2018年 lovcreate. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextView (LCWordLimit)<UITextViewDelegate>

- (void)lc_wordLimit:(NSInteger)count;

@property (nonatomic, copy, readonly) NSString *lc_maxLength;//限制字数

@end
