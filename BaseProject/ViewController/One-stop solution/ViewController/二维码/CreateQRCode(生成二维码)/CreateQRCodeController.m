//
//  CreateQRCodeViewController.m
//  BaseProject
//
//  Created by 张熔冰 on 2018/10/16.
//  Copyright © 2018年 Lovcreate. All rights reserved.
//

#import "CreateQRCodeController.h"
#import "QRCode.h"

@interface CreateQRCodeController ()

@property(nonatomic, weak) IBOutlet UIImageView *imageView;
@property(nonatomic, weak) IBOutlet UITextField *textField;

@end

@implementation CreateQRCodeController

- (void)viewDidLoad {
    [super viewDidLoad];
}

-(void)dealloc{
    DebugLog(@"dealloc");
}
-(IBAction)pressCreateQRCodeBuutton:(id)sender{
//    NSString *text = self.textField.text;
//    weixin://wxpay/bizpayurl?pr=l9LIHMb
    UIImage *qrImage = [QRCode qrCodeForString:@"abc" withSize:180.f image:[UIImage imageNamed:@"logo"] borderColor:[UIColor redColor]];
    self.imageView.image = qrImage;
}
@end
