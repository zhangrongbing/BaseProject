//
//  NSNull+Addition.m
//  SmartWxdewDemo
//
//  Created by 张熔冰 on 2018/9/20.
//  Copyright © 2018年 伯明利. All rights reserved.
//

#import "NSNull+Addition.h"

@implementation NSNull (Addition)

- (NSUInteger)length {
    DebugLog(@"调用了null值的长度");
    return 0;
}

- (NSInteger)integerValue {
    DebugLog(@"强转null值为整型");
    return 0;
};

- (float)floatValue {
    DebugLog(@"强转null值为浮点型");
    return 0;
};

- (NSString *)description {
    DebugLog(@"打印null值");
    return @"0(NSNull)";
}

- (NSArray *)componentsSeparatedByString:(NSString *)separator {
    DebugLog(@"把null值转为数组");
    return @[];
}

- (id)objectForKey:(id)key {
    DebugLog(@"把null当作了字典类型");
    return nil;
}

- (BOOL)boolValue {
    DebugLog(@"把null当作了BOOL类型");
    return NO;
}

- (NSRange)rangeOfCharacterFromSet:(NSCharacterSet *)aSet{
    NSRange nullRange = {NSNotFound, 0};
    return nullRange;
}

@end
