//
//  ViewController.h
//  BaseProject
//
//  Created by 张熔冰 on 2018/8/1.
//  Copyright © 2018年 Lovcreate. All rights reserved.
//

#import "BaseTableViewController.h"

typedef void(^myBlock)(void);

@interface ViewController : BaseTableViewController

@property(nonatomic, strong) myBlock block;

@end