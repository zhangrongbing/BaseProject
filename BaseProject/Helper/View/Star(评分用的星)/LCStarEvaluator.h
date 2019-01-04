//
//  LCStarEvaluator.h
//  OrderCar-Driver
//
//  Created by 伯明利 on 17/2/9.
//  Copyright © 2017年 lovcreate. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIColor+Addition.h"

@class LCStarEvaluator;

@protocol LCStarEvaluatorDelegate <NSObject>

@optional

/**
 代理方法 动态获取评分
 */
- (void)starEvaluator:(LCStarEvaluator *)evaluator currentValue:(float)value;

@end

@interface LCStarEvaluator : UIControl

@property (assign, nonatomic) id<LCStarEvaluatorDelegate>delegate;

/**
 星星之间的间距，默认1
 */
@property (nonatomic, assign) float starSpace;

/**
 是否取整，默认NO
 */
@property (assign, nonatomic) BOOL isInteger;

/**
 当前评分
 */
@property (nonatomic, assign) float currentValue;

@end
