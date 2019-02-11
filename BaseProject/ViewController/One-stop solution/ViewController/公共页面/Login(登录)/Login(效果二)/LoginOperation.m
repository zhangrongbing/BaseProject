//
//  LoginOperation.m
//  BaseProject
//
//  Created by 张熔冰 on 2019/1/23.
//  Copyright © 2019年 Lovcreate. All rights reserved.
//

#import "LoginOperation.h"

@implementation LoginOperation

-(instancetype)initWithTarget:(id)target params:(id)params{
    if (self = [super initWithTarget:target params:params]) {
        self.action = @"http://192.168.0.106:8080/login/forgetName";
    }
    return self;
}

-(void)operation:(BaseOperation*)operation baseModel:(BaseModel*)baseModel{
    [super operation:operation baseModel:baseModel];
}
@end
