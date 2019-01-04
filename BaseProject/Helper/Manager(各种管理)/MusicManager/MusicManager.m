//
//  MusicManager.m
//  BaseProject
//
//  Created by 张熔冰 on 2018/10/24.
//  Copyright © 2018年 Lovcreate. All rights reserved.
//

#import "MusicManager.h"
#import <AVFoundation/AVFoundation.h>

@interface MusicManager()

@property(nonatomic, strong) AVAudioPlayer *audioPlay;

@end

@implementation MusicManager

LC_SINGLE_M(MusicManager);

-(instancetype)init{
    if (self = [super init]) {
        self.audioPlay = [[AVAudioPlayer alloc] init];
    }
    return self;
}
@end
