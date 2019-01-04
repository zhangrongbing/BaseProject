//
//  SoundViewController.m
//  BaseProject
//
//  Created by 张熔冰 on 2018/10/24.
//  Copyright © 2018年 Lovcreate. All rights reserved.
//

#import "SoundViewController.h"
#import <AudioToolbox/AudioToolbox.h>

@interface SoundViewController ()

@property(nonatomic, strong) UIStackView *stackView;

@end

@implementation SoundViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.stackView = [[UIStackView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight - 64)];
    self.stackView.axis = UILayoutConstraintAxisVertical;
    self.stackView.distribution = UIStackViewDistributionFillEqually;
    [self.view addSubview:self.stackView];
    
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeSystem];
    button1.tag = 0;
    [button1 setTitle:@"播放音效文件" forState:UIControlStateNormal];
    [button1 addTarget:self action:@selector(pressButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.stackView addArrangedSubview:button1];
    
    UIButton *button2 = [UIButton buttonWithType:UIButtonTypeSystem];
    button2.tag = 1;
    [button2 setTitle:@"播放系统音效" forState:UIControlStateNormal];
    [button2 addTarget:self action:@selector(pressButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.stackView addArrangedSubview:button2];
    
    UIButton *button3 = [UIButton buttonWithType:UIButtonTypeSystem];
    button3.tag = 2;
    [button3 setTitle:@"延迟3秒播放系统音效" forState:UIControlStateNormal];
    [button3 addTarget:self action:@selector(pressButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.stackView addArrangedSubview:button3];
}

#pragma mark - Action
-(void)pressButton:(UIButton*)button{
    switch (button.tag) {
        case 0:
            [self playForSoundFileName:@"321.caf"];
            break;
        case 1:
            [self playSysSound:1000];
            break;
        case 2:
            [self performSelector:@selector(onPerformMethod) withObject:nil afterDelay:3];
            break;
        default:
            break;
    }
}

-(void)playForSoundFileName:(NSString *)name{
    NSString *path = [[NSBundle mainBundle] pathForResource:name ofType:nil];
    NSURL *url = [NSURL fileURLWithPath:path];
    SystemSoundID soundID;
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)url, &soundID);
    AudioServicesPlaySystemSoundWithCompletion(soundID, ^{
        AudioServicesRemoveSystemSoundCompletion(soundID);
    });
}

-(void)playSysSound:(SystemSoundID) soundID{
    AudioServicesPlayAlertSoundWithCompletion(soundID, ^{
        DebugLog(@"播放完毕了%u", soundID);
    });
}

-(void)onPerformMethod{
    SystemSoundID soundID = 1001;
    AudioServicesPlayAlertSoundWithCompletion(soundID, ^{
        DebugLog(@"播放完毕了%u", soundID);
    });
}
@end
