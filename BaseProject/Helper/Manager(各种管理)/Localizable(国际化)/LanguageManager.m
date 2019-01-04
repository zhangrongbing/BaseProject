//
//  LanguageManager.m
//  BaseProject
//
//  Created by 张熔冰 on 2018/6/24.
//  Copyright © 2018年 Lovcreate. All rights reserved.
//

#import "LanguageManager.h"
#import "Constant.h"

@interface LanguageManager()

@property(nonatomic, strong) NSBundle *bundle;

@end

@implementation LanguageManager

LC_SINGLE_M(LanguageManager);

-(instancetype)init{
    if (self = [super init]) {
        [self setup];
    }
    return self;
}

-(void)setup{
    //是否设置了语言
    NSString *curLanguage = [[NSUserDefaults standardUserDefaults] objectForKey:Localizable_Name];
    if (curLanguage) {
        self.language = curLanguage;
    }else{
        //支持语言列表
        NSArray *languageArr = [[NSUserDefaults standardUserDefaults] arrayForKey:@"AppleLanguages"];
        //当前语言
        NSString *curLanguage = [languageArr firstObject];
        self.language = [curLanguage hasPrefix:Localizable_zh_Hans]?curLanguage:Localizable_en;
    }
    //语言文件路径
    NSString *path = [[NSBundle mainBundle] pathForResource:self.language ofType:@"lproj"];
    self.bundle = [NSBundle bundleWithPath:path];
}

#pragma mark - Public
-(NSString*) getStringForKey:(NSString *)key withTable:(NSString *) table{
    if (self.bundle) {
        NSString *tampTable = table ? table : @"Localizable";
        return NSLocalizedStringFromTableInBundle(key, tampTable, self.bundle, @"");
    }
    return NSLocalizedStringFromTable(key, table, @"");
}

-(void)changeLanguage{
    if ([self.language isEqualToString:Localizable_en]) {
        [self setLocalizedLanguage:Localizable_zh_Hans];
    }else{
        [self setLocalizedLanguage:Localizable_en];
    }
}

-(void)setLocalizedLanguage:(NSString *)language{
    if ([language isEqualToString:self.language]) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(languageManager:didChangedLanguage:)]) {
            [self.delegate languageManager:self didChangedLanguage:NO];
        }
        return;
    }
    NSString *path = [[NSBundle mainBundle] pathForResource:language ofType:@"lproj"];
    self.bundle = [NSBundle bundleWithPath:path];
    self.language = language;
    [[NSUserDefaults standardUserDefaults] setObject:language forKey:Localizable_Name];
    [[NSUserDefaults standardUserDefaults] synchronize];
    if (self.delegate && [self.delegate respondsToSelector:@selector(languageManager:didChangedLanguage:)]) {
        [self.delegate languageManager:self didChangedLanguage:YES];
    }
}
@end
