//
//  ImagesTalbeViewCell.m
//  BaseProject
//
//  Created by 张熔冰 on 2018/12/7.
//  Copyright © 2018年 Lovcreate. All rights reserved.
//

#import "ScallableImagesCell.h"

#define KImageWidth 120.f//图片宽度
#define kSpacing 10.f //间距

typedef void(^selectedBlock)(NSInteger index);

@interface ScallableImagesCell()

@property(nonatomic, strong) UIScrollView *scrollView;
@property(nonatomic, strong) NSArray *sourceData;
@property(nonatomic, strong) selectedBlock block;
@end

@implementation ScallableImagesCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self initScrollView];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

#pragma mark - Getter and Setter
-(void)setSourceData:(NSArray *)sourceData selectedBlock:(void(^)(NSInteger index)) block{
    self.block = block;
    self.sourceData = sourceData;
    
    for (int i = 0; i< sourceData.count; i++) {
        NSString *imageName = [sourceData objectAtIndex:i];
        UIImageView *iv = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
        iv.clipsToBounds = YES;
        iv.contentMode = UIViewContentModeScaleAspectFill;
        iv.frame = CGRectMake((KImageWidth+10)*i, 0, KImageWidth, CGRectGetHeight(self.contentView.frame));
        [self.scrollView addSubview:iv];
    }
}

-(void)layoutSubviews{
    [super layoutSubviews];
    self.scrollView.frame = CGRectMake(0, 0, CGRectGetWidth(self.contentView.bounds), CGRectGetHeight(self.contentView.bounds));
    [self.scrollView setContentSize:CGSizeMake(KImageWidth*self.sourceData.count, CGRectGetHeight(self.contentView.bounds))];
}

-(void)initScrollView{
    self.scrollView = [[UIScrollView alloc] init];
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    [self.contentView addSubview:self.scrollView];
}
@end
