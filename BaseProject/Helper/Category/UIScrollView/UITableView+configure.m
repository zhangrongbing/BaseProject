//
//  UITableView+configure.m
//  PiggyTeacher
//
//  Created by 伯明利 on 2017/9/8.
//  Copyright © 2017年 伯明利. All rights reserved.
//

#import "UITableView+configure.h"
#import <objc/runtime.h>

@implementation UITableView (configure)

- (UIView *)topBackgroundViewWith:(UIColor *)color {
    self.backgroundColor = [UIColor clearColor];
    if (self.backgroundView == nil) {
        self.backgroundView = [[UIView alloc] init];
    }
    UIView *topBackgroundView = [[UIView alloc] init];
    topBackgroundView.backgroundColor = color;
    [self.backgroundView addSubview:topBackgroundView];
    self.topBackgroundView = topBackgroundView;
    
    [self addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
    
    return topBackgroundView;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"contentOffset"]) {
        self.topBackgroundView.frame = CGRectMake(0, 0, CGRectGetWidth(self.frame), MAX(self.contentInset.top - self.contentOffset.y, 0));
    }
}

static const void *topBackgroundViewKey = &topBackgroundViewKey;

- (void)setTopBackgroundView:(UIView *)topBackgroundView {
    objc_setAssociatedObject(self, &topBackgroundViewKey, topBackgroundView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIView *)topBackgroundView {
    return objc_getAssociatedObject(self, &topBackgroundViewKey);
}
@end
