//
//  SwitchTableViewCell.m
//  BaseProject
//
//  Created by 张熔冰 on 2018/8/2.
//  Copyright © 2018年 Lovcreate. All rights reserved.
//

#import "SwitchTableViewCell.h"

@implementation SwitchTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

-(IBAction)switchValueChanged:(UISwitch*)iSwitch{
    if (self.valueChangedBlock) {
        self.valueChangedBlock(iSwitch.isOn);
    }
}
@end
