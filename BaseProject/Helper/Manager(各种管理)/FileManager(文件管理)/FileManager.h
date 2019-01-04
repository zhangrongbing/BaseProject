//
//  FileManager.h
//  BaseProject
//
//  Created by 张熔冰 on 2018/8/2.
//  Copyright © 2018年 Lovcreate. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSObject+Single.h"

@interface FileManager : NSObject

LC_SINGLE_H(FileManager);

- (long long) fileSizeAtPath:(NSString*) filePath;//单个文件大小
- (float ) folderSizeAtPath:(NSString*) folderPath;//文件夹大小

-(float)sizeOfCaches;
-(BOOL)removeCaches;

@end
