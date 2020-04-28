//
//  MyAnnotation.h
//  BaseProject
//
//  Created by 张熔冰 on 2019/10/9.
//  Copyright © 2019 Lovcreate. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MAMapKit/MAMapKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MyAnnotation : NSObject<MAAnnotation>

@property (nonatomic, assign) CLLocationCoordinate2D coordinate;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *subtitle;

@end

NS_ASSUME_NONNULL_END
