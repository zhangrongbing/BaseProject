//
//  IPManager.h
//  BaseProject
//
//  Created by 张熔冰 on 2018/8/27.
//  Copyright © 2018年 Lovcreate. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSObject+Single.h"
#import "route.h"

@interface IPManager : NSObject

LC_SINGLE_H(IPManager);

- (NSString *)localIP;//本地ip

- (NSString *)getGatewayIPAddress;//网关
@end
