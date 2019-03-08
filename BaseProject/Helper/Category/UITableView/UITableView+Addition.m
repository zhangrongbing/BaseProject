//
//  UITableView+Addition.m
//  BaseProject
//
//  Created by 张熔冰 on 2019/2/13.
//  Copyright © 2019年 Lovcreate. All rights reserved.
//

#import "UITableView+Addition.h"

@implementation UITableView (Addition)

-(void)registClass:(UITableView*)tableView cell:(Class) cell{
    [tableView registerClass:cell forCellReuseIdentifier:NSStringFromClass(cell)];
}

-(void)registClassForCell:(Class) cell{
    [self registerClass:cell forCellReuseIdentifier:NSStringFromClass(cell)];
}

-(UITableViewCell*)getCellForTableView:(UITableView*)tableView withClass:(Class)class indexPath:(NSIndexPath*)indexPath{
    return [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(class) forIndexPath:indexPath];
}
-(UITableViewCell*)getCellWithClass:(Class)class indexPath:(NSIndexPath*)indexPath{
    return [self dequeueReusableCellWithIdentifier:NSStringFromClass(class) forIndexPath:indexPath];
}
@end
