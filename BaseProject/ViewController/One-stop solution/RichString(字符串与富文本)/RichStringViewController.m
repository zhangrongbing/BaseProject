//
//  RichStringViewController.m
//  BaseProject
//
//  Created by Swift liu on 2018/10/26.
//  Copyright © 2018 Lovcreate. All rights reserved.
//

#import "RichStringViewController.h"
#import "NSMutableAttributedString+LCAttributedString.h"

@interface RichStringViewController ()

@end

@implementation RichStringViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UILabel *label = [[UILabel alloc] init];
    label.font = [UIFont systemFontOfSize:15];
    label.numberOfLines = 0;
    label.textColor = [UIColor redColor];

    label.attributedText = [NSMutableAttributedString lc_changeColorWithColor:[UIColor cyanColor] TotalString:@"这是一句话，这里是红色，这里也变色" SubStringArray:@[@"是红色",@"也变色"]];
        
    [self.view addSubview:label];
    
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(self.view).offset(144);
        make.right.equalTo(self.view).offset(-44);
    }];
    
    
    
    
    // Do any additional setup after loading the view.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
