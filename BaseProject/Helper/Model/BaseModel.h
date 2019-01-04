//
//  BaseModel.h
//  BaseProject
//
//  Created by zhangrongbing on 16/9/26.
//  Copyright © 2016年 lovcreate. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseModel : NSObject

@property(nonatomic, assign) NSInteger state;
@property(nonatomic, strong) NSString* message;
@property(nonatomic, strong) NSString* returnStatus;
@property(nonatomic, strong) id mapData;

-(id)returnData;

@end
