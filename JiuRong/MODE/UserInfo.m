//
//  UserInfo.m
//  JiuRong
//
//  Created by iMac on 15/9/2.
//  Copyright (c) 2015年 huoqiangshou. All rights reserved.
//

#import "UserInfo.h"

@implementation CertifyInfo



@end

@implementation UserBaseInfo


@end

@implementation UserInfo

+ (UserInfo*)GetUserInfo
{
    static dispatch_once_t once;
    static UserInfo *pUserData;
    dispatch_once(&once, ^ {
        pUserData = [[UserInfo alloc] init];
        pUserData.isLogin = FALSE;
    });
    return pUserData;
}

@end
