//
//  FileManager.m
//  BaseProject
//
//  Created by 张熔冰 on 2018/8/2.
//  Copyright © 2018年 Lovcreate. All rights reserved.
//

#import "FileManager.h"

@implementation FileManager

SINGLE_M(FileManager);

-(instancetype)init{
    if (self = [super init]) {
        
    }
    return self;
}

- (long long) fileSizeAtPath:(NSString*) filePath{
    NSFileManager* manager = [NSFileManager defaultManager];
    if ([manager fileExistsAtPath:filePath]){
        return [[manager attributesOfItemAtPath:filePath error:nil] fileSize];
    }
    return 0;
}
- (float) folderSizeAtPath:(NSString*) folderPath{
    NSFileManager* manager = [NSFileManager defaultManager];
    if (![manager fileExistsAtPath:folderPath]) return 0;
    NSEnumerator *childFilesEnumerator = [[manager subpathsAtPath:folderPath] objectEnumerator];
    NSString* fileName;
    long long folderSize = 0;
    while ((fileName = [childFilesEnumerator nextObject]) != nil){
        NSString* fileAbsolutePath = [folderPath stringByAppendingPathComponent:fileName];
        folderSize += [self fileSizeAtPath:fileAbsolutePath];
    }
    return folderSize/(1024.0*1024.0);
}
//缓存目录的大小
-(float)sizeOfCaches{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *cachePath = [paths lastObject];
    return [self folderSizeAtPath:cachePath];
}
-(BOOL)removeCaches{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *cachePath = [paths lastObject];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if([fileManager fileExistsAtPath:cachePath isDirectory:nil]){
        [fileManager removeItemAtPath:cachePath error:nil];
    }
    return YES;
}
@end
