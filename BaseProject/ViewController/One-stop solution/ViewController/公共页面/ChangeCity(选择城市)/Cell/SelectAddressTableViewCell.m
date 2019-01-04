//
//  SelectAddressTableViewCell.m
//  BaseProject
//
//  Created by 张熔冰 on 2018/8/30.
//  Copyright © 2018年 Lovcreate. All rights reserved.
//

#import "SelectAddressTableViewCell.h"

@interface SelectAddressTableViewCell()

@property(nonatomic, weak) IBOutlet UILabel *cityNameLabel;

@end

@implementation SelectAddressTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.separatorInset = UIEdgeInsetsMake(0, 10, 0, 0);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

#pragma mark - Getter and Setter

-(void)setCityName:(NSString *)cityName{
    _cityName = cityName;
    
    self.cityNameLabel.text = cityName;
}
@end
