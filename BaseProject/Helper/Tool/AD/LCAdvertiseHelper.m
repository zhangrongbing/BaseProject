//
//  LCAdvertiseHelper.m
//  BaseProject
//
//  Created by Swift liu on 2018/11/1.
//  Copyright © 2018 Lovcreate. All rights reserved.
//

#import "LCAdvertiseHelper.h"

static NSString *const adImageName = @"adImageName";

@implementation LCAdvertiseHelper

LC_SINGLE_M(LCAdvertiseHelper)

- (instancetype)init{
    self = [super init];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(adClick:) name:NotificationContants_Advertise_Key object:nil];
    }
    return self;
}

+ (void)showAdvertiserView:(NSArray<NSString *> *)imageArray{
    //判断沙盒中是否存在广告图片，如果存在，直接显示
    NSString *filePath = [[LCAdvertiseHelper sharedInstance] getFilePathWithImageName:[NSUserDefaults.standardUserDefaults valueForKey:adImageName]];
    
    BOOL isExist = [[LCAdvertiseHelper sharedInstance] isFileExistWithFilePath:filePath];
    if (isExist) {
        // 图片存在
        LCAdvertiseView *advertiseView = [[LCAdvertiseView alloc] initWithFrame:UIScreen.mainScreen.bounds];
        advertiseView.filePath = filePath;
        [advertiseView show];
    }
    
    //无论沙盒中是否存在广告图片，都需要重新调用广告接口，判断广告是否更新
    [[LCAdvertiseHelper sharedInstance] getAdvertisingImage:imageArray];
}

/**
 初始化广告页面
 */
- (void)getAdvertisingImage:(NSArray<NSString *> *)imageArray{
    //随机取一张
    NSString *imageUrl = imageArray[arc4random() % imageArray.count];
    NSArray *stringArr = [imageUrl componentsSeparatedByString:@"/"];
    NSString *imageName = stringArr.lastObject;
    // 拼接沙盒路径
    NSString *filePath = [self getFilePathWithImageName:imageName];
    BOOL isExist = [self isFileExistWithFilePath:filePath];
    if (!isExist){
        // 如果该图片不存在，则删除老图片，下载新图片
        [self downloadAdImageWithUrl:imageUrl imageName:imageName];
    }
}

/**
 判断文件是否存在
 */
- (BOOL)isFileExistWithFilePath:(NSString *)filePath{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL isDirectory = FALSE;
    return [fileManager fileExistsAtPath:filePath isDirectory:&isDirectory];
}


/**
 下载新图片
 */
- (void)downloadAdImageWithUrl:(NSString *)imageUrl imageName:(NSString *)imageName{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:imageUrl]];
        NSString *filePath = [self getFilePathWithImageName:imageName]; // 保存文件的名称
        
        if ([data writeToFile:filePath atomically:YES]) {// 保存成功
            DebugLog(@"保存成功");
            [self deleteOldImage];
            [NSUserDefaults.standardUserDefaults setValue:imageName forKey:adImageName];
            [NSUserDefaults.standardUserDefaults synchronize];
        }else{
            DebugLog(@"保存失败");
        }
        
    });
}

/**
 删除旧图片
 */
- (void)deleteOldImage{
    NSString *imageName = [NSUserDefaults.standardUserDefaults valueForKey:adImageName];
    if (imageName) {
        NSString *filePath = [self getFilePathWithImageName:imageName];
        NSFileManager *fileManager = [NSFileManager defaultManager];
        [fileManager removeItemAtPath:filePath error:nil];
    }
}

/**
 根据图片名拼接文件路径
 */
- (NSString *)getFilePathWithImageName:(NSString *)imageName{
    if (imageName) {
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory,NSUserDomainMask, YES);
        NSString *filePath = [[paths objectAtIndex:0] stringByAppendingPathComponent:imageName];
        return filePath;
    }
    return nil;
}

//NotificationContants_Advertise_Key,点击事件，没有区分哪张图。
- (void)adClick:(NSNotification *)noti{
    NSString *url = @"https://baidu.com";
    if([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:url]]) {
    
        if (@available(iOS 10.0, *)) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url] options:@{} completionHandler:^(BOOL success) {
                
            }];
        } else {
            // Fallback on earlier versions
        }
    }
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


@end
