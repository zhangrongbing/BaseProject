//
//  UIView+Block.h
//  BaseProject
//
//  Created by bing liu on 2018/10/25.
//  Copyright © 2018 Lovcreate. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (Block)

- (void)addClickedBlock:(void(^)(id obj))tapAction;

@end

NS_ASSUME_NONNULL_END
