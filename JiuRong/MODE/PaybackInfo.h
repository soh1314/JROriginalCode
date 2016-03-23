//
//  PaybackInfo.h
//  JiuRong
//
//  Created by iMac on 15/9/24.
//  Copyright (c) 2015年 huoqiangshou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PaybackBaseInfo : NSObject

@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) NSString *endtime;
@property (nonatomic, retain) NSString *begintime;
@property (nonatomic, assign) NSInteger ID;
@property (nonatomic, assign) NSInteger money;
@property (nonatomic, retain) NSString *no;
@property (nonatomic, assign) NSInteger status;
@property (nonatomic ,retain) NSString *bidno;
//后续加入,前期坑爹,字符串都用retain 我都是醉了
@property (nonatomic,copy) NSString * Kmoney;
@end

@interface PaybackGroup : NSObject

@property (nonatomic, assign) NSInteger pageID;
@property (nonatomic, assign) NSInteger pageSize;
@property (nonatomic ,retain) NSMutableArray *arrPaybackInfo;

@end

@interface PaybackInfo : NSObject

@property (nonatomic, retain) NSMutableDictionary *dicPaybackGroup;

+ (PaybackInfo*)GetPaybackInfo;
+ (PaybackInfo*)GetPersonMoney;

@end

