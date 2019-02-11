//
//  BaseModel.h
//  BaseProject
//
//  Created by zhangrongbing on 16/9/26.
//  Copyright © 2016年 lovcreate. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseModel : NSObject

@property(nonatomic, assign) NSInteger code;
@property(nonatomic, strong) NSString* msg;
@property(nonatomic, strong) id data;

@end
