//
//  UITableView+configure.h
//  PiggyTeacher
//
//  Created by 伯明利 on 2017/9/8.
//  Copyright © 2017年 伯明利. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableView (configure)

- (UIView *)topBackgroundViewWith:(UIColor *)color;

@property (nonatomic, strong) UIView *topBackgroundView;

@end
