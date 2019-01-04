//
//  SteamingMediaController.h
//  BaseProject
//
//  Created by 张熔冰 on 2018/10/24.
//  Copyright © 2018年 Lovcreate. All rights reserved.
//

#import "BaseTableViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface SteamingMediaController : BaseTableViewController

@end

NS_ASSUME_NONNULL_END


//// 获取视频第一帧
//- (UIImage*) getVideoPreViewImage:(NSURL *)url{
//    AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:url options:nil];
//    AVAssetImageGenerator *assetGen = [[AVAssetImageGenerator alloc] initWithAsset:asset];
//    
//    assetGen.appliesPreferredTrackTransform = YES;
//    CMTime time = CMTimeMakeWithSeconds(0.0, 600);
//    NSError *error = nil;
//    CMTime actualTime;
//    CGImageRef image = [assetGen copyCGImageAtTime:time actualTime:&actualTime error:&error];
//    UIImage *videoImage = [[UIImage alloc] initWithCGImage:image];
//    CGImageRelease(image);
//    return videoImage;
//}
