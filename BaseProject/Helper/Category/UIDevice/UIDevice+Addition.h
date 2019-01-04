//
//  UIDevice+Addition.h
//  BaseProject
//
//  Created by 张熔冰 on 2019/1/4.
//  Copyright © 2019年 Lovcreate. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIDevice (Addition)

/**
 当前设备型号
 
 @return 哪个iPhone型号
 */
+(NSString*)currentModel;


/**
 判断当前设备是不是异形屏
 
 @return 异形屏是与否
 */
+(BOOL)isSpecialScreen;

@end

NS_ASSUME_NONNULL_END
