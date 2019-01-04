//
//  SearchHistoryTableViewCell.m
//  BaseProject
//
//  Created by 张熔冰 on 2018/8/31.
//  Copyright © 2018年 Lovcreate. All rights reserved.
//

#import "SearchHistoryTableViewCell.h"

@interface SearchHistoryTableViewCell()

@property(nonatomic, weak) IBOutlet UILabel *titleLabel;

@end

@implementation SearchHistoryTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

#pragma mark - Getter and Setter
-(void)setTitle:(NSString *)title{
    _title = title;
    self.titleLabel.text = title;
}


@end
