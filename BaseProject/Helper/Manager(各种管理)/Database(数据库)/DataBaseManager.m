//
//  DataBaseManager.m
//  Bear
//
//  Created by 张熔冰 on 2018/1/15.
//  Copyright © 2018年 lovcreate. All rights reserved.
//

#import "DataBaseManager.h"
#import "FMDB.h"
#import "Client.h"

@interface DataBaseManager()

@property(nonatomic, strong)FMDatabase *db;

@end

@implementation DataBaseManager

SINGLE_M(DataBaseManager);

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
    NSString* sql = @"\
    CREATE TABLE SearchHistory (id integer primary key autoincrement,userId text, keywords text, lastDatetime datetime);\
    CREATE TABLE Location (id integer primary key autoincrement,lat number, lng number, time datetime, type number, line text);";
    if (![self.db open]) {
        DebugLog(@"数据库打开失败error:  %@",[self.db lastErrorMessage]);
    }
    BOOL success = [self.db executeStatements:sql];
    if (success) {
        DebugLog(@"试卷数据库创建成功");
    }
    [self.db close];
}

-(void)addLat:(double) lat lng:(double)lng network:(BOOL)network line:(NSString*)line{
    if (![self.db open]) {
        DebugLog(@"数据库打开失败error:  %@",[self.db lastErrorMessage]);
        return;
    }
    NSString *sql = @"INSERT INTO Location (lat, lng, time, type, line) VALUES (:lat, :lng , :time, :type, :line)";
    NSDictionary *arguments = @{@"lat": [NSNumber numberWithFloat:lat], @"lng": [NSNumber numberWithFloat:lng], @"time": [NSDate new], @"type": [NSNumber numberWithInteger:network], @"line": line};
    BOOL success = [self.db executeUpdate:sql withParameterDictionary:arguments];
    if (!success) {
        DebugLog(@"%s:数据插入失败", __FUNCTION__);
    }
    [self.db close];
}

-(NSArray*)getAnns{
    if (![self.db open]) {
        DebugLog(@"数据库打开失败error:  %@",[self.db lastErrorMessage]);
        return @[];
    }
    NSString *sql = @"SELECT lat, lng, time, type, line FROM Location ORDER BY time DESC";
    FMResultSet *set = [self.db executeQuery:sql];
    NSMutableArray *resultArr = [NSMutableArray array];
    while ([set next]) {
        NSString *lat = [set objectForColumn:@"lat"];
        NSString *lng = [set objectForColumn:@"lng"];
        NSString *time = [set stringForColumn:@"time"];
        NSString *type = [set stringForColumn:@"type"];
        NSString *line = [set stringForColumn:@"line"];
        NSDictionary *resultData = @{@"lat": lat, @"lng": lng, @"time": time, @"type":type, @"line": line};
        [resultArr addObject:resultData];
    }
    return resultArr;
}
-(void)clearAnn{
    if (![self.db open]) {
        DebugLog(@"数据库打开失败error:  %@",[self.db lastErrorMessage]);
    }
    NSString *sql = @"DELETE FROM Location";
    BOOL success = [self.db executeUpdate:sql];
    if (!success) {
        DebugLog(@"%s:清空定位表失败", __FUNCTION__);
    }
    [self.db close];
}
-(void)insertHistoryKeywords:(NSString*)keywords{
    NSAssert(keywords, @"keywords is not nil");
    [self insertHistoryKeywords:keywords userId:[Client sharedInstance].userModel.userId];
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
    NSString *userId = [Client sharedInstance].userModel.userId;
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
