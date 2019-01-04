//
//  QRCode.h
//  BaseProject
//
//  Created by 张熔冰 on 2018/10/16.
//  Copyright © 2018年 Lovcreate. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface QRCode : NSObject

+(UIImage*) qrCodeForString:(NSString*)str;
+(UIImage*) qrCodeForString:(NSString*)str withImage:(nonnull UIImage*)logo;
+(UIImage*) qrCodeForString:(NSString*)str withSize:(CGFloat)size image:(nullable UIImage*)logo;
+(UIImage*) qrCodeForString:(NSString*)str withSize:(CGFloat)size image:(nullable UIImage*)logo borderColor:(nullable UIColor *)color;

@end

NS_ASSUME_NONNULL_END
