//
//  SensorViewController.m
//  BaseProject
//
//  Created by 张熔冰 on 2018/9/4.
//  Copyright © 2018年 Lovcreate. All rights reserved.
//

#import "SensorViewController.h"
#import <CoreMotion/CoreMotion.h>
#import <AVFoundation/AVFoundation.h>

@interface SensorViewController ()

@property(nonatomic, weak) IBOutlet UILabel *pedometerAvailableLabel;
@property(nonatomic, weak) IBOutlet UILabel *pedometerDataLabel;
@property(nonatomic, weak) IBOutlet UILabel *pedometerPaceLabel;
@property(nonatomic, weak) IBOutlet UILabel *pedometerCadenceLabel;
@property(nonatomic, weak) IBOutlet UILabel *pedometerDistanceLabel;
@property(nonatomic, weak) IBOutlet UILabel *brightnessLabel;
@property(nonatomic, weak) IBOutlet UILabel *orientationLabel;

@property(nonatomic, strong) CMPedometer *pedometer;
@property(nonatomic, assign) BOOL isShake;//是否摇一摇

@end

@implementation SensorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createPedometer];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    //监听光线变化
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(screenBrightnessChanged:) name:UIScreenBrightnessDidChangeNotification object:nil];
    //监听距离传感器
    [UIDevice currentDevice].proximityMonitoringEnabled = YES;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(proximityStateChanged:) name:UIDeviceProximityStateDidChangeNotification object:nil];
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [self.pedometer stopPedometerUpdates];
    [UIDevice currentDevice].proximityMonitoringEnabled = NO;
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - Public
//Pedometer 计步器相关
-(void)createPedometer{
    NSMutableString *text = [[NSMutableString alloc] init];
    BOOL authorized = [CMSensorRecorder isAuthorizedForRecording];
    BOOL stepAvailable = [CMPedometer isStepCountingAvailable];
    BOOL distanceAvailable = [CMPedometer isDistanceAvailable];
    BOOL floorAvailable = [CMPedometer isFloorCountingAvailable];
    BOOL paceAvailable = [CMPedometer isPaceAvailable];
    BOOL cadenceAvailable = [CMPedometer isCadenceAvailable];
    [text appendFormat:@"权限:%@\t\t", authorized?@"可用":@"不可用"];
    [text appendFormat:@"计步器:%@\n", stepAvailable?@"可用":@"不可用"];
    [text appendFormat:@"距离预估:%@\t\t", distanceAvailable?@"可用":@"不可用"];
    [text appendFormat:@"上楼预估:%@\n", floorAvailable?@"可用":@"不可用"];
    [text appendFormat:@"速度预估:%@\t\t", paceAvailable?@"可用":@"不可用"];
    [text appendFormat:@"节奏预估:%@\t\t", cadenceAvailable?@"可用":@"不可用"];
    self.pedometerAvailableLabel.text = text;
    
    self.pedometer = [[CMPedometer alloc] init];
    NSString *pedometerDataStr = @"步数:";
    NSString *paceDataStr = @"速度:";
    NSString *cadence = @"节奏:";
    NSString *distance = @"距离:";
    [self.pedometer startPedometerUpdatesFromDate:[NSDate new] withHandler:^(CMPedometerData * _Nullable pedometerData, NSError * _Nullable error) {
        if (error) {
            DebugLog(@"error = %@", error);
            return ;
        }
        NSString *stepStr = [pedometerDataStr stringByAppendingFormat:@"%@",pedometerData.numberOfSteps];
        NSString *paceStr = [paceDataStr stringByAppendingFormat:@"%@",pedometerData.currentPace];
        NSString *cadenceStr = [cadence stringByAppendingFormat:@"%@",pedometerData.currentCadence];
        NSString *distanceStr = [distance stringByAppendingFormat:@"%@",pedometerData.distance];
        
        NSOperationQueue *mainQueue = [NSOperationQueue mainQueue];
        [mainQueue addOperationWithBlock:^{
            self.pedometerDataLabel.text = stepStr;
            self.pedometerPaceLabel.text = paceStr;
            self.pedometerCadenceLabel.text = cadenceStr;
            self.pedometerDistanceLabel.text = distanceStr;
        }];
    }];
}

#pragma mark - Selector
-(void)screenBrightnessChanged:(NSNotification*)notification{
    UIScreen *screent = (UIScreen*)notification.object;
    float brightness = screent.brightness;
    self.brightnessLabel.text = [NSString stringWithFormat:@"外界光线：%.5f",brightness];
}
//距离传感器
-(void)proximityStateChanged:(NSNotification*)notification{
    UIDevice *device = notification.object;
    BOOL state = device.proximityState;
    DebugLog(@"传感器状态 = %@", state?@"靠近了":@"远离了");
}

float brightness = 0.f;
-(IBAction)switchValueChanged:(UISwitch*)mSwitch{
    BOOL isOn = mSwitch.isOn;
    if (isOn) {
        brightness = [UIScreen mainScreen].brightness;
        [UIScreen mainScreen].wantsSoftwareDimming = YES;
        [UIScreen mainScreen].brightness = 1.f;
    }else{
        [UIScreen mainScreen].wantsSoftwareDimming = NO;
        [UIScreen mainScreen].brightness = brightness;
    }
}
//手电筒
-(IBAction)torchSwitchValueChanged:(UISwitch*)mSwitch{
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    [device lockForConfiguration:nil];
    BOOL isOn = mSwitch.isOn;
    if (isOn) {
        [device setTorchMode:AVCaptureTorchModeOn];
    }else{
        [device setTorchMode:AVCaptureTorchModeOff];
    }
    [device unlockForConfiguration];
}
//摇一摇
-(IBAction)motionSwitchChanged:(UISwitch*)mSwitch{
    self.isShake = mSwitch.isOn;
}
//获取屏幕方向
-(IBAction)pressGetDeviceOrientationButton:(id)sender{
    UIDeviceOrientation orientation = [UIDevice currentDevice].orientation;
    self.orientationLabel.text = [NSString stringWithFormat:@"枚举类型:%ld", (long)orientation];
}

-(void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event{
    if (self.isShake == NO) {
        return;
    }
    if (motion == UIEventSubtypeMotionShake) {
        DebugLog(@"%s - 摇一摇开始  event.subtype = %ld", __FUNCTION__, (long)event.subtype);
    }
}

-(void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event{
    if (self.isShake == NO) {
        return;
    }
    DebugLog(@"%s - 摇一摇结束", __FUNCTION__);
    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
}

-(void)motionCancelled:(UIEventSubtype)motion withEvent:(UIEvent *)event{
    if (self.isShake == NO) {
        return;
    }
    if (event.subtype == UIEventSubtypeMotionShake) {
        DebugLog(@"%s - 摇一摇取消", __FUNCTION__);
    }
}

@end
