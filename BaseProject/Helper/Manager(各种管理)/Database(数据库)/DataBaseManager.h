//
//  DataBaseManager.h
//  Bear
//
//  Created by 张熔冰 on 2018/1/15.
//  Copyright © 2018年 lovcreate. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSObject+Single.h"

@interface DataBaseManager : NSObject

LC_SINGLE_H(DataBaseManager);

//插入历史记录相关
-(void)insertHistoryKeywords:(NSString*)keywords;
-(void)insertHistoryKeywords:(NSString*)keywords userId:(NSString*) userId;
//搜索历史记录
-(NSMutableArray*)queryHistoryKeywords;
//删除历史记录
-(void)removeHistoryForCurrentUser;
-(void)removeHistoryForUserId:(NSString*)userId;


@end
