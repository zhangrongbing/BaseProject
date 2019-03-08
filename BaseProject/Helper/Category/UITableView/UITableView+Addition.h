//
//  UITableView+Addition.h
//  BaseProject
//
//  Created by 张熔冰 on 2019/2/13.
//  Copyright © 2019年 Lovcreate. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITableView (Addition)

-(void)registClass:(UITableView*)tableView cell:(Class) cell;
-(void)registClassForCell:(Class) cell;

-(UITableViewCell*)getCellForTableView:(UITableView*)tableView withClass:(Class)class indexPath:(NSIndexPath*)indexPath;
-(UITableViewCell*)getCellWithClass:(Class)class indexPath:(NSIndexPath*)indexPath;
@end

NS_ASSUME_NONNULL_END
