//
//  SelectAddressHeaderView.m
//  BaseProject
//
//  Created by 张熔冰 on 2018/8/30.
//  Copyright © 2018年 Lovcreate. All rights reserved.
//

#import "SelectAddressHeaderView.h"
#import <CoreLocation/CoreLocation.h>
#import "UIColor+Addition.h"

@interface SelectAddressHeaderView()<CLLocationManagerDelegate>

@property(nonatomic, weak) IBOutlet UILabel *localCityLabel;
@property(nonatomic, weak) IBOutlet UIButton *locationButton;
@property(nonatomic, weak) IBOutlet UISegmentedControl *segmentedControl;

@property(nonatomic, strong) CLLocationManager *locationManager;
@property(nonatomic, strong) NSArray *hotCitys;

@end

@implementation SelectAddressHeaderView

-(void)awakeFromNib{
    [super awakeFromNib];
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyThreeKilometers;
    [self.locationManager requestWhenInUseAuthorization];
    self.locationManager.distanceFilter = 10.f;
    [self.locationManager requestWhenInUseAuthorization];
    [self.locationManager startUpdatingLocation];
    self.localCityLabel.text = LCGetStringWithKeyFromTable(@"定位中___", nil);
    [self.segmentedControl setTitleTextAttributes:@{NSForegroundColorAttributeName : RGB(0x666666), NSFontAttributeName : [UIFont systemFontOfSize:14.f]} forState:UIControlStateNormal];
}

+(instancetype)viewForFrame:(CGRect)frame handler:(void(^)(NSInteger index)) handler{
    NSArray *hotCitys = @[@"北京", @"上海", @"广州", @"深圳", @"杭州"];
    SelectAddressHeaderView *view = [SelectAddressHeaderView viewForFrame:frame hotCitys:hotCitys handler:handler];
    return view;
}

+(instancetype)viewForFrame:(CGRect)frame hotCitys:(NSArray*)citys handler:(void(^)(NSInteger index)) handler{
    SelectAddressHeaderView *view = [[[NSBundle mainBundle] loadNibNamed:@"SelectAddressHeaderView" owner:nil options:nil] lastObject];
    view.hotCitys = citys;
    return view;
}

#pragma mark - CLLocationManagerDelegate
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    CLLocation *location = [locations firstObject];
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        if (error || placemarks.count == 0) {
            self.localCityLabel.text = LCGetStringWithKeyFromTable(@"定位失败", nil);
            return ;
        }
        CLPlacemark *placemark = [placemarks firstObject];
        NSString *city = placemark.locality;
        self.localCityLabel.text = city;
    }];
    [manager stopUpdatingLocation];
}

-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    if (error) {
        self.localCityLabel.text = LCGetStringWithKeyFromTable(@"定位失败", nil);
    }
}

#pragma mark - Action
-(IBAction)pressLocationButton:(UIButton*)button{
    [button setEnabled:NO];
    [self.locationManager startUpdatingLocation];
    self.localCityLabel.text = LCGetStringWithKeyFromTable(@"定位中___", nil);
}
@end
