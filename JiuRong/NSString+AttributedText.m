//
//  NSString+AttributedText.m
//  YingbaFinance
//
//  Created by jingshuihuang on 16/3/9.
//  Copyright © 2016年 huoqiangshou. All rights reserved.
//

#import "NSString+AttributedText.h"

@implementation NSString (AttributedText)
+ (NSMutableAttributedString *)QstringWith:(UIColor *)color Font:(UIFont *)font range:(NSRange)range originalString:(NSString *)str
{
    NSMutableAttributedString * str_m = [[NSMutableAttributedString alloc]initWithString:str attributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont fontWithName:@"FZLanTingHeiS-R-GB" size:20]}];
    [str_m addAttributes:@{NSForegroundColorAttributeName:color,NSFontAttributeName:[UIFont fontWithName:@"FZLanTingHeiS-R-GB" size:20]} range:range];
    return str_m;
}
+ (NSString *)trimWhiteSpace:(NSString *)str
{
    return [str  stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
}

- (BOOL)isEmpty
{
    if (self == nil) {
        return YES;
    }
    else
    {
        return NO;
    }
}
- (BOOL)isAllwhiteSpace
{
    if ([[self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]  length]==0) {
        return YES;
    }
    else
    {
        return NO;
    }
}

@end
