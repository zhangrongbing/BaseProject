//
//  ShortcutManager.m
//  BaseProject
//
//  Created by 张熔冰 on 2019/1/10.
//  Copyright © 2019年 Lovcreate. All rights reserved.
//

#import "ShortcutManager.h"

@implementation ShortcutManager

SINGLE_M(ShortcutManager);

-(BOOL) selectShortCutItem:(UIApplicationShortcutItem*)item{
    if (self.delegate && [self.delegate respondsToSelector:@selector(manager:didSelectedShortCutItem:)]) {
        return [self.delegate manager:self didSelectedShortCutItem:item];
    }
    return NO;
}

@end
