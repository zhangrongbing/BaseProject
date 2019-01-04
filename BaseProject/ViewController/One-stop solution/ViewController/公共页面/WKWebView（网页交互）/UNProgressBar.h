//
//  UNProgressBar.h
//  BaseProject
//
//  Created by bing liu on 2018/10/25.
//  Copyright © 2018 Lovcreate. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UNProgressBar : UIView

@property(nonatomic, assign) BOOL isLoading;
@property(nonatomic, assign) CGFloat progress;
@property(nonatomic, strong) UIView *progressView;

- (void)progressUpdate:(CGFloat)progress;
- (void)setProgressZero;

@end

NS_ASSUME_NONNULL_END
