//
//  NSString+AttributedText.m
//  YingbaFinance
//
//  Created by jingshuihuang on 16/3/9.
//  Copyright © 2016年 huoqiangshou. All rights reserved.
//

#import "NSString+AttributedText.h"
#import "Constant.h"
@implementation NSString (AttributedText)
+ (NSMutableAttributedString *)QstringWith:(UIColor *)color Font:(UIFont *)font range:(NSRange)range originalString:(NSString *)str
{
    NSMutableAttributedString * str_m = [[NSMutableAttributedString alloc]initWithString:str attributes:@{NSForegroundColorAttributeName:color,NSFontAttributeName:KLanTinFont}];
   
    [str_m addAttributes:@{NSForegroundColorAttributeName:[UIColor blueColor]} range:range];
    //样式、大小 设置
    return str_m;
}
@end
