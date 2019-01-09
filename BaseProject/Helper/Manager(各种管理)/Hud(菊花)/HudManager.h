//
//  HudManager.h
//  BaseProject
//
//  Created by 张熔冰 on 2018/4/13.
//  Copyright © 2018年 lovcreate. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSObject+Single.h"
#import "MBProgressHUD.h"

@interface HudManager : NSObject

SINGLE_H(HudManager);

-(void)showHud:(BOOL)animated;
-(void)hide:(BOOL)animated;
@end
