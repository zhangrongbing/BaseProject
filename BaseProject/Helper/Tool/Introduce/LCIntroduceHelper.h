//
//  LCIntroduceHelper.h
//  BaseProject
//
//  Created by Swift liu on 2018/10/31.
//  Copyright © 2018 Lovcreate. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSObject+Single.h"

NS_ASSUME_NONNULL_BEGIN

@interface LCIntroduceHelper : NSObject

SINGLE_H(LCIntroduceHelper)

+ (void)showIntroductoryPage:(NSArray<NSString *> *)imageAry;

@end

NS_ASSUME_NONNULL_END
