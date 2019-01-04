//
//  UIImage+Addition.h
//  BaseProject
//
//  Created by zhangrongbing on 16/9/28.
//  Copyright © 2016年 lovcreate. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Addition)


/**
 模糊图片

 @param value 模糊程度

 @return 经过模糊处理的图片
 */
-(UIImage*)lc_blurImage:(float) value;


/**
 gif图片

 @param data gif 图片的数据流

 @return gif图片
 */
+ (UIImage *)lc_animatedGIFWithData:(NSData *)data;


/**
 生成纯色的UIImage, 默认大小为 1*1 自行拉伸

 @param color 颜色

 @return 返回纯色的UIImage
 */
+(UIImage*)lc_imageWithColor:(UIColor*)color;

/**
 生成纯色的UIImage

 @param color 颜色
 @param size  大小

 @return 返回纯色的UIImage
 */
+(UIImage*)lc_imageWithColor:(UIColor *)color size:(CGSize)size;

/**
图片转base64字符串

 @param image 图片

 @return base64字符串
 */
+(NSString *)lc_base64StringForImage:(UIImage *) image;


/**
 base64转图片

 @param base64String base64字符串

 @return 图片
 */
+(UIImage *)lc_imageForBase64String:(NSString *)base64String;

/**
 截屏

 @param controller 目标控制器
 @return 图片对象
 */
+ (UIImage*)lc_screenShot:(UIViewController*)controller;

/**
  UIView转UIimage

 @param view 视图
 @return UIImage 对象
 */
+(UIImage*)lc_imageWithView:(UIView*)view;
@end
