//
//  JiuRongConfig.h
//  JiuRong
//
//  Created by iMac on 15/9/9.
//  Copyright (c) 2015年 huoqiangshou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AppInfo : NSObject

@property (nonatomic, retain) NSString* username;
@property (nonatomic, retain) NSString* password;
@property (nonatomic, assign) NSInteger logintype;
@property (nonatomic, retain) NSDate*   logontime;
@property (nonatomic, retain) NSString* version;
@property (nonatomic, assign) BOOL      autologin;

@end

@interface JiuRongConfig : NSObject
{
    AppInfo* m_pAppInfo;
}

+ (JiuRongConfig*)ShareJiuRongConfig;
- (AppInfo*)GetAppInfo;
- (void)SetUserInfo:(NSString*)name pwd:(NSString*)pwd type:(NSInteger)type login:(BOOL)autologin;
- (void)SetNewVersion:(NSString*)version;
- (void)UpdateLoginTime;
- (NSString*)GetCurVersion;

@end
