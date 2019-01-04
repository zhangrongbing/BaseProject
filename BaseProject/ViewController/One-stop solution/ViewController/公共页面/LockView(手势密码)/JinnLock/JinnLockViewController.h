/***************************************************************************************************
 **  Copyright © 2016年 Jinn Chang. All rights reserved.
 **  Giuhub: https://github.com/jinnchang
 **
 **  FileName: JinnLockViewController.h
 **  Description: 解锁密码控制器
 **
 **  History
 **  -----------------------------------------------------------------------------------------------
 **  Author: jinnchang
 **  Date: 16/4/28
 **  Version: 1.0.0
 **  Remark: Create
 **************************************************************************************************/

#import "JinnLockTool.h"
#import "JinnLockSudoko.h"
#import "JinnLockIndicator.h"

/**
 *  控制器类型
 */
typedef NS_ENUM(NSInteger, JinnLockType)
{
    JinnLockTypeCreate, ///< 创建密码控制器
    JinnLockTypeModify, ///< 修改密码控制器
    JinnLockTypeVerify, ///< 验证密码控制器
    JinnLockTypeRemove  ///< 移除密码控制器
};

typedef NS_ENUM(NSInteger, JinnLockAppearMode)
{
    JinnLockAppearModePush,
    JinnLockAppearModePresent
};


@class JinnLockViewController;

@protocol JinnLockViewControllerDelegate <NSObject>

@optional

/**
 *  密码创建成功
 *
 *  @param passcode 密码
 */
- (void)passcodeDidCreate:(NSString *)passcode;

/**
 *  密码修改成功
 *
 *  @param passcode 密码
 */
- (void)passcodeDidModify:(NSString *)passcode;

/**
 *  密码验证成功
 *
 *  @param passcode 密码
 */
- (void)passcodeDidVerify:(NSString *)passcode;

/**
 *  密码移除成功
 */
- (void)passcodeDidRemove;

@end

@interface JinnLockViewController : UIViewController

- (instancetype)initWithDelegate:(id<JinnLockViewControllerDelegate>)delegate type:(JinnLockType)type appearMode:(JinnLockAppearMode)appearMode;

@end
