//
//  ColorLineViewController.m
//  BaseProject
//
//  Created by 张熔冰 on 2018/9/29.
//  Copyright © 2018年 Lovcreate. All rights reserved.
//

#import "ColorLineViewController.h"
#import "ColorLineView.h"

@interface ColorLineViewController ()

@property(nonatomic, strong) ColorLineView *lineView;
@property(nonatomic, strong) UIView *customView;
@property(nonatomic, weak) IBOutlet ColorLineView *colorLineView;

@end

@implementation ColorLineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.lineView = [[ColorLineView alloc] initWithFrame:CGRectMake(26, [UIScreen mainScreen].bounds.size.height - 80.f - 50, [UIScreen mainScreen].bounds.size.width - 26*2, 2)];
    self.lineView.backgroundColor = [UIColor purpleColor];
    [self.view addSubview:self.lineView];
}

#pragma mark - Action
-(IBAction)valueChanged:(UISegmentedControl*)segmentControl{
    NSInteger segment = segmentControl.selectedSegmentIndex;
    if (segment == 0) {
        self.colorLineView.status = ColorLineNormal;
        self.lineView.status = ColorLineNormal;
    }else if(segment == 1){
        self.colorLineView.status = ColorLineEnable;
        self.lineView.status = ColorLineEnable;
    }else if(segment == 2){
        self.colorLineView.status = ColorLineUnable;
        self.lineView.status = ColorLineUnable;
    }
}
@end
