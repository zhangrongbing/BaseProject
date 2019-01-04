//
//  AddressPickerController.m
//  BaseProject
//
//  Created by 张熔冰 on 2018/8/24.
//  Copyright © 2018年 Lovcreate. All rights reserved.
//

#import "CityPickerController.h"
#import "LCDictionary.h"
#import "SelectAddressTableViewCell.h"
#import "UIColor+Addition.h"
#import "SelectAddressHeaderView.h"
#import "MBProgressHUD.h"
#import "SelectAddressModel.h"

@interface CityPickerController ()

@property(nonatomic, strong) LCDictionary *tableData;
@property(nonatomic, strong) SelectAddressHeaderView *headerView;
@property(nonatomic, strong) NSArray *sortedKeys;
@end

@implementation CityPickerController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableData = [[LCDictionary alloc] init];
    [self createTitleView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)dealloc{
    DebugLog(@"");
}
#pragma mark - UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.sortedKeys.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSArray *keys = self.sortedKeys;
    NSString *key = [keys objectAtIndex:section];
    NSArray *values = [self.tableData objectForKey:key];
    return values.count;
}

static NSString *LocalAddressCellIdentifier = @"LocalAddressCellIdentifier";
static NSString *HotAddressCellIdentifier = @"HotAddressCellIdentifier";
static NSString *AddressCellIdentifier = @"AddressCellIdentifier";
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSArray *allKeys = self.sortedKeys;
    NSString *key = [allKeys objectAtIndex:indexPath.section];
    NSArray *values = [self.tableData objectForKey:key];
    SelectAddressModel *model = [values objectAtIndex:indexPath.row];
    SelectAddressTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:AddressCellIdentifier forIndexPath:indexPath];
    cell.cityName = model.name;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 28.f;
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UILabel *label = [UILabel new];
    label.backgroundColor = RGB(0xF3F3F3);
    NSArray *keys = self.sortedKeys;
    NSString *key = [keys objectAtIndex:section];
    label.text = [NSString stringWithFormat:@"\t\t\t\t%@",key];
    return label;
}

-(NSArray<NSString*>*)sectionIndexTitlesForTableView:(UITableView *)tableView{
    self.tableView.sectionIndexBackgroundColor = [UIColor clearColor];
    return self.sortedKeys;
}

#pragma mark - UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    [self.navigationController popViewControllerAnimated:YES];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44.f;
}

#pragma mark - Public
-(void)createTitleView{
    NSString *localAddressCellName = @"SelectLocalAddressTableViewCell";
    [self.tableView registerNib:[UINib nibWithNibName:localAddressCellName bundle:nil] forCellReuseIdentifier:LocalAddressCellIdentifier];
    
    NSString *hotAddressCellName = @"SelectHotAddressTableViewCell";
    [self.tableView registerNib:[UINib nibWithNibName:hotAddressCellName bundle:nil] forCellReuseIdentifier:HotAddressCellIdentifier];
    
    UINib *addressNib = [UINib nibWithNibName:@"SelectAddressTableViewCell" bundle:nil];
    [self.tableView registerNib:addressNib forCellReuseIdentifier:AddressCellIdentifier];
    
    self.headerView = [SelectAddressHeaderView viewForFrame:CGRectMake(0, 0, kScreenWidth, 150.f) handler:^(NSInteger index) {
        
    }];
    [self.tableView setTableHeaderView:self.headerView];
    //获取本地数据 数据量较大， 用线程获取
    [MBProgressHUD showHUDAddedTo:self.tableView animated:YES];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"Citys" ofType:@"json"];
        NSData *jsonData = [NSData dataWithContentsOfFile:filePath];
        NSArray *jsonArr = [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions|NSJSONWritingPrettyPrinted error:nil];
        NSArray *addressModelArr = [SelectAddressModel mj_objectArrayWithKeyValuesArray:jsonArr];
        [addressModelArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            SelectAddressModel *model = obj;
            NSString *key = [model.pinyin substringToIndex:1];
            [self.tableData addObjectForKey:key value:model];
            NSArray *unorderedKeys = [self.tableData allKeys];
            self.sortedKeys = [unorderedKeys sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
                NSString *o1 = (NSString*)obj1;
                NSString *o2 = (NSString*)obj2;
                return [o1 compare:o2];
            }];
        }];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
            [MBProgressHUD hideHUDForView:self.tableView animated:YES];
        });
    });
}
@end
