//
//  UIScrollView+PlaceholderView.h
//  UIScrollViewPlaceholderView
//
//  Created by 张熔冰 on 2018/4/16.
//  Copyright © 2017年 lovcreate. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, LCPlaceholderViewType) {
//    没网
    LCPlaceholderViewTypeNoNetwork = 0,
//    无数据
    LCPlaceholderViewTypeNoData,
};

@interface UIView (PlaceholderView)

/** 占位图 */
@property (nonatomic, strong, readonly) UIView *lc_placeholderView;

#pragma mark - 展示占位图
/**
 展示UIView及其子类的占位图，大小和view一样（本质是在这个view上添加一个自定义view）

 @param type 占位图类型
 @param reloadBlock 重新加载回调的block
 */
- (void)lc_showPlaceholderViewWithType:(LCPlaceholderViewType)type reloadBlock:(void(^)(void))reloadBlock;

#pragma mark - 主动移除占位图
/**
 主动移除占位图
 占位图会在你点击“重新加载”按钮的时候自动移除，你也可以调用此方法主动移除
 */
- (void)lc_removePlaceholderView;

@end
