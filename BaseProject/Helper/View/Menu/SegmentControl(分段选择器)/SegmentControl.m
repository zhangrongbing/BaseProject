//
//  SegmentControl.m
//  BaseProject
//
//  Created by 张熔冰 on 2018/8/6.
//  Copyright © 2018年 Lovcreate. All rights reserved.
//

#import "SegmentControl.h"
#import "Masonry.h"
#import "UIView+Addition.h"

#define kSpacing 30.f//间隔

@interface SegmentControl()

@property(nonatomic, strong) NSMutableArray<UIButton*>* buttons;
@property(nonatomic, strong) UIButton* curButton;
@property(nonatomic, strong) UIView *sliderView;
@property(nonatomic, strong) UIView *slidewayView;

@end

@implementation SegmentControl


-(instancetype)initWithFrame:(CGRect)frame menuStyle:(SegmentControlStyle)style defaultIndex:(NSInteger) index{
    if (self = [self initWithFrame:frame]) {
        self.style = style;
        self.curIndex = index;
        self.sliderWidthStyle = SegmentControlSliderWidthStyleTextWidth;
    }
    return self;
}

#pragma mark - OverWrite

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]) {
        [self setupUI];
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame: frame]) {
        [self setupUI];
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    CGSize size = self.frame.size;
    if (self.style == SegmentControlStyleEqual) {
        CGFloat width = size.width / self.buttons.count;
        [self.buttons enumerateObjectsUsingBlock:^(UIButton * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (idx == self.curIndex) {
                [obj setSelected:YES];
                self.curButton = obj;
            }
            obj.frame = CGRectMake(idx * width, 0, width, size.height - 1);
        }];
    }else if(self.style == SegmentControlStylePlain){
        __block CGFloat contentWidth = 0;
        [self.buttons enumerateObjectsUsingBlock:^(UIButton * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (idx == self.curIndex) {
                [obj setSelected:YES];
                self.curButton = obj;
            }
            [obj sizeToFit];
            CGFloat width = CGRectGetWidth(obj.frame) + 15*2;
            obj.frame = CGRectMake(contentWidth, 0, width, size.height - 1);
            contentWidth += width;
        }];
        self.contentSize = CGSizeMake(contentWidth, size.height);
    }
    self.slidewayView.frame = CGRectMake(0, size.height - 1, size.width, 1);
    self.sliderView.frame = CGRectMake(CGRectGetMinX(self.curButton.frame), 0, CGRectGetWidth(self.curButton.frame), 1);
}

#pragma mark - Getter and Setter

-(void)setStyle:(NSInteger)style{
    _style = style;
    if (style == SegmentControlStyleEqual) {
        self.scrollEnabled = NO;
    }else if(style == SegmentControlStylePlain){
        self.scrollEnabled = YES;
        self.slidewayView.backgroundColor = [UIColor clearColor];
    }
}

-(void)setMenuDataSource:(id<SegmentControlDataSource>)menuDataSource{
    _menuDataSource = menuDataSource;
    
    self.buttons = [[NSMutableArray alloc] init];
    //加入视图
    NSInteger titleCount = [self.menuDataSource numberOfTitleInSegmentControl];
    for (int i = 0; i < titleCount; i++) {
        NSString *title = [self.menuDataSource segmentControl:self titleForIndex:i];
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:title forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
        [btn addTarget:self action:@selector(pressButton:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
        [self.buttons addObject:btn];
    }
}
#pragma mark - Action
-(void)pressButton:(UIButton*)button{
    if (self.curButton == button) {
        return;
    }
    self.curIndex = [self.buttons indexOfObject:button];
    [self moveToIndex:self.curIndex];
    if (self.menuDelegate && [self.menuDelegate respondsToSelector:@selector(segmentControl:didSelectedForIndex:)]) {
        [self.menuDelegate segmentControl:self didSelectedForIndex:self.curIndex];
    }
}

#pragma mark - Public

-(void)setupUI{
    self.showsVerticalScrollIndicator = NO;
    self.showsHorizontalScrollIndicator = NO;
    self.style = SegmentControlStyleEqual;
    self.sliderWidthStyle = SegmentControlSliderWidthStyleTextWidth;
    self.backgroundColor = [UIColor whiteColor];
    
    //加入轨道
    self.slidewayView = [[UIView alloc] init];
    self.slidewayView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self addSubview:self.slidewayView];
    //加入滑块
    self.sliderView = [[UIView alloc] init];
    self.sliderView.backgroundColor = [UIColor blackColor];
    [self.slidewayView addSubview:self.sliderView];
}

-(void)moveToIndex:(NSInteger)index{
    UIButton *button = [self.buttons objectAtIndex:index];
    if (button == self.curButton) {
        return;
    }
    [self.curButton setSelected:NO];
    [button setSelected:YES];
    self.curButton = button;
    self.curIndex = index;
    //是否滑出可见区域
    CGFloat rightX = self.contentOffset.x + CGRectGetWidth(self.frame);//屏幕右侧的坐标点
    CGFloat leftX = self.contentOffset.x;//屏幕左侧的坐标点
    if (CGRectGetMaxX(self.curButton.frame) > rightX) {
        CGFloat offsetX = CGRectGetMaxX(self.curButton.frame) - rightX;
        CGPoint offset = self.contentOffset;
        [self setContentOffset:CGPointMake(offset.x + offsetX, offset.y) animated:YES];
    }else if(CGRectGetMinX(self.curButton.frame) < leftX){
        CGFloat offsetX = leftX - CGRectGetMinX(self.curButton.frame);
        CGPoint offset = self.contentOffset;
        [self setContentOffset:CGPointMake(offset.x - offsetX, offset.y) animated:YES];
    }
    self.userInteractionEnabled = NO;
    //控制滑块
    [UIView animateWithDuration:.3 animations:^{
        self.sliderView.lc_x = CGRectGetMinX(self.curButton.frame);
        self.sliderView.lc_w = CGRectGetWidth(self.curButton.frame);
    } completion:^(BOOL finished) {
        self.userInteractionEnabled = YES;
    }];
}
@end
