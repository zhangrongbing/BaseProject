//
//  NSObject+Addition.m
//  BaseProject
//
//  Created by zhangrongbing on 2016/11/8.
//  Copyright © 2016年 lovcreate. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "NSObject+Addition.h"
#import <objc/runtime.h>
#import "MyConfig.h"

@implementation NSObject (Addition)

+ (void)exchangeInstanceMethod1:(SEL)method1 method2:(SEL)method2{
    method_exchangeImplementations(class_getInstanceMethod(self, method1), class_getInstanceMethod(self, method2));
}

+ (void)exchangeClassMethod1:(SEL)method1 method2:(SEL)method2{
    method_exchangeImplementations(class_getClassMethod(self, method1), class_getClassMethod(self, method2));
}
@end
