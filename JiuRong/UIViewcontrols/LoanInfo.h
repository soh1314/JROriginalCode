//
//  LoanInfo.h
//  YingbaFinance
//
//  Created by jingshuihuang on 16/3/17.
//  Copyright © 2016年 huoqiangshou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"
@interface LoanInfo : JSONModel
@property (nonatomic,copy)NSString *accessChannel;
@property (nonatomic,copy)NSString *address;
@property (nonatomic,copy)NSString *auditItemId;

@property (nonatomic,retain)NSString *card_no;
@property (nonatomic,copy)NSString *className;
@property (nonatomic,copy)NSString *depart;

@property (nonatomic,copy)NSString *education;
@property (nonatomic,copy)NSString *fAddress;
@property (nonatomic,copy)NSString *fName;

@property (nonatomic,copy)NSString *fPhone;
@property (nonatomic,copy)NSString *fQQNo;
@property (nonatomic,copy)NSString *fWorkName;

@property (nonatomic,copy)NSString *fWxNo;
@property (nonatomic,copy)NSString *ID;//
@property (nonatomic,copy)NSString *instructor;

@property (nonatomic,copy)NSString *instructorPhone;
@property (nonatomic,copy)NSString *mAddress;
@property (nonatomic,copy)NSString *mName;

@property (nonatomic,copy)NSString *mPhone;
@property (nonatomic,copy)NSString *mQQNo;
@property (nonatomic,copy)NSString *mWorkName;

@property (nonatomic,copy)NSString *mWxNo;
@property (nonatomic,copy)NSString *mobile_password;
@property (nonatomic,copy)NSString *no;

@property (nonatomic,copy)NSString *professional;
@property (nonatomic,copy)NSString *qqNo;
@property (nonatomic,copy)NSString *school;

@property (nonatomic,copy)NSString *schoolNetUserNo;
@property (nonatomic,copy)NSString *schoolNetUserPwd;
@property (nonatomic,copy)NSString *schoolWWW;

@property (nonatomic,copy)NSString *userId;
@property (nonatomic,copy)NSString *wxNo;
@property (nonatomic,copy)NSString *xxUserNo;

@property (nonatomic,copy)NSString *xxUserPwd;

@property (nonatomic,copy)NSString * grade;
+ (LoanInfo *)creatLoanInfoWith:(NSDictionary *)dic;

@end
