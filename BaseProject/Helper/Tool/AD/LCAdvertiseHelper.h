//
//  LCAdvertiseHelper.h
//  BaseProject
//
//  Created by Swift liu on 2018/11/1.
//  Copyright © 2018 Lovcreate. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LCAdvertiseView.h"
#import "NSObject+Single.h"

NS_ASSUME_NONNULL_BEGIN

@interface LCAdvertiseHelper : NSObject

SINGLE_H(LCAdvertiseHelper)

+ (void)showAdvertiserView:(NSArray<NSString *> *)imageArray;

@end

NS_ASSUME_NONNULL_END
