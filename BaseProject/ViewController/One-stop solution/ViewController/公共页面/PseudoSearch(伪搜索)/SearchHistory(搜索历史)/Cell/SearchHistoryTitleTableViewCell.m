//
//  SearchHistoryTitleTableViewCell.m
//  BaseProject
//
//  Created by 张熔冰 on 2018/8/31.
//  Copyright © 2018年 Lovcreate. All rights reserved.
//

#import "SearchHistoryTitleTableViewCell.h"

@implementation SearchHistoryTitleTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

#pragma mark - Action
-(IBAction)pressClearButton:(UIButton*)button{
    if (self.clearHandler) {
        self.clearHandler();
    }
}
@end
