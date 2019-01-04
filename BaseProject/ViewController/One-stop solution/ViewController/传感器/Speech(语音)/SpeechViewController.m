//
//  SpeechViewController.m
//  BaseProject
//
//  Created by 张熔冰 on 2018/10/18.
//  Copyright © 2018年 Lovcreate. All rights reserved.
//

#import "SpeechViewController.h"
#import "SpeechManager.h"

@interface SpeechViewController ()

@property(nonatomic, strong) SpeechManager *manager;

@end

@implementation SpeechViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.manager = [SpeechManager sharedInstance];
}

-(IBAction)pressSpeechButton:(id)sender{
    [self performSelector:@selector(speechString:) withObject:@"乘客取消订单" afterDelay:3.f];
}

-(void)speechString:(NSString*)string{
    [self.manager speakString:string];
}

-(void)dealloc{
    DebugLog(@"");
}
@end
