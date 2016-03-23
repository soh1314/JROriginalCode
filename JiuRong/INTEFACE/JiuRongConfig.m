//
//  JiuRongConfig.m
//  JiuRong
//
//  Created by iMac on 15/9/9.
//  Copyright (c) 2015年 huoqiangshou. All rights reserved.
//

#import "JiuRongConfig.h"

@implementation AppInfo



@end

@implementation JiuRongConfig

+ (JiuRongConfig*)ShareJiuRongConfig
{
    static dispatch_once_t once;
    static JiuRongConfig *pConfig;
    dispatch_once(&once, ^ {
        pConfig = [[JiuRongConfig alloc] init];
    });
    return pConfig;
}

- (AppInfo *)GetAppInfo
{
    if (m_pAppInfo == nil)
    {
        m_pAppInfo = [[AppInfo alloc] init];
        NSUserDefaults *setting = [NSUserDefaults standardUserDefaults];
        m_pAppInfo.username = [setting objectForKey:@"username"];
        m_pAppInfo.password = [setting objectForKey:@"password"];
        m_pAppInfo.logintype = [setting integerForKey:@"logintype"];
        m_pAppInfo.logontime = [setting objectForKey:@"createtime"];
        m_pAppInfo.version = [setting objectForKey:@"version"];
        m_pAppInfo.autologin = [setting boolForKey:@"autologin"];
    }
    
    return m_pAppInfo;
}

- (void)SetUserInfo:(NSString *)name pwd:(NSString *)pwd type:(NSInteger)type login:(BOOL)autologin
{
    NSUserDefaults *setting = [NSUserDefaults standardUserDefaults];
    
    [setting setObject:name forKey:@"username"];
    [setting setObject:pwd forKey:@"password"];
    [setting setInteger:type forKey:@"logintype"];
    [setting setBool:autologin forKey:@"autologin"];
    
    NSDate *date = [NSDate date];
    [setting setObject:date forKey:@"createtime"];
}

- (void)SetNewVersion:(NSString *)version
{
    NSUserDefaults *setting = [NSUserDefaults standardUserDefaults];
    [setting setObject:version forKey:@"version"];
}

- (void)UpdateLoginTime
{
    NSUserDefaults *setting = [NSUserDefaults standardUserDefaults];
    NSDate *date = [NSDate date];
    [setting setObject:date forKey:@"createtime"];
}

- (NSString *)GetCurVersion
{
    NSDictionary *dicInfo = [[NSBundle mainBundle] infoDictionary];
    return [dicInfo objectForKey:@"CFBundleShortVersionString"];
}

@end
