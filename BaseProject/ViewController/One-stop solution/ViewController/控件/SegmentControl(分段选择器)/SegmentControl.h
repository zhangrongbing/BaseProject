//
//  SliderTabMenu.h
//  BaseProject
//
//  Created by 张熔冰 on 2018/8/6.
//  Copyright © 2018年 Lovcreate. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SegmentControl;

typedef NS_ENUM(NSInteger, SegmentControlSliderWidthStyle){
    SegmentControlSliderWidthStyleTextWidth = 0,//滑块的宽度等于内容的宽度
    SegmentControlSliderWidthStyleFullTextWidth//滑块的宽度等于控件的宽度
};

typedef NS_ENUM(NSInteger, SegmentControlStyle){
    SegmentControlStylePlain = 0,//选项卡宽度等于内容大小的宽度
    SegmentControlStyleEqual//选项卡的宽度平分父控件的宽度
};//分段控制器的菜单样式

@protocol SegmentControlDataSource<NSObject>

@required
-(NSInteger)numberOfTitleInSegmentControl;
-(NSString*)segmentControl:(SegmentControl*)view titleForIndex:(NSInteger)index;

@end

@protocol SegmentControlDelegate<NSObject>

@optional
-(void)segmentControl:(SegmentControl*)view didSelectedForIndex:(NSInteger)index;

@end

@interface SegmentControl : UIScrollView

@property(nonatomic, strong) UIColor* sliderColor;
@property(nonatomic, strong) UIColor* textColor;
@property(nonatomic, assign) BOOL textAnimated;
@property(nonatomic, strong) UIColor* selectedTextColor;
@property(nonatomic, strong) UIColor* slidewayColor;
@property(nonatomic, assign) SegmentControlStyle style;//选项卡的宽度
@property(nonatomic, assign) NSInteger curIndex;//当前选中的选项卡角标
@property(nonatomic, weak) id<SegmentControlDelegate> menuDelegate;
@property(nonatomic, weak) id<SegmentControlDataSource> menuDataSource;
@property(nonatomic, assign) SegmentControlSliderWidthStyle sliderWidthStyle;//滑块的宽度
-(instancetype)initWithStyle:(SegmentControlStyle)style defaultIndex:(NSInteger) index;

-(void)moveToIndex:(NSInteger)index;
@end
