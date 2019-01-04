//
//  SliderTabMenu.h
//  BaseProject
//
//  Created by 张熔冰 on 2018/8/6.
//  Copyright © 2018年 Lovcreate. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MenuItem.h"

@class SegmentControl;

typedef NS_ENUM(NSInteger, SegmentControlSliderWidthStyle){
    SegmentControlSliderWidthStyleTextWidth = 0,//滑块的宽度等于内容的宽度
    SegmentControlSliderWidthStyleFullTextWidth//滑块的宽度等于控件的宽度
};

typedef NS_ENUM(NSInteger, SegmentControlStyle){
    SegmentControlStylePlain = 0,//内容大小的宽度
    SegmentControlStyleEqual//平分宽度
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
@property(nonatomic, strong) UIColor* selectedTextColor;
@property(nonatomic, strong) UIColor* slidewayColor;
@property(nonatomic, assign) IBInspectable NSInteger style;//0是平滑 1是均分
@property(nonatomic, assign) NSInteger curIndex;
@property(nonatomic, weak) id<SegmentControlDelegate> menuDelegate;
@property(nonatomic, weak) id<SegmentControlDataSource> menuDataSource;
@property(nonatomic, assign) SegmentControlSliderWidthStyle sliderWidthStyle;

-(instancetype)initWithFrame:(CGRect)frame menuStyle:(SegmentControlStyle)style defaultIndex:(NSInteger) index;

-(void)moveToIndex:(NSInteger)index;
@end
