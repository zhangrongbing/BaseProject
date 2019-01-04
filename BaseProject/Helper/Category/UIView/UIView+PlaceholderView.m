//
//  UIScrollView+PlaceholderView.m
//  UIScrollViewPlaceholderView
//
//  Created by 张熔冰 on 2018/4/16.
//  Copyright © 2017年 lovcreate. All rights reserved.
//

#import "UIView+PlaceholderView.h"
#import <Masonry.h>
#import <objc/runtime.h>

@interface UIView ()

/** 用来记录UIScrollView最初的scrollEnabled */
@property (nonatomic, assign) BOOL lc_originalScrollEnabled;
/** 点击事件回调块 */
@property (nonatomic, strong) void(^lc_reloadBlock)(void);

@end

@implementation UIView (PlaceholderView)

static void *placeholderViewKey = &placeholderViewKey;
static void *originalScrollEnabledKey = &originalScrollEnabledKey;
static void *reloadBlockKey = &reloadBlockKey;

- (UIView *)lc_placeholderView {
    return objc_getAssociatedObject(self, &placeholderViewKey);
}

- (void)setLc_placeholderView:(UIView *)lc_placeholderView {
    objc_setAssociatedObject(self, &placeholderViewKey, lc_placeholderView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)cq_originalScrollEnabled {
    return [objc_getAssociatedObject(self, &originalScrollEnabledKey) boolValue];
}

- (void)setLc_originalScrollEnabled:(BOOL)lc_originalScrollEnabled {
    objc_setAssociatedObject(self, &originalScrollEnabledKey, @(lc_originalScrollEnabled), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(void(^)(void))lc_reloadBlock{
    return objc_getAssociatedObject(self, &reloadBlockKey);
}

-(void)setLc_reloadBlock:(void (^)(void))lc_reloadBlock{
    objc_setAssociatedObject(self, &reloadBlockKey, lc_reloadBlock, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


#pragma mark - 展示UIView或其子类的占位图
/**
 展示UIView或其子类的占位图
 
 @param type 占位图类型
 @param reloadBlock 重新加载回调的block
 */
- (void)lc_showPlaceholderViewWithType:(LCPlaceholderViewType)type reloadBlock:(void (^)(void))reloadBlock {
    // 如果是UIScrollView及其子类，占位图展示期间禁止scroll
    if ([self isKindOfClass:[UIScrollView class]]) {
        UIScrollView *scrollView = (UIScrollView *)self;
        // 先记录原本的scrollEnabled
        self.lc_originalScrollEnabled = scrollView.scrollEnabled;
        // 再将scrollEnabled设为NO
        scrollView.scrollEnabled = NO;
    }
    
    //------- 占位图 -------//
    if (self.lc_placeholderView) {
        [self.lc_placeholderView removeFromSuperview];
        self.lc_placeholderView = nil;
    }
    self.lc_placeholderView = [[UIView alloc] init];
    [self addSubview:self.lc_placeholderView];
    self.lc_placeholderView.backgroundColor = [UIColor whiteColor];
    [self.lc_placeholderView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self);
        make.size.mas_equalTo(self);
    }];
    
    //------- 图标 -------//
    UIImageView *imageView = [[UIImageView alloc] init];
    [self.lc_placeholderView addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(imageView.superview);
        make.centerY.mas_equalTo(imageView.superview).mas_offset(-80);
        make.size.mas_equalTo(CGSizeMake(70, 70));
    }];
    
    //------- 描述 -------//
    UILabel *descLabel = [[UILabel alloc] init];
    [self.lc_placeholderView addSubview:descLabel];
    [descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(descLabel.superview);
        make.top.mas_equalTo(imageView.mas_bottom).mas_offset(20);
        make.height.mas_equalTo(15);
    }];
    
    //------- 重新加载button -------//
    UIButton *reloadButton = [[UIButton alloc] init];
    [self.lc_placeholderView addSubview:reloadButton];
    [reloadButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [reloadButton setTitle:@"重新加载" forState:UIControlStateNormal];
    reloadButton.layer.borderWidth = 1;
    reloadButton.layer.borderColor = [UIColor blackColor].CGColor;
    [reloadButton addTarget:self action:@selector(lc_pressReloadButton:) forControlEvents:UIControlEventTouchUpInside];
    self.lc_reloadBlock = reloadBlock;
    [reloadButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(reloadButton.superview);
        make.top.mas_equalTo(descLabel.mas_bottom).mas_offset(20);
        make.size.mas_equalTo(CGSizeMake(120, 30));
    }];
    
    //------- 根据type设置不同UI -------//
    switch (type) {
        case LCPlaceholderViewTypeNoNetwork: // 网络不好
        {
            imageView.image = [UIImage imageNamed:@"no_net"];
            descLabel.text = @"无网络可用";
        }
            break;
            
        case LCPlaceholderViewTypeNoData: // 无数据
        {
            imageView.image = [UIImage imageNamed:@"no_data"];
            descLabel.text = @"暂无内容";
        }
            break;
        default:
            break;
    }
}

#pragma mark - Action
-(void)lc_pressReloadButton:(UIButton*)button{
    if (self.lc_reloadBlock) {
        self.lc_reloadBlock();
    }
    // 从父视图移除
    [self.lc_placeholderView removeFromSuperview];
    self.lc_placeholderView = nil;
    // 复原UIScrollView的scrollEnabled
    if ([self isKindOfClass:[UIScrollView class]]) {
        UIScrollView *scrollView = (UIScrollView *)self;
        scrollView.scrollEnabled = self.cq_originalScrollEnabled;
    }
}

#pragma mark - Public
/**
 主动移除占位图
 占位图会在你点击“重新加载”按钮的时候自动移除，你也可以调用此方法主动移除
 */
- (void)lc_removePlaceholderView {
    if (self.lc_placeholderView) {
        [self.lc_placeholderView removeFromSuperview];
        self.lc_placeholderView = nil;
    }
    // 复原UIScrollView的scrollEnabled
    if ([self isKindOfClass:[UIScrollView class]]) {
        UIScrollView *scrollView = (UIScrollView *)self;
        scrollView.scrollEnabled = self.lc_originalScrollEnabled;
    }
}

@end
