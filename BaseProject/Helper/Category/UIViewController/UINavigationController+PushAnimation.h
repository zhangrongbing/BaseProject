//
//  UINavigationController+PushAnimation.h
//  Paggy-Sloth
//
//  Created by 伯明利 on 2017/9/14.
//  Copyright © 2017年 Lovcreate. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIViewController+PrensentAnimation.h"

@interface UINavigationController (PushAnimation)

- (void)_pushViewController:(UIViewController *_Nonnull)viewController animationType:(KPrensentAnimationType)animationType direction:(KPrensentAnimationDirection)direction;

- (nullable UIViewController *)_popViewControllerAnimationType:(KPrensentAnimationType)animationType direction:(KPrensentAnimationDirection)direction; // Returns the popped controller.

- (nullable NSArray<__kindof UIViewController *> *)_popToViewController:(UIViewController *_Nonnull)viewController animationType:(KPrensentAnimationType)animationType direction:(KPrensentAnimationDirection)direction; // Pops view controllers until the one specified is on top. Returns the popped controllers.

- (nullable NSArray<__kindof UIViewController *> *)_popToRootViewControllerAnimationType:(KPrensentAnimationType)animationType direction:(KPrensentAnimationDirection)direction;

@end
