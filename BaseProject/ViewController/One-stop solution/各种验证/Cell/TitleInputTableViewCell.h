//
//  TitleInputTableViewCell.h
//  BaseProject
//
//  Created by 张熔冰 on 2018/8/3.
//  Copyright © 2018年 Lovcreate. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TitleInputTableViewCell : UITableViewCell

@property(nonatomic, weak) IBOutlet UILabel *titleLabel;
@property(nonatomic, weak) IBOutlet UILabel *subTitleLabel;
@property(nonatomic, weak) IBOutlet UITextField *textField;
@end
