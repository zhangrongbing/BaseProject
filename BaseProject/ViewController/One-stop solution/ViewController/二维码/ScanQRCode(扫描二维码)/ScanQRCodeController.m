//
//  ScanQRCodeControllerViewController.m
//  BaseProject
//1)读取二维码需要导入AVFoundation框架
//2)利用相机识别二维码中的内容
//3)会话将相机采集到的二维码图像转换成字符串数据
//  Created by 张熔冰 on 2018/10/22.
//  Copyright © 2018年 Lovcreate. All rights reserved.
//

#import "ScanQRCodeController.h"
#import <AVFoundation/AVFoundation.h>
#import "ShadeView.h"

@interface ScanQRCodeController ()<AVCaptureMetadataOutputObjectsDelegate>

@property(nonatomic, strong) AVCaptureSession *session;
@property(nonatomic, strong) AVCaptureVideoPreviewLayer *previewLayer;
@property(nonatomic, strong) NSTimer *timer;
@property(nonatomic, strong) ShadeView *shadeView;

@end

@implementation ScanQRCodeController

- (void)viewDidLoad {
    [super viewDidLoad];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    //1.实例化拍摄设备
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    //2.设置输入设备
    AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:device error:nil];
    //设置元数据输出
    AVCaptureMetadataOutput *output = [[AVCaptureMetadataOutput alloc] init];
    [output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    [self setIntersectionRectForOutput:output];
    //添加拍摄会话
    self.session = [[AVCaptureSession alloc] init];
    [self.session addInput:input];
    [self.session addOutput:output];
    [output setMetadataObjectTypes:@[AVMetadataObjectTypeQRCode]];
    
    self.previewLayer = [AVCaptureVideoPreviewLayer layerWithSession:self.session];
    self.previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    self.previewLayer.frame = self.view.bounds;
    [self.view.layer insertSublayer:self.previewLayer atIndex:0];
    
    self.shadeView = [[ShadeView alloc] init];
    [self.view addSubview:self.shadeView];
    [self.session startRunning];
}

-(void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    self.shadeView.frame = self.view.bounds;
    self.previewLayer.frame = self.view.bounds;
}

-(void)dealloc{
    DebugLog(@"dealloc");
    self.shadeView = nil;
}

#pragma mark - AVCaptureMetadataOutputObjectsDelegate
- (void)captureOutput:(AVCaptureOutput *)output didOutputMetadataObjects:(NSArray<__kindof AVMetadataObject *> *)metadataObjects fromConnection:(AVCaptureConnection *)connection{
    if ([metadataObjects count] > 0) {
        AVMetadataMachineReadableCodeObject *metadataObject = metadataObjects[0];
        NSString *stringValue = metadataObject.stringValue;
        DebugLog(@"stringValue = %@", stringValue);
    }
}

-(void)showAlert{
    UIAlertController *controller = [UIAlertController alertControllerWithTitle:LCGetStringWithKeyFromTable(@"提示", nil) message:LCGetStringWithKeyFromTable(@"相机无法打开", nil) preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
    [controller addAction:action];
    [self presentViewController:controller animated:YES completion:nil];
}

-(void)setIntersectionRectForOutput:(AVCaptureMetadataOutput*)output{
    CGRect mainRect = [UIScreen mainScreen].bounds;
    CGFloat width = mainRect.size.width;
    CGFloat height = mainRect.size.height;
    CGFloat scale = width/height;
    CGRect rect = CGRectMake(0.5 - 5/7.f*scale/2.f, 1/7.f, 5/7.f*scale, 5/7.f);
    [output setRectOfInterest:rect];//这个rect的x和y互换，width和height互换
}
@end
