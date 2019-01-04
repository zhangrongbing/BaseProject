//
//  SelectedPictureController.h
//  BaseProject
//
//  Created by 张熔冰 on 2018/8/15.
//  Copyright © 2018年 Lovcreate. All rights reserved.
//

#import "BaseAlertController.h"

@class SheetAction;

@interface SheetController : BaseAlertController

+(instancetype)controllerWithCancelTitle:(NSString *)cancelTitle;
-(void) addAction:(SheetAction *)action;
@end

@interface SheetAction : NSObject

@property(nonatomic, strong) NSString *title;
@property(nonatomic, strong) UIImage *image;
@property(nonatomic, strong) void(^handler)(SheetAction *action);
+(instancetype)actionWithTitle:(NSString*)title image:(nullable UIImage *) image handler:(void(^)(SheetAction *action)) handler;

@end

@interface SheetPresnetation : BasePresentation

@property(nonatomic, assign) NSInteger itemCount;

@end
