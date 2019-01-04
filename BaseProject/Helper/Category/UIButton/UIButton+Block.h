//
//  UIButton+Block.h
//  BaseProject
//
//  Created by bing liu on 2018/10/25.
//  Copyright © 2018 Lovcreate. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <objc/runtime.h>

typedef void (^ActionBlock)(void);

NS_ASSUME_NONNULL_BEGIN

@interface UIButton (Block)

/**
 *  UIButton添加UIControlEvents事件的block
 *
 *  @param event 事件
 *  @param action block代码
 */
- (void) handleControlEvent:(UIControlEvents)event withBlock:(ActionBlock)action;

@end

NS_ASSUME_NONNULL_END
