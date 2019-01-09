//
//  LanguageManager.h
//  BaseProject
//
//  Created by 张熔冰 on 2018/6/24.
//  Copyright © 2018年 Lovcreate. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSObject+Single.h"

#define LCGetStringWithKeyFromTable(key, tbl) [[LanguageManager sharedInstance] getStringForKey:key withTable:tbl]

@class LanguageManager;

@protocol LanguageManagerDelegate <NSObject>

-(void)languageManager:(LanguageManager *)manager didChangedLanguage:(BOOL) success;

@end

@interface LanguageManager : NSObject

SINGLE_H(LanguageManager);

@property(nonatomic, strong) NSString *language;//当前语言

@property(nonatomic, strong) id<LanguageManagerDelegate> delegate;

/**
 获取国际化文字

 @param key 国际化语言的key值
 @param table 国际化语言的文件名称
 @return 国际化语言
 */
-(NSString*) getStringForKey:(NSString *)key withTable:(NSString *) table;


/**
 更换语言
 */
-(void)changeLanguage;


/**
 设置语言

 @param language 语言
 */
-(void)setLocalizedLanguage:(NSString *)language;
@end
