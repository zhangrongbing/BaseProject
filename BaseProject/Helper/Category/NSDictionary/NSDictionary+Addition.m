
#import "NSDictionary+Addition.h"
#import "MyConfig.h"

@implementation NSDictionary (Addition)

//打log用改的。
-(NSString *)descriptionWithLocale:(id)locale{
    NSMutableString *msr = [NSMutableString string];
    [msr appendString:@"{"];
    [self enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        if ([obj isKindOfClass:[NSString class]]) {
            [msr appendFormat:@"\n\t\"%@\" : \"%@\",",key,obj];
        }else if([obj isKindOfClass:[NSNull class]]){
            [msr appendFormat:@"\n\t\"%@\" : \"\",",key];
        }else{
            [msr appendFormat:@"\n\t\"%@\" : %@,",key,obj];
        }
        
    }];
    //去掉最后一个逗号（,）
    if ([msr hasSuffix:@","]) {
        NSString *str = [msr substringToIndex:msr.length - 1];
        msr = [NSMutableString stringWithString:str];
    }
    [msr appendString:@"\n}"];
    return msr;
}

-(NSDictionary*)lc_dictionaryWithString:(NSString*)string{
    NSError* error = nil;
    id dic = [NSJSONSerialization JSONObjectWithData:[string dataUsingEncoding:NSUTF8StringEncoding] options:0 error:&error];
    NSAssert(error, @"lc_dictionaryWithString-string error");
    return dic;
}


-(NSString*)lc_toJson{
    NSError* error = nil;
    
    NSData* jsonData = [NSJSONSerialization dataWithJSONObject:self options:NSJSONWritingPrettyPrinted error:&error];
    NSString* jsonString = @"";
    
    if (!jsonData) {
        DebugLog(@"Got an error: %@", error);
    }else{
        jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    jsonString = [jsonString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];  //去除掉首尾的空白字符和换行字符
    
    jsonString = [jsonString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    
    return jsonString;
}

@end

