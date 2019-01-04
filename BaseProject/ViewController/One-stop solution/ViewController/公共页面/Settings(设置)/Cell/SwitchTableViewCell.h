//
//  SwitchTableViewCell.h
//  BaseProject
//
//  Created by 张熔冰 on 2018/8/2.
//  Copyright © 2018年 Lovcreate. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SwitchTableViewCell : UITableViewCell

@property(nonatomic, weak) IBOutlet UILabel *titleLabel;
@property(nonatomic, weak) IBOutlet UISwitch *iSwitch;

@property(nonatomic, weak) void(^valueChangedBlock)(BOOL isOn);
@end
