//
//  NSString+Addition.m
//  BaseProject
//
//  Created by zhangrongbing on 2016/9/29.
//  Copyright © 2016年 lovcreate. All rights reserved.
//

#import "NSString+Addition.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (Addition)

-(NSTimeInterval)lc_timestampByformat:(NSString*)format{
    NSString* tempStr = self;
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:format];
    [dateFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];
    NSDate* date = [dateFormatter dateFromString:tempStr];
    return [date timeIntervalSince1970];
}

-(NSString*)lc_datetimeStringFromOldFormat:(NSString*)oldFormat toNewFormat:(NSString*)newFormat{
    NSTimeInterval timestamp = [self lc_timestampByformat:oldFormat];
    return [self lc_datetimeStringForTimestamp:timestamp format:newFormat];
}

-(NSString*)lc_datetimeStringForTimestamp:(NSTimeInterval)timestamp format:(NSString*)format{
    NSDateFormatter* mFormatter = [[NSDateFormatter alloc] init];
    [mFormatter setDateFormat:format];
    NSDate* datetime = [NSDate dateWithTimeIntervalSince1970:timestamp];
    return [mFormatter stringFromDate:datetime];
}

-(CGSize) lc_sizeForSpecialWidth:(CGFloat)width fontSize:(CGFloat)fontSize{
    CGSize size = CGSizeZero;
    
    NSMutableDictionary* params = @{}.mutableCopy;
    params[NSFontAttributeName] = [UIFont systemFontOfSize:fontSize];
    
    size = [self boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:params context:nil].size;
    return size;
}

-(NSString *)lc_chineseNumFromArbicNum:(NSInteger)arabicNum{
    NSString *arabicNumStr = [NSString stringWithFormat:@"%ld",(long)arabicNum];
    NSArray *arabicNumeralsArray = @[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"0"];
    NSArray *chineseNumeralsArray = @[@"一",@"二",@"三",@"四",@"五",@"六",@"七",@"八",@"九",@"零"];
    NSArray *digits = @[@"个",@"十",@"百",@"千",@"万",@"十",@"百",@"千",@"亿",@"十",@"百",@"千",@"兆"];
    NSDictionary *dictionary = [NSDictionary dictionaryWithObjects:chineseNumeralsArray forKeys:arabicNumeralsArray];
    
    if (arabicNum < 20 && arabicNum > 9) {
        if (arabicNum == 10) {
            return @"十";
        }else{
            NSString *subStr1 = [arabicNumStr substringWithRange:NSMakeRange(1, 1)];
            NSString *a1 = [dictionary objectForKey:subStr1];
            NSString *chinese1 = [NSString stringWithFormat:@"十%@",a1];
            return chinese1;
        }
    }else{
        NSMutableArray *sums = [NSMutableArray array];
        for (int i = 0; i < arabicNumStr.length; i ++)
        {
            NSString *substr = [arabicNumStr substringWithRange:NSMakeRange(i, 1)];
            NSString *a = [dictionary objectForKey:substr];
            NSString *b = digits[arabicNumStr.length -i-1];
            NSString *sum = [a stringByAppendingString:b];
            if ([a isEqualToString:chineseNumeralsArray[9]])
            {
                if([b isEqualToString:digits[4]] || [b isEqualToString:digits[8]])
                {
                    sum = b;
                    if ([[sums lastObject] isEqualToString:chineseNumeralsArray[9]])
                    {
                        [sums removeLastObject];
                    }
                }else
                {
                    sum = chineseNumeralsArray[9];
                }
                
                if ([[sums lastObject] isEqualToString:sum])
                {
                    continue;
                }
            }
            
            [sums addObject:sum];
        }
        NSString *sumStr = [sums  componentsJoinedByString:@""];
        NSString *chinese = [sumStr substringToIndex:sumStr.length-1];
        return chinese;
    }
}

- (unsigned long)lc_hexNumber {
    NSString *str = [self stringByReplacingOccurrencesOfString:@"#" withString:@"0xff"];
    unsigned long hex = strtoul([str UTF8String], 0, 16);
    return hex;
}

-(NSDictionary*) lc_toDictionary{
    if (self == nil) {
        return nil;
    }
    NSData *jsonData = [self dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&err];
    if(err)
    {
        DebugLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}

-(NSString*)lc_MD5{
    const char *original_str = [self UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(original_str, (CC_LONG)strlen(original_str), result);
    NSMutableString *hash = [NSMutableString string];
    for (int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [hash appendFormat:@"%02X", result[i]];
    return [hash lowercaseString];
}

-(NSString*)lc_phoneFormatter{
    if (self.length != 11) {
        return self;
    }else{
        return [self stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
    }
}
@end
