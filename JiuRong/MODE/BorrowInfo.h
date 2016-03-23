//
//  BorrowInfo.h
//  JiuRong
//
//  Created by iMac on 15/9/6.
//  Copyright (c) 2015年 huoqiangshou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MoneyInfo : NSObject

@property (nonatomic, retain) NSString *name;
@property (nonatomic, assign) NSInteger amount;
@property (nonatomic, retain) NSString *time;
@property (nonatomic, assign) NSInteger status;

@end

@interface BorrowInfo : NSObject

@property (nonatomic, assign) NSInteger ID;
@property (nonatomic, retain) NSString *text;
@property (nonatomic, assign) NSInteger type;
@property (nonatomic, assign) CGFloat rate;
@property (nonatomic, assign) NSInteger limit;

@property (nonatomic, copy) NSString *Klimit;
@property (nonatomic, assign) NSInteger amount;
@property (nonatomic, assign) CGFloat progress;
@property (nonatomic, retain) NSString *productImage;
@property (nonatomic, assign) NSInteger status;
@property (nonatomic, assign) NSInteger limitunit;
//
@property (nonatomic, copy) NSString * borrowerheadImg;
@property (nonatomic,copy)NSString * KAmount;
@property (nonatomic, retain) NSString *no;
@property (nonatomic, assign) NSInteger paymentMode;
@property (nonatomic, assign) NSInteger schedules;
@property (nonatomic, assign) NSInteger creditScore;
@property (nonatomic, assign) NSInteger creditLevel;
@property (nonatomic, retain) NSString *realityName;
@property (nonatomic,retain) NSString *sex;
@property (nonatomic, assign) NSInteger age;
@property (nonatomic, retain) NSString *idNumber;
@property (nonatomic, retain) NSString *familyAddress;
@property (nonatomic, retain) NSString *educationName;
@property (nonatomic, retain) NSString *maritalName;
@property (nonatomic, retain) NSString *houseName;
@property (nonatomic, retain) NSString *carName;
@property (nonatomic, retain) NSString *purpose;
@property (nonatomic, retain) NSString *borrowDetails;
@property (nonatomic, retain) NSString *auditSuggest;
@property (nonatomic, assign) NSInteger borrowSuccessNum;
@property (nonatomic, assign) NSInteger borrowFailureNum;
@property (nonatomic, assign) NSInteger repaymentNormalNum;
@property (nonatomic, assign) NSInteger repaymentOverdueNum;
@property (nonatomic, retain) NSString *registrationTime;
@property (nonatomic, assign) NSInteger borrowingAmount;
@property (nonatomic,copy)NSString *  KborrowingAmount;

@property (nonatomic, assign) NSInteger financialBidNum;
@property (nonatomic, assign) NSInteger paymentAmount;
@property (nonatomic, copy) NSString * KpaymentAmount;

@property (nonatomic, assign) NSInteger reimbursementAmount;
@property (nonatomic, copy)NSString * KreimbursementAmount;

@property (nonatomic, assign) NSInteger minTenderedSum;
@property (nonatomic ,retain) NSString *investExpireTime;
@property (nonatomic ,assign) NSInteger hasinvestedamount;

@property (nonatomic, assign) NSInteger isbest;
@property (nonatomic, copy) NSString * creditRating;
@property (nonatomic, retain) NSMutableArray *moneys;
@end
