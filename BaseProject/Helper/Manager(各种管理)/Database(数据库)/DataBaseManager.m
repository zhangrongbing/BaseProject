//
//  DataBaseManager.m
//  Bear
//
//  Created by 张熔冰 on 2018/1/15.
//  Copyright © 2018年 lovcreate. All rights reserved.
//

#import "DataBaseManager.h"
#import "FMDB.h"
#import "MyConfig.h"

@interface DataBaseManager()

@property(nonatomic, strong)FMDatabase *db;

@end

@implementation DataBaseManager

LC_SINGLE_M(DataBaseManager);

-(instancetype)init{
    if (self = [super init]) {
        NSString *documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
        NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
        NSString *executableFile = [infoDictionary objectForKey:(NSString *)kCFBundleExecutableKey];
        NSString *filePath = [documentsPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.sqlite",executableFile]];
        self.db = [FMDatabase databaseWithPath:filePath];
        [self createTable];
    }
    return self;
}

//创建表
-(void)createTable{
    NSString* sql = @"CREATE TABLE SearchHistory (id integer primary key autoincrement,userId text, keywords text, lastDatetime datetime);";
    if (![self.db open]) {
        DebugLog(@"数据库打开失败error:  %@",[self.db lastErrorMessage]);
    }
    BOOL success = [self.db executeStatements:sql];
    if (success) {
        DebugLog(@"试卷数据库创建成功");
    }
    [self.db close];
}

-(void)insertHistoryKeywords:(NSString*)keywords{
    NSAssert(keywords, @"keywords is not nil");
    [self insertHistoryKeywords:keywords userId:[MyConfig sharedInstance].user.userId];
}

-(void)insertHistoryKeywords:(NSString*)keywords userId:(NSString*) userId{
    if (![self.db open]) {
        DebugLog(@"数据库打开失败error:  %@",[self.db lastErrorMessage]);
        return;
    }
    NSString *sql = @"INSERT INTO SearchHistory (userId, keywords, lastDatetime) VALUES (:userId, :keywords, :lastDatetime)";
    NSDictionary *arguments = @{@"userId":userId, @"keywords":keywords, @"lastDatetime": [NSDate new]};
    BOOL success = [self.db executeUpdate:sql withParameterDictionary:arguments];
    if (!success) {
        DebugLog(@"%s:数据插入失败", __FUNCTION__);
    }
    [self.db close];
}

-(NSMutableArray*)queryHistoryKeywords{
    if (![self.db open]) {
        DebugLog(@"数据库打开失败error:  %@",[self.db lastErrorMessage]);
        return nil;
    }
    NSString *sql = @"SELECT keywords FROM SearchHistory GROUP BY keywords ORDER BY lastDatetime DESC";
    FMResultSet * set = [self.db executeQuery:sql];
    NSMutableArray *resultArr = [NSMutableArray array];
    while ([set next]) {
        [resultArr addObject:[set stringForColumn:@"keywords"]];
    }
    [self.db close];
    return resultArr;
}

-(void)removeHistoryForCurrentUser{
    NSString *userId = [MyConfig sharedInstance].user.userId;
    [self removeHistoryForUserId:userId];
}

-(void)removeHistoryForUserId:(NSString*)userId{
    NSAssert(userId, @"userId is not nil");
    if (![self.db open]) {
        DebugLog(@"数据库打开失败error:  %@",[self.db lastErrorMessage]);
        return;
    }
    NSDictionary *sqlDic = @{@"userId":userId};
    NSString *sql = @"DELETE FROM SearchHistory WHERE userId = :userId";
    BOOL success = [self.db executeUpdate:sql withParameterDictionary:sqlDic];
    if (!success) {
        DebugLog(@"删除历史记录失败 %s:%@", __FUNCTION__, userId);
        return;
    }
    [self.db close];
}
//示例方法
-(void)Method{
    if (![self.db open]) {
        DebugLog(@"数据库打开失败error:  %@",[self.db lastErrorMessage]);
        return;
    }
    
    [self.db close];
}
@end
