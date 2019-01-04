//
//  SegmentCodeView.h
//  BaseProject
//
//  Created by 张熔冰 on 2018/9/11.
//  Copyright © 2018年 Lovcreate. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SegmentCodeView : UIControl

@property(nonatomic, strong) NSString *value;

+(instancetype)viewForFrame:(CGRect)frame;

-(void)becomeFirstTextFieldResponder;
@end
