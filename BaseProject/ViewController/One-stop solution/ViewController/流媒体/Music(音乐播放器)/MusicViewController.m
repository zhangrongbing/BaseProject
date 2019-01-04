//
//  MusicViewController.m
//  BaseProject
//
//  Created by 张熔冰 on 2018/10/24.
//  Copyright © 2018年 Lovcreate. All rights reserved.
//

#import "MusicViewController.h"
#import "MusicManager.h"
#import <FreeStreamer/FSAudioStream.h>

@interface MusicViewController ()

@property(nonatomic, strong) MusicManager *manager;
@property(nonatomic, strong) FSAudioStream *streamer;

@end

@implementation MusicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.manager = [MusicManager sharedInstance];
    self.streamer = [[FSAudioStream alloc] init];
    [self.streamer playFromURL:[NSURL URLWithString:@""]];
}

@end
