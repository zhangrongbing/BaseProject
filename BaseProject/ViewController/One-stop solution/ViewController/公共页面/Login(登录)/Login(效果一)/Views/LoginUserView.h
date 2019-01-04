//
//  LoginUserView.h
//  BaseProject
//
//  Created by 张熔冰 on 2018/12/10.
//  Copyright © 2018年 Lovcreate. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LoginUserView : UIView

-(void)showUserIcon:(UIImage*)image nickName:(NSString*)nickName;

-(void)hide;
@end

NS_ASSUME_NONNULL_END
