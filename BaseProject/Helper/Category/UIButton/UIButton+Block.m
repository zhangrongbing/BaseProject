//
//  UIButton+Block.m
//  BaseProject
//
//  Created by bing liu on 2018/10/25.
//  Copyright © 2018 Lovcreate. All rights reserved.
//

#import "UIButton+Block.h"

@implementation UIButton (Block)

static char eventKey;

/**
 *  UIButton添加UIControlEvents事件的block
 *
 *  @param event 事件
 *  @param action block代码
 */
- (void) handleControlEvent:(UIControlEvents)event withBlock:(void (^)(void))action {
    objc_setAssociatedObject(self, &eventKey, action, OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self addTarget:self action:@selector(callActionBlock:) forControlEvents:event];
}

- (void)callActionBlock:(id)sender {
    ActionBlock block = (ActionBlock)objc_getAssociatedObject(self, &eventKey);
    if (block) {
        block();
    }
}

@end
