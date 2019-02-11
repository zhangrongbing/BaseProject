//
//  ShortcutManager.h
//  BaseProject
//
//  Created by 张熔冰 on 2019/1/10.
//  Copyright © 2019年 Lovcreate. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppDelegate.h"
#import "NSObject+Single.h"

NS_ASSUME_NONNULL_BEGIN
@class ShortcutManager;

@protocol ShortcutManagerDelegate <NSObject>

@optional
-(BOOL)manager:(ShortcutManager*) manager didSelectedShortCutItem:(UIApplicationShortcutItem*)item;

@end


@interface ShortcutManager : NSObject

SINGLE_H(ShortcutManager);
@property(nonatomic, strong) id<ShortcutManagerDelegate> delegate;
-(BOOL) selectShortCutItem:(UIApplicationShortcutItem*)item;

@end

NS_ASSUME_NONNULL_END
