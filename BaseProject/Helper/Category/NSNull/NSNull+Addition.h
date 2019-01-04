//
//  NSNull+Addition.h
//  SmartWxdewDemo
//
//  Created by 张熔冰 on 2018/9/20.
//  Copyright © 2018年 伯明利. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSNull (Addition)

- (NSUInteger)length;

- (NSInteger)integerValue;

- (float)floatValue;

- (NSString *)description;

- (NSArray *)componentsSeparatedByString:(NSString *)separator;

- (id)objectForKey:(id)key;

- (BOOL)boolValue;

- (NSRange)rangeOfCharacterFromSet:(NSCharacterSet *)aSet;

@end
