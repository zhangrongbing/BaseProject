//
//  NSDate+Addition.m
//  BaseProject
//
//  Created by 张熔冰 on 2017/11/22.
//  Copyright © 2017年 lovcreate. All rights reserved.
//

#import "NSDate+Addition.h"

@implementation NSDate (Addition)

-(NSString*)description{
    NSDateFormatter* format = [[NSDateFormatter alloc] init];
    format.dateFormat = @"YYYY-MM-dd HH:mm:ssss";
    return [format stringFromDate:[NSDate date]];
}
@end
