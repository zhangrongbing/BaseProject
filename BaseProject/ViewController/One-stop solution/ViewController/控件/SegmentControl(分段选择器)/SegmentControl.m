//
//  SegmentControl.m
//  BaseProject
//
//  Created by 张熔冰 on 2018/8/6.
//  Copyright © 2018年 Lovcreate. All rights reserved.
//

#import "SegmentControl.h"

#define kSpacing 30.f//间隔

@interface SegmentControl()

@property(nonatomic, strong) NSMutableArray<UIButton*>* buttons;
@property(nonatomic, strong) UIButton* curButton;
@property(nonatomic, strong) UIView *sliderView;
@property(nonatomic, strong) UIView *slidewayView;

@end

@implementation SegmentControl

-(instancetype)initWithStyle:(SegmentControlStyle)style defaultIndex:(NSInteger) index{
    if (self = [super init]) {
        self.style = style;
        self.curIndex = index;
        self.sliderWidthStyle = SegmentControlSliderWidthStyleTextWidth;
        self.selectedTextColor = [UIColor redColor];
        self.textColor = [UIColor blackColor];
        self.sliderColor = [UIColor blackColor];
        self.showsVerticalScrollIndicator = NO;
        self.showsHorizontalScrollIndicator = NO;
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

#pragma mark - OverWrite

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
    self.slidewayView.frame = CGRectMake(0, size.height - 1, self.contentSize.width, 1);
    if (self.sliderWidthStyle == SegmentControlSliderWidthStyleTextWidth) {
        UIButton *curBtn = [self.buttons objectAtIndex:self.curIndex];
        CGRect newFrame = [curBtn.titleLabel convertRect:curBtn.titleLabel.bounds toView:curBtn.superview];
        self.sliderView.frame = CGRectMake(CGRectGetMinX(newFrame), 0, CGRectGetWidth(newFrame), 1);
    }else if(self.sliderWidthStyle == SegmentControlSliderWidthStyleFullTextWidth){
        self.sliderView.frame = CGRectMake(CGRectGetMinX(self.curButton.frame), 0, CGRectGetWidth(self.curButton.frame), 1);
    }
}
#pragma mark - Getter and Setter

-(void)setStyle:(SegmentControlStyle)style{
    _style = style;
    if (style == SegmentControlStyleEqual) {
        self.scrollEnabled = NO;
    }else if(style == SegmentControlStylePlain){
        self.scrollEnabled = YES;
        self.slidewayView.backgroundColor = [UIColor clearColor];
    }
}

-(void)setMenuDelegate:(id<SegmentControlDelegate>)menuDelegate{
    _menuDelegate = menuDelegate;
    
    //加入轨道
    self.slidewayView = [[UIView alloc] init];
    self.slidewayView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self addSubview:self.slidewayView];
    //加入滑块
    self.sliderView = [[UIView alloc] init];
    self.sliderView.backgroundColor = self.sliderColor;
    [self.slidewayView addSubview:self.sliderView];
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
        [btn setTitleColor:self.textColor forState:UIControlStateNormal];
        [btn setTitleColor:self.selectedTextColor forState:UIControlStateSelected];
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

-(void)moveToIndex:(NSInteger)index{
    UIButton *button = [self.buttons objectAtIndex:index];
    if (button == self.curButton) {
        return;
    }
    [self.curButton setSelected:NO];
    [button setSelected:YES];
    self.curButton = button;
    self.curIndex = index;
    //设置标题居中
    CGFloat offsetX = CGRectGetMidX(button.frame) - CGRectGetWidth(self.frame)/2.f;
    if (offsetX < 0) {
        offsetX = 0;
    }
    //最大偏移量
    CGFloat maxOffset = self.contentSize.width - CGRectGetWidth(self.frame);
    if (offsetX > maxOffset) {
        offsetX = maxOffset;
    }
    [self setContentOffset:CGPointMake(offsetX, 0) animated:YES];
    
    self.userInteractionEnabled = NO;
    //控制滑块
    [UIView animateWithDuration:.3 animations:^{
        if (self.sliderWidthStyle == SegmentControlSliderWidthStyleTextWidth) {
            CGRect titleLabelFrame = [button.titleLabel convertRect:button.titleLabel.bounds toView:self];
            CGFloat sliderViewX = CGRectGetMinX(titleLabelFrame);
            CGRect newFrame = CGRectMake(sliderViewX, 0, CGRectGetWidth(titleLabelFrame), 1);
            self.sliderView.frame = newFrame;
        }else if(self.sliderWidthStyle == SegmentControlSliderWidthStyleFullTextWidth){
            CGRect newFrame = self.sliderView.frame;
            newFrame.origin.x = CGRectGetMinX(button.frame);
            newFrame.size.width = CGRectGetWidth(button.frame);
            self.sliderView.frame = newFrame;
        }
    } completion:^(BOOL finished) {
        self.userInteractionEnabled = YES;
    }];
}
@end
