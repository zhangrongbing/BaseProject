//
//  UIViewController+PrensentAnimation.h
//  Paggy-Sloth
//
//  Created by 伯明利 on 2017/9/14.
//  Copyright © 2017年 Lovcreate. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    /**
      *  淡入淡出
      */
    KPrensentAnimationTypeFade = 1,
    /**
      *  推挤
      */
    KPrensentAnimationTypePush,
    /**
      *  揭开
      */
    KPrensentAnimationTypeReveal,
    /**
      *  覆盖
      */
    KPrensentAnimationTypeMoveIn,
    /**
      *  立方体
      */
    KPrensentAnimationTypeCube,
    /**
      *  吮吸
      */
    KPrensentAnimationTypeSuckEffect,
    /**
      *  翻转
      */
    KPrensentAnimationTypeOglFlip,
    /**
      *  波纹
      */
    KPrensentAnimationTypeRippleEffect,
    /**
      *  翻页
      */
    KPrensentAnimationTypePageCurl,
    /**
      *  反翻页
      */
    KPrensentAnimationTypePageUnCurl,
    /**
      *  开镜头
      */
    KPrensentAnimationTypeCameraIrisHollowOpen,
    /**
      *  关镜头
      */
    KPrensentAnimationTypeCameraIrisHollowClose,
    /**
      *  下翻页
      */
    KPrensentAnimationTypeCurlDown,
    /**
      *  上翻页
      */
    KPrensentAnimationTypeCurlUp,
    /**
      *  左翻转
     */
    KPrensentAnimationTypeFlipFromLeft,
    /**
     *  右翻转
     */
    KPrensentAnimationTypeFlipFromRight,
} KPrensentAnimationType;

typedef enum : NSUInteger {
    KPrensentAnimationDirectionBottom = 0,
    KPrensentAnimationDirectionLeft,
    KPrensentAnimationDirectionRight,
    KPrensentAnimationDirectionTop
} KPrensentAnimationDirection;

@interface UIViewController (PrensentAnimation)

- (void)_presentViewController:(UIViewController *_Nullable)viewControllerToPresent animationType:(KPrensentAnimationType)animationType direction:(KPrensentAnimationDirection)direction completion:(void (^ __nullable)(void))completion;

- (void)_dismissViewControllerAnimationType:(KPrensentAnimationType)animationType direction:(KPrensentAnimationDirection)direction completion: (void (^ __nullable)(void))completion;

@end
