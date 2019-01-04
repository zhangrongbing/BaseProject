//
//  CiphertextViewController.m
//  BaseProject
//
//  Created by 张熔冰 on 2018/8/16.
//  Copyright © 2018年 Lovcreate. All rights reserved.
//

#import "CiphertextViewController.h"
#import "FSAES128.h"
#import "NSString+Addition.h"
#import "DES3Util.h"

@interface CiphertextViewController ()

@property(nonatomic, weak) IBOutlet UITextField *textField;
@property(nonatomic, weak) IBOutlet UILabel *encryptLabel;
@property(nonatomic, weak) IBOutlet UILabel *decryptLabel;

@end

@implementation CiphertextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Action
-(IBAction)pressAESButton:(id)sender{
    NSString *text = self.textField.text;
    NSString *encryptText = [FSAES128 AES128EncryptStrig:text];
    self.encryptLabel.text = encryptText;
    
    NSString *decryptText = [FSAES128 AES128DecryptString:encryptText];
    self.decryptLabel.text = decryptText;
    
}

-(IBAction)pressMD5Button:(id)sender{
    NSString *text = self.textField.text;
    NSString *encryptText = [text lc_MD5];
    self.encryptLabel.text = encryptText;
}

-(IBAction)pressDESButton:(id)sender{
    NSString *text = self.textField.text;
    NSString *encryptText = [DES3Util encrypt:text];
    self.encryptLabel.text = encryptText;
    
    self.decryptLabel.text = [DES3Util decrypt:encryptText];
}
@end
