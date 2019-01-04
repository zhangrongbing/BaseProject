//
//  NSArray+Addition.m
//  BaseProject
//
//  Created by zhangrongbing on 2016/9/29.
//  Copyright © 2016年 lovcreate. All rights reserved.
//

#import "NSArray+Addition.h"

@implementation NSArray (Addition)

- (NSString *)descriptionWithLocale:(id)locale{
    NSMutableString *strM = [NSMutableString stringWithString:@"[\n"];
    [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx,BOOL *stop) {
        [strM appendFormat:@"\t%@,\n", obj];
    }];
    [strM appendString:@"]"];
    return strM;
}

-(NSString*)lc_stringBySeparator:(NSString*)separator{
    NSString* str = @"";
    for (NSString* s in self) {
        NSString* tempStr = [s stringByAppendingString:separator];
        str = [str stringByAppendingString:tempStr];
    }
    if (str.length > 0) {
        str = [str stringByReplacingCharactersInRange:NSMakeRange(str.length-1, 1) withString:@""];
    }
    return str;
}

-(NSString*)lc_stringByKey:(NSString*)key separator:(NSString*)separator{
    NSString* str = @"";
    for (int i = 0; i < self.count; i++) {
        str = [str stringByAppendingString:[[self objectAtIndex:i] valueForKey:key]];
        if (i == self.count - 1) {
            continue;
        }
        str = [str stringByAppendingString:separator];
    }
    return str;
}

-(NSArray*)lc_arrayByKey:(NSString *)key{
    NSMutableArray* data = @[].mutableCopy;
    for (id m in self) {
        [data addObject:[m valueForKey:key]];
    }
    return data;
}

@end

@implementation NSMutableArray(Addition)

-(void)lc_removeObjectByKey:(NSString*)key value:(NSString*)value{
    NSPredicate* predicate = [NSPredicate predicateWithFormat:@"SELF.%@=%@",key, value];
    
    NSArray* tempArr = [self filteredArrayUsingPredicate:predicate];
    
    [self removeObjectsInArray:tempArr];
}

@end
