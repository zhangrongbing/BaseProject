//
//  DropUpView.h
//  hydra
//
//  Created by 张熔冰 on 2018/2/26.
//  Copyright © 2018年 lovcreate. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BottomExpansionView : UIView

-(instancetype)initWithDefaultTitle:(NSString*)defaultTitle title:(NSString*)title data:(NSArray*)data selectedBlock:(void(^)(NSInteger index))block;

@end
