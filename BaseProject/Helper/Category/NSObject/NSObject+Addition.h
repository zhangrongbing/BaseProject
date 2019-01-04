//
//  NSObject+Addition.h
//  BaseProject
//
//  Created by zhangrongbing on 2016/11/8.
//  Copyright © 2016年 lovcreate. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "MyConfig.h"
#import "NSDate+Addition.h"

@interface NSObject (Addition)

+ (void)exchangeInstanceMethod1:(SEL)method1 method2:(SEL)method2;
+ (void)exchangeClassMethod1:(SEL)method1 method2:(SEL)method2;

@end
