//
//  DialogController.h
//  BaseProject
//
//  Created by 张熔冰 on 2018/12/12.
//  Copyright © 2018年 Lovcreate. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DialogAction;

NS_ASSUME_NONNULL_BEGIN

@interface DialogController : UIViewController

@property(nonatomic, assign)BOOL dismissForUserInterraction;//默认YES，即用户可以点击周围灰暗区域可以取消掉弹窗
@property(nonatomic, strong, readonly) NSMutableArray<UITextField*> *textFields;

+(instancetype)dialogControllerWithTitle:(NSString*)title message:(nullable NSString*)message;

-(void)addAction:(DialogAction*)action;

- (void)addTextFieldWithConfigurationHandler:(void (^ __nullable)(UITextField *textField))configurationHandler;
@end

@interface DialogAction : NSObject

@property(nonatomic, strong, readonly) NSString *title;
@property(nonatomic, strong, readonly) void(^handler)(DialogAction* action);
+(instancetype)actionWithTitle:(NSString*)title handler:(void(^ __nullable)(DialogAction* action))handler;

@end

@interface DialogPresentationController : UIPresentationController<UIGestureRecognizerDelegate>

@property(nonatomic, assign) BOOL presnetAnimated;
@property(nonatomic, assign) BOOL dismissForUserInterraction;

@end

@interface DialogAnimatedPresentation : NSObject <UIViewControllerAnimatedTransitioning>
@end

@interface DialogAnimatedDismiss : NSObject <UIViewControllerAnimatedTransitioning>
@end
NS_ASSUME_NONNULL_END
