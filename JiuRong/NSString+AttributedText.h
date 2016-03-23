//
//  NSString+AttributedText.h
//  YingbaFinance
//
//  Created by jingshuihuang on 16/3/9.
//  Copyright © 2016年 huoqiangshou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (AttributedText)

+ (NSMutableAttributedString *)QstringWith:(UIColor *)color Font:(UIFont *)font range:(NSRange)range originalString:(NSString *)str;
+ (NSString *)trimWhiteSpace:(NSString *)str;


@end
