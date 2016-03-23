//
//  PaybackInfo.m
//  JiuRong
//
//  Created by iMac on 15/9/24.
//  Copyright (c) 2015年 huoqiangshou. All rights reserved.
//

#import "PaybackInfo.h"

@implementation PaybackBaseInfo



@end

@implementation PaybackGroup

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        self.arrPaybackInfo = [[NSMutableArray alloc] init];
    }
    return self;
}

@end

@implementation PaybackInfo


+ (PaybackInfo*)GetPaybackInfo
{
    static dispatch_once_t once;
    static PaybackInfo *pInfo;
    dispatch_once(&once, ^ {
        pInfo = [[PaybackInfo alloc] init];
        pInfo.dicPaybackGroup = [[NSMutableDictionary alloc] init];
    });
    return pInfo;
}

+ (PaybackInfo*)GetPersonMoney
{
    static dispatch_once_t two;
    static PaybackInfo *pMoney;
    dispatch_once(&two, ^ {
        pMoney = [[PaybackInfo alloc] init];
        pMoney.dicPaybackGroup = [[NSMutableDictionary alloc] init];
    });
    return pMoney;
}
@end
