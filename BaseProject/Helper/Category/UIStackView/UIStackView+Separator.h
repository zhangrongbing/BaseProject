//
//  UIStackView+Separator.h
//  BaseProject
//
//  Created by 张熔冰 on 2018/12/13.
//  Copyright © 2018年 Lovcreate. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIStackView (Separator)

@property (copy, nonatomic) UIColor *separatorColor;
@property (assign, nonatomic) CGFloat separatorLength;
@property (assign, nonatomic) CGFloat separatorThickness;

@end

@interface UIStackViewSeparatorHelper : NSObject

@property (copy, nonatomic) UIColor *separatorColor;
@property (assign, nonatomic) CGFloat separatorLength;
@property (assign, nonatomic) CGFloat separatorThickness;

@property (weak, nonatomic) UIStackView *stackView;
@property (strong, nonatomic) NSMutableArray<UIView *> *separatorViews;

- (void)makeSeparators;

@end

NS_ASSUME_NONNULL_END
