//
//  UIScrollView+Refresh.h
//  Bear
//
//  Created by 伯明利 on 2017/10/24.
//  Copyright © 2017年 lovcreate. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MJRefresh.h>

@interface UIScrollView (Refresh)

- (void)refreshHeaderWithBlock:(void(^)(void))block;
- (void)refreshFooterWithBlock:(void(^)(void))block;

- (void)addNoDataView;

- (void)removeNoDataView;

/**
 暂无数据
 */
@property (nonatomic, strong) UIView *noDataView;

@end
