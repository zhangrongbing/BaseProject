//
//  ImageBrowserViewController.m
//  BaseProject
//
//  Created by 张熔冰 on 2018/8/13.
//  Copyright © 2018年 Lovcreate. All rights reserved.
//

#import "ImageBrowserViewController.h"
#import "ImageCollectionViewCell.h"
#import "UIImageView+AFNetworking.h"
#import <YBImageBrowser/YBImageBrowser.h>

@interface ImageBrowserViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, YBImageBrowserDataSource>

@property(nonatomic, strong) UICollectionView *collectionView;
@property(nonatomic, strong) NSArray *collectionData;
@property(nonatomic, strong) YBImageBrowser *imageBrowser;

@end

@implementation ImageBrowserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.collectionData = @[@"http://t2.hddhhn.com/uploads/tu/201707/5771/96.jpg", @"http://t2.hddhhn.com/uploads/tu/201707/571/101.jpg", @"http://t2.hddhhn.com/uploads/tu/201707/571/91.jpg", @"http://t2.hddhhn.com/uploads/tu/20150700/v45jx3rpefz.jpg", @"http://t2.hddhhn.com/uploads/tu/20150700/z3wvldjvb2y.jpg"];
    [self.view addSubview:self.collectionView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Getter and Setter
-(UICollectionView*)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
        layout.itemSize = CGSizeMake(80, 80);
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) collectionViewLayout:layout];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        [_collectionView registerNib:[UINib nibWithNibName:@"ImageCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:CellIdentifier];
    }
    return _collectionView;
}

-(YBImageBrowser*)imageBrowser{
    if (!_imageBrowser) {
        _imageBrowser = [[YBImageBrowser alloc] init];
        _imageBrowser.currentIndex = 0;
        _imageBrowser.dataSource = self;
    }
    return _imageBrowser;
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.collectionData.count;
}

static NSString *CellIdentifier = @"ImageCollectionViewCell";
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ImageCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    NSString *urlStr = [self.collectionData objectAtIndex:indexPath.item];
    [cell.imageView setImageWithURL:[NSURL URLWithString:urlStr]];

    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [self.imageBrowser showFromController:self];
}

#pragma mark - YBImageBrowserDataSource

- (NSUInteger)yb_numberOfCellForImageBrowserView:(YBImageBrowserView *)imageBrowserView{
    return self.collectionData.count;
}

- (id<YBImageBrowserCellDataProtocol>)yb_imageBrowserView:(YBImageBrowserView *)imageBrowserView dataForCellAtIndex:(NSUInteger)index{
    NSString *imagePath = [self.collectionData objectAtIndex:index];
    YBImageBrowseCellData *cellData = [YBImageBrowseCellData new];
    cellData.url = [NSURL URLWithString:imagePath];
    return cellData;
}

@end
