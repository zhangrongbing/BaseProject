//
//  LocationMapVC.m
//  BaseProject
//
//  Created by 张熔冰 on 2019/10/9.
//  Copyright © 2019 Lovcreate. All rights reserved.
//

#import "LocationMapVC.h"
#import <AMapFoundationKit/AMapFoundationKit.h>
#import "MyAnnotation.h"
#import "DataBaseManager.h"
#import <MAMapKit/MAMapKit.h>
#import "UIView+Addition.h"

@interface LocationMapVC ()<MAMapViewDelegate>
@property(nonatomic, strong) MAMapView *mapView;
@property(nonatomic, strong) NSMutableArray *annArr;
@end

@implementation LocationMapVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.mapView];
    //获取数据 地图汇点
    DataBaseManager* dbManager = [DataBaseManager sharedInstance];
    NSArray* data = [dbManager getAnns];
    self.annArr = [NSMutableArray array];
    for (NSDictionary *item in data) {
        CLLocationDegrees lat = [[item objectForKey:@"lat"] doubleValue];
        CLLocationDegrees lng = [[item objectForKey:@"lng"] doubleValue];
        CLLocationCoordinate2D coor = CLLocationCoordinate2DMake(lat, lng);
        MyAnnotation *ann = [[MyAnnotation alloc] init];
        ann.coordinate = coor;
        [self.annArr addObject:ann];
    }
    [self.mapView addAnnotations:self.annArr];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self.mapView showAnnotations:self.annArr animated:YES];
}

#pragma mark - MAMapViewDelegate
- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id <MAAnnotation>)annotation{
    MAAnnotationView *view = [[MAAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"view"];
    view.frame = CGRectMake(0, 0, 10, 10);
    view.backgroundColor = [UIColor redColor];
    return view;
}

#pragma mark - 懒加载
-(MAMapView*)mapView{
    if (!_mapView) {
        _mapView = [[MAMapView alloc] initWithFrame:CGRectMake(0, kSafeTop + 100, kScreenWidth, kScreenHeight - kSafeTop)];
        _mapView.showsUserLocation = NO;
    }
    return _mapView;
}
@end
