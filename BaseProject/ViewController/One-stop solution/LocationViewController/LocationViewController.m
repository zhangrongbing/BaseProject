//
//  LocationViewController.m
//  BaseProject
//
//  Created by 张熔冰 on 2019/10/8.
//  Copyright © 2019 Lovcreate. All rights reserved.
//

#import "LocationViewController.h"
#import <CoreLocation/CoreLocation.h>
#import "DataBaseManager.h"
#import "LocationMapVC.h"
#import <AMapLocationKit/AMapLocationKit.h>

@interface LocationViewController ()<AMapLocationManagerDelegate>
@property(nonatomic, strong) AMapLocationManager* locationManager;
@property(nonatomic, weak) IBOutlet UITextView* textView;
@property(nonatomic, weak) IBOutlet UILabel *label;
@property(nonatomic, weak) IBOutlet UISwitch *mSwitch;
@property(nonatomic, weak) IBOutlet UITextField *lineTextField;
@property(nonatomic, strong) NSString *textData;
@property(nonatomic, strong) DataBaseManager *dbManager;
@property(nonatomic, assign) NSInteger index;
@property(nonatomic, assign) NSString *line;
@end

@implementation LocationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.index = 0;
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"地图标点" style:UIBarButtonItemStylePlain target:self action:@selector(pressRightItem:)];
    UIBarButtonItem *clearItem = [[UIBarButtonItem alloc] initWithTitle:@"清除" style:UIBarButtonItemStylePlain target:self action:@selector(pressClearItem:)];
    self.navigationItem.rightBarButtonItems = @[rightItem, clearItem];
}

-(AMapLocationManager*)locationManager{
    if (!_locationManager) {
        _locationManager = [[AMapLocationManager alloc] init];
        _locationManager.delegate = self;
        _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        _locationManager.distanceFilter = 10;
    }
    return _locationManager;
}
-(DataBaseManager*)dbManager{
    if (!_dbManager) {
        _dbManager = [DataBaseManager sharedInstance];
    }
    return _dbManager;
}
//开始定位
-(IBAction)startLocation:(id)sender{
    self.textData = @"定位开始";
    self.textView.text = self.textData;
    self.index = 0;
    [self.locationManager setPausesLocationUpdatesAutomatically:NO];
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 9) {
        self.locationManager.allowsBackgroundLocationUpdates = YES;
    }
    //开始持续定位
    [self.locationManager startUpdatingLocation];
}

-(IBAction)stopLocation:(id)sender{
    [self.locationManager stopUpdatingLocation];
    self.textData = [self.textData stringByAppendingString:@"\n定位停止"];
    self.textView.text = self.textData;
}

#pragma mark - AMapLocationManagerDelegate

- (void)amapLocationManager:(AMapLocationManager *)manager didUpdateLocation:(CLLocation *)location reGeocode:(AMapLocationReGeocode *)reGeocode{
    double lat = location.coordinate.latitude;
    double lng = location.coordinate.longitude;
    self.textData = [self.textData stringByAppendingFormat:@"\n序号：%ld 线路：%@ 坐标:%f, %f，%@",(long)self.index, self.line, lat, lng, self.mSwitch.on ? @"在线" : @"离线"];
    self.textView.text = self.textData;
    [self.dbManager addLat:lat lng:lng network:self.mSwitch.on line:self.line];
    self.index ++;
}

-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    self.textData = error.description;
    self.textView.text = self.textData;
}

- (void)amapLocationManager:(AMapLocationManager *)manager doRequireLocationAuth:(CLLocationManager*)locationManager{
    
}

#pragma mar - Action
-(void)pressRightItem:(UIBarButtonItem*) item{
    LocationMapVC *mapVC = [[LocationMapVC alloc] initWithNibName:@"LocationMapVC" bundle:nil];
    [self.navigationController pushViewController:mapVC animated:YES];
}
-(void)pressClearItem:(UIBarButtonItem*) item{
    [self.dbManager clearAnn];
}

-(IBAction)pressChangeLine:(UIButton*)button{
    self.line = self.lineTextField.text;
}
@end
