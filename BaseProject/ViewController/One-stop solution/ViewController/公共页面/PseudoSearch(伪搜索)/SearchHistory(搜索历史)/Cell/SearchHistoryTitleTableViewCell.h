//
//  SearchHistoryTitleTableViewCell.h
//  BaseProject
//
//  Created by 张熔冰 on 2018/8/31.
//  Copyright © 2018年 Lovcreate. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchHistoryTitleTableViewCell : UITableViewCell

@property(nonatomic, strong) void(^clearHandler)(void);

@end
