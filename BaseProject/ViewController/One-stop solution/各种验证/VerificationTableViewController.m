//
//  VerificationTableViewController.m
//  BaseProject
//
//  Created by 张熔冰 on 2018/8/3.
//  Copyright © 2018年 Lovcreate. All rights reserved.
//

#import "VerificationTableViewController.h"
#import "TitleInputTableViewCell.h"
#import "Verification.h"

@interface VerificationTableViewController ()

@property(nonatomic, strong) NSArray *tableData;
@property(nonatomic, strong) NSMutableArray *verficationArr;
@property(nonatomic, strong) Verification *verfication;

@property(nonatomic, strong) UIBarButtonItem *rightItem;

@end

@implementation VerificationTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableData = @[@"手机号", @"密码", @"验证码", @"真实姓名", @"身份证号", @"昵称", @"年龄", @"地址", @"联系电话"];
    self.verfication = [[Verification alloc] init];
    self.verficationArr = [NSMutableArray array];
    [self setupTableView];
    self.rightItem = [[UIBarButtonItem alloc] initWithTitle:@"全部验证通过" style:UIBarButtonItemStylePlain target:self action:@selector(pressRightItem:)];
    [self.rightItem setEnabled:NO];
    self.navigationItem.rightBarButtonItem = self.rightItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tableData.count;
}

static NSString *InputCellIdentifier = @"InputCellIdentifier";
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TitleInputTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:InputCellIdentifier forIndexPath:indexPath];
    NSString *title = [self.tableData objectAtIndex:indexPath.row];
    cell.titleLabel.text = title;
    UITextField *textField = cell.textField;
    [self.verfication verificationWith:^(Verification *verification) {
        if ([title isEqualToString:@"手机号"]) {
            textField.keyboardType = UIKeyboardTypePhonePad;
            verification.textField(textField).name(title).regex(kRegexPhone).max(11).null();
        }else if([title isEqualToString:@"密码"]){
            verification.textField(textField).name(title).regex(kRegexPassword).max(16).null();
        }else if([title isEqualToString:@"验证码"]){
            textField.keyboardType = UIKeyboardTypePhonePad;
            verification.textField(textField).name(title).regex(kRegexCode).max(6).null();
        }else if([title isEqualToString:@"真实姓名"]){
            verification.textField(textField).name(title).regex(kRegexName).max(20).null();
        }else if([title isEqualToString:@"身份证号"]){
            verification.textField(textField).name(title).regex(kRegexIDCard).max(18).null();
        }else if([title isEqualToString:@"昵称"]){
            verification.textField(textField).name(title).regex(kRegexNickname).max(15).null();
        }else if([title isEqualToString:@"年龄"]){
            verification.textField(textField).name(title).regex(kRegexAge).max(3).null();
        }else if([title isEqualToString:@"地址"]){
            verification.textField(textField).name(title).regex(kRegexAddress).max(30).null();
        }else if([title isEqualToString:@"联系电话"]){
            verification.textField(textField).name(title).regex(kRegexTelephone).max(20).null();
        }
    } complateBlock:^(VerificationModel *model) {
        if (model.isValid) {
            if (![self.verficationArr containsObject:model]) {
                [self.verficationArr addObject:model];
                DebugLog(@"%@通过验证", model.name);
            }
        }else{
            if ([self.verficationArr containsObject:model]) {
                [self.verficationArr removeObject:model];
                DebugLog(@"%@验证失败", model.name);
            }
        }
        [self verified:self.verficationArr];
    }];
    return cell;
}

#pragma mark - Action
-(void)pressRightItem:(UIBarButtonItem*)item{
    [[ToastManager sharedInstance] showMessage:@"验证通过"];
}

#pragma mark - Public

-(void)verified:(NSMutableArray*)arr{
    if (arr.count == 9) {
        [self.rightItem setEnabled:YES];
    }else{
        [self.rightItem setEnabled:NO];
    }
}

-(void)setupTableView{
    self.tableView.rowHeight = 48.f;
    self.tableView.estimatedRowHeight = 48.f;
    [self.tableView registerNib:[UINib nibWithNibName:@"TitleInputTableViewCell" bundle:nil] forCellReuseIdentifier:InputCellIdentifier];
}
@end
