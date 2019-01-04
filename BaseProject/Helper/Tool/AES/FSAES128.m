//
//  FSAES128.m
//  OrderCar-Driver
//
//  Created by 余洋 on 2017/12/27.
//  Copyright © 2017年 lovcreate. All rights reserved.
//

#import "FSAES128.h"
#import "NSData+AES128.h"
#import "GTMBase64.h"
#import "NSString+Base64.h"

#define IV  nil //偏移量
#define  KEY  @"bmhwYWcxbXhkeXQ1Znk4Mg==" //秘钥

@implementation FSAES128

/**
 *  加密
 *
 *  @param string 需要加密的string
 *
 *  @return 加密后的字符串
 */
+ (NSString *)AES128EncryptStrig:(NSString *)string{
    NSString *keyStr = [KEY base64DecodedString];
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    NSData *aesData = [data AES128EncryptWithKey:keyStr iv:IV];
    return [GTMBase64 stringByEncodingData:aesData];
}

/**
 *  解密
 *
 *  @param string 加密的字符串
 *
 *  @return 解密后的内容
 */
+ (NSString *)AES128DecryptString:(NSString *)string{
    NSString *keyStr = [KEY base64DecodedString];
    NSData *data = [GTMBase64 decodeData:[string dataUsingEncoding:NSUTF8StringEncoding]];
    NSData *aesData = [data AES128DecryptWithKey:keyStr iv:IV];
    return [[NSString alloc] initWithData:aesData encoding:NSUTF8StringEncoding];
}

@end
