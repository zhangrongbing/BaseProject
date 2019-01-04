//
//  ToastManager.h
//  BaseProject
//
//  Created by 张熔冰 on 2018/3/23.
//  Copyright © 2018年 lovcreate. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSObject+Single.h"

@interface ToastManager : NSObject

LC_SINGLE_H(ToastManager);

-(void)showMessage:(NSString*)message, ...NS_FORMAT_FUNCTION(1,2);
-(void)showMessage:(NSString*)message delay:(float)delay;
@end
