//
//  UITextField+Limit.m
//  BaseProject
//
//  Created by 张熔冰 on 2018/3/11.
//  Copyright © 2018年 lovcreate. All rights reserved.
//

#import "UITextField+Money.h"

@implementation UITextField (Money)

-(void)_money{
    self.keyboardType = UIKeyboardTypeDecimalPad;
    self.delegate = self;
}

#pragma mark - UITextFieldDelegate
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if ([string isEqualToString:@""]) {
        return YES;
    }
    NSCharacterSet *cs;
    NSUInteger nDotLoc = [textField.text rangeOfString:@"."].location;
    if (NSNotFound == nDotLoc && 0 != range.location) {
        cs = [[NSCharacterSet characterSetWithCharactersInString:@"0123456789."] invertedSet];
    }else{
        cs = [[NSCharacterSet characterSetWithCharactersInString:@"0123456789"] invertedSet];
    }
    NSArray* array = [string componentsSeparatedByCharactersInSet:cs];
    NSString *filtered = [array componentsJoinedByString:@""];
    BOOL basicTest = [string isEqualToString:filtered];
    
    if (!basicTest) {
        return NO;
    }
    if (nDotLoc != NSNotFound && range.location > nDotLoc + 2) {
        return NO;
    }
    if (textField.text.length > 11) {
        return NO;
    }
    return YES;
}
@end
