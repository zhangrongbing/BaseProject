//
//  SteamingMediaController.m
//  BaseProject
//
//  Created by 张熔冰 on 2018/10/24.
//  Copyright © 2018年 Lovcreate. All rights reserved.
//

#import "SteamingMediaController.h"
#import "SoundViewController.h"

#define kCellIdentifier @"Cell"
@interface SteamingMediaController ()

@property(nonatomic, strong) NSArray *tableData;

@end

@implementation SteamingMediaController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kCellIdentifier];
    self.tableData = @[@"音效"];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tableData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier forIndexPath:indexPath];
    NSString *str = [self.tableData objectAtIndex:indexPath.row];
    cell.textLabel.text = str;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSString *str = [self.tableData objectAtIndex:indexPath.row];
    if ([str isEqualToString:@"音效"]) {
        SoundViewController *controller = [[SoundViewController alloc] init];
        controller.title = str;
        [self.navigationController pushViewController:controller animated:YES];
    }
}
@end
