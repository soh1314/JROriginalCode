//
//  Arith.m
//  YingbaFinance
//
//  Created by jingshuihuang on 16/3/8.
//  Copyright © 2016年 huoqiangshou. All rights reserved.
//

#import "Arith.h"

@implementation Arith
+ (NSString *)calculateInterestWithAmount:(double)amount apr:(double)apr unit:(int)unit period:(int)period repayment:(int)repayment
{
    double interest = 0.0;
    if (0 == amount ||
        apr < 0 ||
        apr > 100 ||
        0 == period ||
        repayment < 1 ||
        repayment > 4 ||
        unit < -1 ||
        unit > 1) {
        return [NSString stringWithFormat:@"%.2lf",interest];
    }
    double monthRate = (apr * 0.01)/12.0;
    if (unit == 1) {
        
        interest = amount*monthRate*period/30; //四舍五入取小数两位
        NSString * interestsTR = [self decimalwithFormat:@"0.00" floatV:interest];
        interest = [interestsTR doubleValue];
    }
    else
    {
        if (unit == -1) {
            period *= 12;
        }
        if (repayment == 1) {
            double monPay = amount*monthRate*pow((1+monthRate), period)/(pow((1+monthRate), period)-1);
            interest = monPay*period-amount;
            
        }
        else
        {
            interest = amount*monthRate*period;//四舍五入取小数两位
             NSString * interestsTR = [self decimalwithFormat:@"0.00" floatV:interest];
            interest = [interestsTR doubleValue];
        }
    }
    /*
     if(0 == amount ||
     apr < 0 ||
     apr > 100 ||
     0 == period ||
     repayment < 1 ||
     repayment > 4 ||
     unit < -1 ||
     unit > 1)
     return 0;
     
     double monthRate = Double.valueOf(apr * 0.01)/12.0;//通过年利率得到月利率
     double interest = 0;
     
     if(unit == Constants.DAY){//秒还还款和天标的总利息
     interest = Arith.div(Arith.mul(Arith.mul(amount, monthRate), period), 30, 2);//天标的总利息
     
     }else{
     if(unit == Constants.YEAR){
     period = period * 12;
     
     }
     
     //等额本息还款（否则一次还款或先息后本）
     if(repayment == Constants.PAID_MONTH_EQUAL_PRINCIPAL_INTEREST){
     double monPay = Double.valueOf(Arith.mul(amount, monthRate) * Math.pow((1 + monthRate), period))/
     Double.valueOf(Math.pow((1 + monthRate), period) - 1);//每个月要还的本金和利息
     interest = Arith.sub(Arith.mul(monPay, period), amount);
     
     }else{  // 1、按月付息，到期还本      2、按月还款，等本等息        3、一次性还款
     interest = Arith.round(Arith.mul(Arith.mul(amount, monthRate), period), 2);
     
     }
     }
     
     return Arith.round(interest, 2);
     
     
     
     */
    
    
  return [NSString stringWithFormat:@"%.2lf",interest]; ;
}
+ (NSString *) decimalwithFormat:(NSString *)format  floatV:(float)floatV
{
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    
    [numberFormatter setPositiveFormat:format];
    
    return  [numberFormatter stringFromNumber:[NSNumber numberWithFloat:floatV]];
}

@end
