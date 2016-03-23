//
//  Arith.h
//  YingbaFinance
//
//  Created by jingshuihuang on 16/3/8.
//  Copyright © 2016年 huoqiangshou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Arith : NSObject
+ (NSString *)calculateInterestWithAmount:(double)amount apr:(double)apr unit:(int)unit period:(int)period repayment:(int)repayment;
+ (NSString *) decimalwithFormat:(NSString *)format  floatV:(float)floatV;
@end
