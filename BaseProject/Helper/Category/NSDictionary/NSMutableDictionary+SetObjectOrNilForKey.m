//
//  NSMutableDictionary+SetObjectOrNilForKey.m
//  BaseProject
//
//  Created by bing liu on 2018/10/24.
//  Copyright © 2018 Lovcreate. All rights reserved.
//

#import "NSMutableDictionary+SetObjectOrNilForKey.h"

@implementation NSMutableDictionary (SetObjectOrNilForKey)

- (void)setObjectOrNil:(id)anObject forKey:(id<NSCopying>)aKey {
    if (anObject == nil) {
        [self setObject:[NSNull null] forKey:aKey];
    } else {
        [self setObject:anObject forKey:aKey];
    }
}

@end
