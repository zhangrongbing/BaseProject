//
//  NSDictionary+ObjectOrNilForKey.m
//  BaseProject
//
//  Created by bing liu on 2018/10/24.
//  Copyright © 2018 Lovcreate. All rights reserved.
//

#import "NSDictionary+ObjectOrNilForKey.h"

@implementation NSDictionary (ObjectOrNilForKey)

- (id)objectOrNilForKey:(id)key {
    id obj = [self objectForKey:key];
    if ([obj isEqual:[NSNull null]]) {
        return nil;
    }
    return obj;
}
@end
