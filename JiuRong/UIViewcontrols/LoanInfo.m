//
//  LoanInfo.m
//  YingbaFinance
//
//  Created by jingshuihuang on 16/3/17.
//  Copyright © 2016年 huoqiangshou. All rights reserved.
//

#import "LoanInfo.h"

@implementation LoanInfo
+ (LoanInfo *)creatLoanInfoWith:(NSDictionary *)dic
{
    LoanInfo * loanInfo = [[LoanInfo alloc]init];
    [loanInfo setValuesForKeysWithDictionary:dic];
    return loanInfo;
}
- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"id"]) {
        self.ID = value;
    }
}
@end
