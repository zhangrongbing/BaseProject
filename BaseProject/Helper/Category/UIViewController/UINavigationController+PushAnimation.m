//
//  UINavigationController+PushAnimation.m
//  Paggy-Sloth
//
//  Created by 伯明利 on 2017/9/14.
//  Copyright © 2017年 Lovcreate. All rights reserved.
//

#import "UINavigationController+PushAnimation.h"

@implementation UINavigationController (PushAnimation)

- (void)lc_pushViewController:(UIViewController *)viewController animationType:(KPrensentAnimationType)animationType direction:(KPrensentAnimationDirection)direction {
    [self animationType:animationType direction:direction];
    [self pushViewController:viewController animated:NO];
}

- (UIViewController *)lc_popViewControllerAnimationType:(KPrensentAnimationType)animationType direction:(KPrensentAnimationDirection)direction {
    [self animationType:animationType direction:direction];
    return [self popViewControllerAnimated:NO];
}

- (NSArray<UIViewController *> *)lc_popToViewController:(UIViewController *)viewController animationType:(KPrensentAnimationType)animationType direction:(KPrensentAnimationDirection)direction {
    [self animationType:animationType direction:direction];
    return [self popToViewController:viewController animated:NO];
}

- (NSArray<UIViewController *> *)lc_popToRootViewControllerAnimationType:(KPrensentAnimationType)animationType direction:(KPrensentAnimationDirection)direction {
    [self animationType:animationType direction:direction];
    return [self popToRootViewControllerAnimated:NO];
}

- (void)animationType:(KPrensentAnimationType)animationType direction:(KPrensentAnimationDirection)direction {
    //创建CATransition对象
    CATransition *animation = [CATransition animation];
    
    NSString *transitionType = kCATransitionFade;
    
    //设置运动时间
    
    animation.duration = 0.4;
    
    switch (animationType) {
        case KPrensentAnimationTypeFade://淡入淡出
        {
            transitionType =kCATransitionFade;
        }
            break;
        case KPrensentAnimationTypePush://推挤
        {
            transitionType =kCATransitionPush;
        }
            break;
        case KPrensentAnimationTypeReveal://揭开
        {
            transitionType =kCATransitionReveal;
        }
            break;
        case KPrensentAnimationTypeMoveIn://覆盖
        {
            transitionType = kCATransitionMoveIn;
        }
            break;
        case KPrensentAnimationTypeCube://立方体
        {
            transitionType = @"cube";
        }
            break;
        case KPrensentAnimationTypeSuckEffect://吮吸
        {
            transitionType = @"suckEffect";
        }
            break;
        case KPrensentAnimationTypeOglFlip://翻转
        {
            transitionType = @"oglFlip";
        }
            break;
        case KPrensentAnimationTypeRippleEffect://波纹
        {
            transitionType = @"rippleEffect";
        }
            break;
        case KPrensentAnimationTypePageCurl://翻页
        {
            transitionType = @"pageCurl";
        }
            break;
        case KPrensentAnimationTypePageUnCurl://反翻页
        {
            transitionType = @"pageUnCurl";
        }
            break;
        case KPrensentAnimationTypeCameraIrisHollowOpen://开镜头
        {
            transitionType = @"cameraIrisHollowOpen";
        }
            break;
        case KPrensentAnimationTypeCameraIrisHollowClose://关镜头
        {
            transitionType = @"cameraIrisHollowClose";
        }
            break;
        case KPrensentAnimationTypeCurlDown://下翻页
        {
            transitionType = @"pageUnCurl";
        }
            break;
        case KPrensentAnimationTypeCurlUp://上翻页
        {
            transitionType = @"pageUnCurl";
        }
            break;
        case KPrensentAnimationTypeFlipFromLeft://左翻转
        {
            transitionType = @"pageUnCurl";
        }
            break;
        case KPrensentAnimationTypeFlipFromRight://右翻转
        {
            transitionType = @"pageUnCurl";
        }
            break;
        default:
            break;
    }
    
    NSString *subtype = kCATransitionFromRight;
    
    switch (direction) {
        case KPrensentAnimationDirectionBottom:
        {
            subtype = kCATransitionFromBottom;
        }
            break;
        case KPrensentAnimationDirectionLeft:
        {
            subtype = kCATransitionFromLeft;
        }
            break;
        case KPrensentAnimationDirectionRight:
        {
            subtype = kCATransitionFromRight;
        }
            break;
        case KPrensentAnimationDirectionTop:
        {
            subtype = kCATransitionFromTop;
        }
            break;
        default:
            break;
    }
    
    //设置运动type
    animation.type = transitionType;
    
    if (subtype != nil) {
        //设置子类
        animation.subtype = subtype;
        
    }
    
    //设置运动速度
    
//    animation.timingFunction = UIViewAnimationOptionCurveEaseInOut;
    
    [self.view.window.layer addAnimation:animation forKey:@"animation"];
}

@end
