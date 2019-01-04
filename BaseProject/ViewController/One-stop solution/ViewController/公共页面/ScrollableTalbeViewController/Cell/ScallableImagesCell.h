//
//  ImagesTalbeViewCell.h
//  BaseProject
//
//  Created by 张熔冰 on 2018/12/7.
//  Copyright © 2018年 Lovcreate. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ScallableImagesCell : UITableViewCell

-(void)setSourceData:(NSArray *)sourceData selectedBlock:(void(^)(NSInteger index)) block;

@end

NS_ASSUME_NONNULL_END
