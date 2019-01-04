//
//  FSAES128.h
//  OrderCar-Driver
//
//  Created by 余洋 on 2017/12/27.
//  Copyright © 2017年 lovcreate. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FSAES128 : NSObject

/**
 *  加密
 *
 *  @param string 需要加密的string
 *
 *  @return 加密后的字符串
 */
+ (NSString *)AES128EncryptStrig:(NSString *)string;

/**
 *  解密
 *
 *  @param string 加密的字符串
 *
 *  @return 解密后的内容
 */
+ (NSString *)AES128DecryptString:(NSString *)string;

@end
