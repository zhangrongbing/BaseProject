//
//  SegmentCodeViewController.m
//  BaseProject
//
//  Created by 张熔冰 on 2018/9/11.
//  Copyright © 2018年 Lovcreate. All rights reserved.
//

#import "SegmentCodeViewController.h"
#import "SegmentCodeView.h"

#define kWidth [UIScreen mainScreen].bounds.size.width
#define kHeight [UIScreen mainScreen].bounds.size.height

@interface SegmentCodeViewController ()

@property(nonatomic, weak) IBOutlet SegmentCodeView *segmentCodeView;
@property(nonatomic, strong) SegmentCodeView *segmentCodeView1;

@end

@implementation SegmentCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.segmentCodeView1 = [SegmentCodeView viewForFrame:CGRectMake(0, 220, kWidth, 44.f)];
    [self.segmentCodeView1 addTarget:self action:@selector(valueChanged:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:self.segmentCodeView1];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self.segmentCodeView becomeFirstTextFieldResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Action
-(void)valueChanged:(SegmentCodeView*)view{
    NSString *value = view.value;
    DebugLog(@"value = %@", value);
}
@end
