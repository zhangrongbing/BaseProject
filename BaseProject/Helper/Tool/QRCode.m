//
//  QRCode.m
//  BaseProject
//
//  Created by 张熔冰 on 2018/10/16.
//  Copyright © 2018年 Lovcreate. All rights reserved.
//

#import "QRCode.h"

@implementation QRCode

+(UIImage*) qrCodeForString:(NSString*)str withSize:(CGFloat)size image:(nullable UIImage*)logo borderColor:(nullable UIColor *)color{
    NSData *textData = [str dataUsingEncoding:NSUTF8StringEncoding];
    
    CIFilter * filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    [filter setDefaults];
    [filter setValue:textData forKey:@"inputMessage"];
    CIImage *QRCodeImage = [filter outputImage];
    //放大
    CGRect extent = CGRectIntegral(QRCodeImage.extent);
    CGFloat scale = MIN(size/CGRectGetWidth(extent), size/CGRectGetHeight(extent));
    // 1.创建bitmap;
    size_t width = CGRectGetWidth(extent) * scale;
    size_t height = CGRectGetHeight(extent) * scale;
    CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();
    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef bitmapImage = [context createCGImage:QRCodeImage fromRect:extent];
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    CGContextScaleCTM(bitmapRef, scale, scale);
    CGContextDrawImage(bitmapRef, extent, bitmapImage);
    // 2.保存bitmap到图片
    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
    CGColorSpaceRelease(cs);
    CGContextRelease(bitmapRef);
    CGImageRelease(bitmapImage);
    UIImage * qrImage = [UIImage imageWithCGImage:scaledImage];
    CGImageRelease(scaledImage);
    if (logo == nil) {
        return qrImage;
    }
    //加入logo
    UIGraphicsBeginImageContextWithOptions(qrImage.size, NO, [UIScreen mainScreen].scale);
    //把二维码图片画上去. (这里是以,图形上下文,左上角为 (0,0)点)
    [qrImage drawInRect:CGRectMake(0, 0, qrImage.size.width, qrImage.size.height)];
    
    CGFloat borderWidth = 0.f;
    if (color) {
        borderWidth = 2.f;
    }
    CGFloat sImageW = MAX(20.f, size/4.f) - borderWidth;
    CGFloat sImageH= sImageW - borderWidth;
    CGFloat sImageX = (qrImage.size.width - sImageW) * 0.5 + borderWidth * 2;
    CGFloat sImgaeY = (qrImage.size.height - sImageH) * 0.5 + borderWidth * 2;
    if (color) {
        //加边框 和 和圆角
        UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(sImageX, sImgaeY, sImageW, sImageH) cornerRadius:3.f];
        path.lineWidth = 4.f;
        [color set];
        [path stroke];
        [path addClip];
    }
    [logo drawInRect:CGRectMake(sImageX, sImgaeY, sImageW, sImageH)];
    //获取当前画得的这张图片
    UIImage *finalyImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return finalyImage;
}

+(UIImage*) qrCodeForString:(NSString*)str withSize:(CGFloat)size image:(nullable UIImage*)logo{
    return [QRCode qrCodeForString:str withSize:size image:logo borderColor:nil];
}

+(UIImage*) qrCodeForString:(NSString*)str withImage:(nonnull UIImage*)logo{
    return [QRCode qrCodeForString:str withSize:80.f image:logo];
}

+(UIImage*) qrCodeForString:(NSString*)str{
    return [QRCode qrCodeForString:str withSize:80.f image:nil];
}

- (UIImage *)createNonInterpolatedUIImageFormCIImage:(CIImage *)image withSize:(CGFloat) size{
    CGRect extent = CGRectIntegral(image.extent);
    CGFloat scale = MIN(size/CGRectGetWidth(extent), size/CGRectGetHeight(extent));
    // 1.创建bitmap;
    size_t width = CGRectGetWidth(extent) * scale;
    size_t height = CGRectGetHeight(extent) * scale;
    CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();
    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef bitmapImage = [context createCGImage:image fromRect:extent];
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    CGContextScaleCTM(bitmapRef, scale, scale);
    CGContextDrawImage(bitmapRef, extent, bitmapImage);
    // 2.保存bitmap到图片
    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
    CGContextRelease(bitmapRef);
    CGImageRelease(bitmapImage);
    CGColorSpaceRelease(cs);
    UIImage *resultImage = [UIImage imageWithCGImage:scaledImage];
    CGImageRelease(scaledImage);
    return resultImage;
}
@end
