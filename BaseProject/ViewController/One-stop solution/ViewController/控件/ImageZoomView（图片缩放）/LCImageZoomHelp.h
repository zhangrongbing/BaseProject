//
//  LCImageZoomHelp.h
//  BaseProject
//
//  Created by Swift liu on 2018/11/2.
//  Copyright © 2018 Lovcreate. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LCImageZoomHelp : NSObject


/**
 点击缩放图片

 @param contentImageView 需要缩放的图片
 */
+(void)_imageZoomWithImageView:(UIImageView *)contentImageView;

@end

NS_ASSUME_NONNULL_END
