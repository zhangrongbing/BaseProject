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
-(UIImage*)_blurImage:(float) value;


/**
 gif图片

 @param data gif 图片的数据流

 @return gif图片
 */
+ (UIImage *)_animatedGIFWithData:(NSData *)data;


/**
 生成纯色的UIImage, 默认大小为 1*1 自行拉伸

 @param color 颜色

 @return 返回纯色的UIImage
 */
+(UIImage*)_imageWithColor:(UIColor*)color;

/**
 生成纯色的UIImage

 @param color 颜色
 @param size  大小

 @return 返回纯色的UIImage
 */
+(UIImage*)_imageWithColor:(UIColor *)color size:(CGSize)size;

/**
图片转base64字符串

 @param image 图片

 @return base64字符串
 */
+(NSString *)_base64StringForImage:(UIImage *) image;


/**
 base64转图片

 @param base64String base64字符串

 @return 图片
 */
+(UIImage *)_imageForBase64String:(NSString *)base64String;

/**
 截屏

 @param controller 目标控制器
 @return 图片对象
 */
+ (UIImage*)_screenShot:(UIViewController*)controller;

/**
  UIView转UIimage

 @param view 视图
 @return UIImage 对象
 */
+(UIImage*)_imageWithView:(UIView*)view;

/**
 给图片加圆角
 
 @param radius 圆角半径
 @return 处理后的图片
 */
-(UIImage*)_roundedCornerImageWithCornerRadius:(CGFloat)radius;
@end
