//
//  SelectAddressHeaderView.h
//  BaseProject
//
//  Created by 张熔冰 on 2018/8/30.
//  Copyright © 2018年 Lovcreate. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SelectAddressHeaderView : UIView

+(instancetype)viewForFrame:(CGRect)frame handler:(void(^)(NSInteger index)) handler;

+(instancetype)viewForFrame:(CGRect)frame hotCitys:(NSArray*)citys handler:(void(^)(NSInteger index)) handler;

@end
