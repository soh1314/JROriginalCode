//
//  UserInfo.h
//  JiuRong
//
//  Created by iMac on 15/9/2.
//  Copyright (c) 2015年 huoqiangshou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CertifyInfo : NSObject

@property (nonatomic, assign) NSInteger namestatus;
@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *idcard;

@property (nonatomic, assign) NSInteger emailstatus;
@property (nonatomic ,retain) NSString* email;

@property (nonatomic, assign) NSInteger phonestatus;
@property (nonatomic, retain) NSString* phone;

@property (nonatomic, assign) NSInteger depositstatus;
@property (nonatomic ,retain) NSString* deposit;

@property (nonatomic, assign) NSInteger baseinfostatis;
@end

@interface UserBaseInfo : NSObject

@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *realname;
@property (nonatomic, assign) NSInteger creditScore;
@property (nonatomic, assign) NSInteger creditLevel;
@property (nonatomic, assign) NSInteger score;
@property (nonatomic, assign) NSInteger creditValue;
@property (nonatomic ,retain) NSString *registerTime;

@property (nonatomic, assign) NSInteger sendTimes;
@property (nonatomic ,assign) NSInteger recvTimes;
@property (nonatomic, assign) NSInteger otherTimes;

@end

@interface UserInfo : NSObject

@property (nonatomic, retain) NSString *user;
@property (nonatomic, retain) NSString *password;
@property (nonatomic, retain) NSString *email;
@property (nonatomic, retain) NSString *phone;
@property (nonatomic, retain) NSDate *logintime;
@property (nonatomic ,retain) NSString *uid;

@property (nonatomic ,assign) BOOL isLogin;

@property (nonatomic, retain) UserBaseInfo* baseinfo;
@property (nonatomic ,retain) CertifyInfo* certifyinfo;

+ (UserInfo*)GetUserInfo;

@end
