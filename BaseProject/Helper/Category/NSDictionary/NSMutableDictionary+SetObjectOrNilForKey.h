//
//  NSMutableDictionary+SetObjectOrNilForKey.h
//  BaseProject
//
//  Created by bing liu on 2018/10/24.
//  Copyright © 2018 Lovcreate. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSMutableDictionary (SetObjectOrNilForKey)

- (void)setObjectOrNil:(id)anObject forKey:(id<NSCopying>)aKey;

@end

NS_ASSUME_NONNULL_END
