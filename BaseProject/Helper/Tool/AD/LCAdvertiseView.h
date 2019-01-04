//
//  LCAdvertiseView.h
//  BaseProject
//
//  Created by Swift liu on 2018/11/1.
//  Copyright © 2018 Lovcreate. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

UIKIT_EXTERN NSString *const NotificationContants_Advertise_Key;

@interface LCAdvertiseView : UIView

/** 显示广告页面方法*/
- (void)show;

/** 图片路径*/
@property (nonatomic, copy) NSString *filePath;

@end

NS_ASSUME_NONNULL_END
