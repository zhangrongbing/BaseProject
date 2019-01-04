//
//  UIScrollView+Refresh.m
//  Bear
//
//  Created by 伯明利 on 2017/10/24.
//  Copyright © 2017年 lovcreate. All rights reserved.
//

#import "UIScrollView+Refresh.h"

@implementation UIScrollView (Refresh)
#pragma mark - refresh
- (void)refreshHeaderWithBlock:(void (^)(void))block {
    __block typeof(self) blockSelf = self;
    MJRefreshGifHeader *mjHeader = [MJRefreshGifHeader headerWithRefreshingBlock:^{
        [blockSelf removeNoDataView];
        block();
    }];
//    mjHeader.lastUpdatedTimeLabel.hidden = YES;
//    mjHeader.stateLabel.hidden = YES;
//    [mjHeader setImages:[self imagesWithLoading] forState:MJRefreshStateRefreshing];
    self.mj_header = mjHeader;
}

- (void)refreshFooterWithBlock:(void (^)(void))block {
    __block typeof(self) blockSelf = self;
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [blockSelf removeNoDataView];
        block();
    }];
//    [footer setTitle:@"" forState:MJRefreshStateNoMoreData];
    [footer setTitle:@"" forState:MJRefreshStateIdle];
    [footer setTitle:@"松手开始刷新" forState:MJRefreshStatePulling];
    [footer setTitle:@"即将开始刷新" forState:MJRefreshStateWillRefresh];
    [footer setTitle:@"加载中···" forState:MJRefreshStateRefreshing];
    footer.automaticallyRefresh = YES;
    self.mj_footer = footer;
}

- (NSArray <UIImage *>*)imagesWithLoading {
    NSMutableArray *images = [NSMutableArray array];
//    for (NSInteger i = 1; i <= 5; i ++) {
//        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"animation_loading－%ld", i]];
//        [images addObject:image];
//    }
    return images;
}


#pragma mark - 暂无数据
- (void)addNoDataView {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (self.noDataView == nil) {
            UIView *noDataView = [[UIView alloc] initWithFrame:CGRectMake(0, self.contentSize.height, self.contentSize.width, 58)];
            noDataView.backgroundColor = [UIColor clearColor];
            
            UILabel *label = [[UILabel alloc] initWithFrame:noDataView.bounds];
            label.backgroundColor = [UIColor clearColor];
            label.textAlignment = NSTextAlignmentCenter;
            label.textColor = [UIColor colorWithRed:0.2 green:0.2 blue:0.2 alpha:1];
            label.font = [UIFont systemFontOfSize:12];
            label.text = @"暂无数据";
            [noDataView addSubview:label];
            
            UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(18, CGRectGetHeight(noDataView.frame) - 2, CGRectGetWidth(noDataView.frame) - 36, 2)];
            line.backgroundColor = [UIColor clearColor];
            line.lineBreakMode = NSLineBreakByClipping;
            line.textColor = [UIColor colorWithRed:160/225.f green:160/225.f blue:160/225.f alpha:1];
            line.text = @"---------------------------------------------------------------------------------------";
            [noDataView insertSubview:line aboveSubview:label];
            
            self.noDataView = noDataView;
        } else {
            self.noDataView.frame = CGRectMake(0, self.contentSize.height, self.contentSize.width, 58);
            UILabel *label = self.noDataView.subviews.firstObject;
            CGRect frame = label.frame;
            frame.size.width = self.contentSize.width;
            label.frame = frame;
            UILabel *line = self.noDataView.subviews.lastObject;
            CGRect lineframe = line.frame;
            lineframe.size.width = CGRectGetWidth(self.noDataView.frame) - 36;
            line.frame = lineframe;
        }
//        self.contentSize = CGSizeMake(self.contentSize.width, self.contentSize.height + 58);
        [self addSubview:self.noDataView];
    });
    if (self.mj_header.isRefreshing) {
        [self.mj_header endRefreshing];
    }
    if (self.mj_footer.isRefreshing) {
        [self.mj_footer endRefreshing];
    }
    self.mj_footer.userInteractionEnabled = NO;
}

- (void)removeNoDataView {
//    if (self.noDataView && [self.noDataView.superview isEqual:self]) {
//        self.contentSize = CGSizeMake(self.contentSize.width, self.contentSize.height - 58);
//    }
    if (self.noDataView) {
        [self.noDataView removeFromSuperview];
    }
    self.mj_footer.userInteractionEnabled = YES;
}


static const void *noDataViewKey = &noDataViewKey;

- (void)setNoDataView:(UIView *)noDataView {
    objc_setAssociatedObject(self, &noDataViewKey, noDataView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIView *)noDataView {
    return objc_getAssociatedObject(self, &noDataViewKey);
}

@end
