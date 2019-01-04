/***************************************************************************************************
 **  Copyright © 2016年 Jinn Chang. All rights reserved.
 **  Giuhub: https://github.com/jinnchang
 **
 **  FileName: JinnLockTool.h
 **  Description: 密码管理工具
 **
 **  History
 **  -----------------------------------------------------------------------------------------------
 **  Author: jinnchang
 **  Date: 16/8/10
 **  Version: 1.0.0
 **  Remark: Create
 **************************************************************************************************/

#import <Foundation/Foundation.h>
#import <LocalAuthentication/LAContext.h>

@interface JinnLockTool : NSObject

#pragma mark - 手势密码管理

/**
 *  是否允许手势解锁(应用级别的)
 *
 *  @return 是否允许手势解锁
 */
+ (BOOL)isGestureUnlockEnabled;

/**
 *  设置是否允许手势解锁功能
 *
 *  @param enabled 设置是否允许手势解锁功能
 */
+ (void)setGestureUnlockEnabled:(BOOL)enabled;

/**
 *  当前已经设置的手势密码
 *
 *  @return 当前已经设置的手势密码
 */
+ (NSString *)currentGesturePasscode;

/**
 *  设置新的手势密码
 *
 *  @param passcode 设置新的手势密码
 */
+ (void)setGesturePasscode:(NSString *)passcode;

#pragma mark - 指纹解锁管理

/**
 *  是否支持指纹识别(系统级别的)
 *
 *  @return 是否支持指纹识别(系统级别的)
 */
+ (BOOL)isTouchIdSupported;

/**
 *  是否允许指纹解锁(应用级别的)
 *
 *  @return 是否允许指纹解锁(应用级别的)
 */
+ (BOOL)isTouchIdUnlockEnabled;

/**
 *  设置是否允许指纹解锁功能
 *
 *  @param enabled 设置是否允许指纹解锁功能
 */
+ (void)setTouchIdUnlockEnabled:(BOOL)enabled;

@end
