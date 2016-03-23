//
//  Public.h
//  TTJian
//
//  Created by iMac on 15/8/26.
//  Copyright (c) 2015年 huoqiangshou. All rights reserved.
//

#import <Foundation/Foundation.h>

#define RGBCOLOR(r,g,b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]

#define APP_ID 123456

@interface textinfo : NSObject

@property (nonatomic, assign) NSInteger begin;
@property (nonatomic, assign) NSInteger length;

@end

@interface Public : NSObject

+ (void)SetNavigationBarText:(UINavigationBar*)bar size:(NSInteger)iFontSize color:(UIColor*)color;
+ (void)UpdateTabbaritem:(UITabBarItem*)item select:(NSString *)strSelectedImageName unselect:(NSString *)imageName;
+ (UIImage*)CreateImageNoRender:(NSString*)strImageName;

+ (NSString *)URLPath2LocalPath:(NSString *)strURLPath;
+ (BOOL)SaveImage:(UIImage*)image  imagepath:(NSString*)strImagePath;
+ (BOOL)ImagePathIsExist:(NSString *)strImagePath;

+ (UIImage *)GetMenuImage;
+ (UIImage *)GetMenuImage2;
+ (UIImage *)GetBackImage;
+ (UIImage *)GetBaseInfoImage;
+ (UIImage *)GetDiamondImage;
+ (UIImage *)GetCancelImage;

+ (BOOL)isValidateMobile:(NSString *)mobile;
+ (BOOL)isMobileNumber:(NSString *)mobileNum;
+ (BOOL)validateEmail:(NSString *)email;
+ (BOOL)validateIdentityCard:(NSString *)identityCard;
+ (NSString*)phoneNumToAsterisk:(NSString*)phoneNum;
+ (NSString*)idCardToAsterisk:(NSString *)idCardNum;
+ (NSString *)userNameToAsterisk:(NSString *)realName;
+ (CGFloat)GetWidth;
+ (CGFloat)GetHeight;

+ (void)ViewWithDiamonds:(UIView *)view num:(NSInteger)num;

+ (NSMutableAttributedString*)CreateRichtext:(NSInteger)iCount arrtext:(NSArray*)texts arrcolor:(NSArray*)colors arrfont:(NSArray*)fonts;
+ (NSString*)Number2String:(NSInteger)num;
+ (NSString*)RandomString:(NSInteger)iNum;
+ (NSString *)acctNoToAsterisk:(NSString *)acctNo;
@end
