//
//  JiuRongHttp.h
//  JiuRong
//
//  Created by iMac on 15/9/9.
//  Copyright (c) 2015年 huoqiangshou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BorrowInfo.h"
#import "UserInfo.h"
#import "TransInfo.h"
#import "PaybackInfo.h"
#import "RealReachability.h"
#import "JRNetView.h"
//#define ADDRESS_TESTios
#define ADDRESS_TEST1
/*后台交互字段定义*/
#if  defined(ADDRESS_TESTios)
static NSString* SERVE_ROOT     =       @"http://www.9rjr.com";
static NSString* SERVE_PATH     =       @"http://www.9rjr.com/app/services";
static NSString* IMAGE_PATH =           @"http://www.9rjr.com/FileUpload/uploadNoFile";
static NSString* CERTIFY_INFO =         @"http://www.9rjr.com/app/services";
static NSString* PROTOCOL =             @"http://www.9rjr.com/appAgreement";
static NSString * VEDIO_PATH    =       @"http://www.9rjr.com/FileUpload/uploadApp";
#elif defined(ADDRESS_TEST1)
static NSString* SERVE_ROOT     =       @"http://appio.9rjr.com";
static NSString* SERVE_PATH     =       @"http://appio.9rjr.com/app/services";
static NSString* IMAGE_PATH =           @"http://appio.9rjr.com/FileUpload/uploadNoFile";
static NSString * VEDIO_PATH    =       @"http://appio.9rjr.com/FileUpload/uploadApp";
static NSString* CERTIFY_INFO =         @"http://appio.9rjr.com/app/services";
static NSString* PROTOCOL =             @"http://appio.9rjr.com/appAgreement";
#elif defined(ADDRESS_TEST2)
static NSString* SERVE_ROOT     =       @"http://202.104.151.138:9000";
static NSString* SERVE_PATH     =       @"http://202.104.151.138:9000/app/services";
static NSString* IMAGE_PATH =           @"http://202.104.151.138:9000/FileUpload/uploadNoFile";
static NSString* CERTIFY_INFO =         @"http://202.104.151.138:9000/app/services";
static NSString* PROTOCOL =             @"http://202.104.151.138:9000/appAgreement";
#else
static NSString* SERVE_ROOT     =       @"http://www.xyydai.com:9000";
static NSString* SERVE_PATH     =       @"http://www.xyydai.com:9000/app/services";
static NSString* IMAGE_PATH =           @"http://www.xyydai.com:9000/FileUpload/uploadNoFile";
static NSString* CERTIFY_INFO =         @"http://www.xyydai.com:9000/app/services";
static NSString* PROTOCOL =             @"http://www.xyydai.com:9000/appAgreement";
#endif

static NSString* ACCOUNT_CREATE =       @"/front/PaymentAction/createAcctApp";

static NSString* RECHARGE       =       @"/front/account/rechargeAppNew";

static NSString* WITHDRAW_CASH  =       @"/front/account/withdrawalApp";

static NSString* PAYBACK =              @"/front/account/submitRepaymentApp";

static NSString* BANKCARD =             @"/front/account/userBindCardApp";

static NSString* HFLOGIN =              @"/front/account/appLoginHF";

static NSString* HFBLOGIN =             @"/front/PaymentAction/appCreateBid";

static NSString* INVEST_PATH =          @"/front/PaymentAction/appConfirmInvest";


@interface JiuRongHttp : NSObject

/*获取通过苹果商店获取app版本号和升级链接*/
+ (void)JRGetAppstoreVersion:(void (^)(NSInteger iStatus ,NSString* version ,NSString* url ,NSString* strErrorCode))success failure:(void (^)(NSError *error))failure;

/*获取通过服务器获取app版本号和升级链接*/
+ (void)JRGetVersionUpgrateInfo:(void (^)(NSInteger iStatus ,NSString* version ,NSString* url ,NSString* strErrorCode))success failure:(void (^)(NSError *error))failure;

/*验证码*/
+ (void)JRGetAuthcode:(NSString*)phone type:(NSString*)type success:(void (^)(NSInteger iStatus ,NSString* strErrorCode))success failure:(void (^)(NSError *error))failure;

/*注册*/
+ (void)JRRegister:(NSString*)password authcode:(NSString*)code phone:(NSString*)phone recommendUserName:(NSString *)recommendUserName success:(void (^)(NSInteger iStatus ,NSString* userid ,NSString* strErrorCode))success failure:(void (^)(NSError *error))failure;

/*登陆*/
+ (void)JRLogin:(NSString*)username pwd:(NSString*)password success:(void (^)(NSInteger iStatus ,NSString* userid ,NSString* strErrorCode))success failure:(void (^)(NSError *error))failure;

/*验证码验证*/
+ (void)JRCertifyAuthcode:(NSString*)phone authcode:(NSString*)code success:(void (^)(NSInteger iStatus ,NSString* strErrorCode))success failure:(void (^)(NSError *error))failure;

/*重置密码*/
+ (void)JRResetPassword:(NSString*)phone pwd:(NSString*)password authcode:(NSString*)code success:(void (^)(NSInteger iStatus ,NSString* strErrorCode))success failure:(void (^)(NSError *error))failure;

/*首页*/
+ (void)JRGetHomeData:(NSString*)isHome curpage:(NSInteger)curpage pagesize:(NSInteger)pagesize success:(void (^)(NSInteger iStatus ,NSInteger registerNum, NSInteger platAmount, NSInteger earnAmount, NSMutableArray *products, NSString* strErrorCode))success failure:(void (^)(NSError *error))failure;

/*理财列表*/
+ (void)JRGetProjectList:(NSInteger)pagesize index:(NSInteger)index isBest:(NSString*)isBest success:(void (^)(NSInteger iStatus ,NSInteger number, NSMutableArray *products, NSString* strErrorCode))success failure:(void (^)(NSError *error))failure;

/*理财详情信息*/
+ (void)JRProjectDetial:(NSInteger)ID success:(void (^)(NSInteger iStatus ,BorrowInfo *info, NSString* strErrorCode))success failure:(void (^)(NSError *error))failure;

/*理财详情投标记录*/
+ (void)JRGetDetialMoneyList:(NSInteger)ID index:(NSInteger)index size:(NSInteger)pagesize success:(void (^)(NSInteger iStatus ,NSMutableArray *moneys, NSString* strErrorCode))success failure:(void (^)(NSError *error))failure;

/*立即投标*/
+ (void)JRInvest:(NSString*)userid borrowid:(NSInteger)borrowid amount:(NSInteger)amount pwd:(NSString*)password success:(void (^)(NSInteger iStatus ,NSString* strErrorCode))success failure:(void (^)(NSError *error))failure;

/*个人中心首页数据*/
+ (void)JRGetPersonData:(NSString*)userid success:(void (^)(NSInteger iStatus ,NSInteger money1, NSString * money2, NSString * money3, NSString * money4, NSString* strErrorCode))success failure:(void (^)(NSError *error))failure;

/*获取用户基本资料*/
+ (void)JRGetPersonBaseInfo:(NSString*)userid success:(void (^)(NSInteger iStatus ,UserBaseInfo *info, NSString* strErrorCode))success failure:(void (^)(NSError *error))failure;

/* 绑定手机号码*/
+ (void)JRBindPhone:(NSString*)userid phone:(NSString*)phone authcode:(NSString*)authcode success:(void (^)(NSInteger iStatus ,NSString* strErrorCode))success failure:(void (^)(NSError *error))failure;

/*修改绑定的手机号码*/
+ (void)JRRebindPhone:(NSString*)userid old:(NSString*)oldphone new:(NSString*)newphone code:(NSString*)authcode flag:(NSString*)flag success:(void (^)(NSInteger iStatus ,NSString* strErrorCode))success failure:(void (^)(NSError *error))failure;

/*实名认证*/
+ (void)JRCertifyName:(NSString*)userid name:(NSString*)name idnum:(NSString*)idnum success:(void (^)(NSInteger iStatus ,NSString* strErrorCode))success failure:(void (^)(NSError *error))failure;

/*邮箱绑定*/
+ (void)JRBindEmail:(NSString*)userid email:(NSString*)email success:(void (^)(NSInteger iStatus ,NSString* strErrorCode))success failure:(void (^)(NSError *error))failure;

/*修改绑定的邮箱地址*/
+ (void)JRResetBindEmail:(NSString*)userid old:(NSString*)oldemail new:(NSString*)newemail success:(void (^)(NSInteger iStatus ,NSString* strErrorCode))success failure:(void (^)(NSError *error))failure;

/*上传*/
+ (void)JRUpload:(NSString*)userid type:(NSInteger)type success:(void (^)(NSInteger iStatus ,NSString *url, NSString* strErrorCode))success failure:(void (^)(NSError *error))failure;

/*上传前的调用*/
+ (void)JRProUploadImage:(UIImage*)image name:(NSString *)name type:(NSString *)type finish:(void (^)(NSInteger, NSString *))finish progress:(void (^)(NSUInteger, long long, long long))progress;

+ (void)JRUploadImage:(UIImage *)image name:(NSString*)name type:(NSString*)type finish:(void (^)(NSInteger iStatus, NSString* strErrorCode))finish progress:(void (^)(NSUInteger bytesWritten, long long totalBytesWritten, long long totalBytesExpectedToWrite))progress;

/*提交审核资料*/
+ (void)JRCertifyInfo:(NSString*)userid mark:(NSString*)mark imagepath:(NSString*)path success:(void (^)(NSInteger iStatus ,NSString* strErrorCode))success failure:(void (^)(NSError *error))failure;

/*获取资料审核结果*/
+ (void)JRGetCertifyInfoResult:(NSString*)uid mark:(NSString*)mark success:(void (^)(NSInteger iStatus ,NSMutableDictionary *info ,NSString* strErrorCode))success failure:(void (^)(NSError *error))failure;

+ (void)JRLoadImage:(NSString*)strImagePath finished:(void (^)(UIImage *pImage))finished;

/*开户*/
+ (NSString*)JRCreateAccount:(NSString*)uid;

/*充值*/
+ (NSString*)JRRecharge:(NSString*)uid;

/*提现*/
+ (NSString*)JRWithdrawCash:(NSString*)uid;

/*还款*/
+ (NSString*)JRPayback:(NSString*)uid billid:(NSString*)bid;

/*获取图片地址*/
+ (NSString*)JRGetImagePath:(NSString*)name;

/*绑定银行卡*/
+ (NSString*)JRBindBankCard:(NSString*)uid;

/*汇付登陆*/
+ (NSString*)JRGetHFLogin:(NSString*)uid;

/*投标*/
+ (NSString*)JRGetInvest:(NSString*)userid borrowid:(NSString*)borrowid amount:(NSInteger)amount pwd:(NSString*)password;

/*汇付标登陆*/
+ (NSString*)JRGetHFBLogin:(NSString*)uid bid:(NSString*)billid;

/*协议*/
+ (NSString*)JRGetProtocolPath;

//上传视频
+ (NSString *)JRGetVideoPath;
/*获取认证信息*/
+ (void)JRGetCertifyInfo:(NSString*)uid success:(void (^)(NSInteger iStatus ,CertifyInfo *info, NSString* strErrorCode))success failure:(void (^)(NSError *error))failure;

/*获取交易记录*/
+ (void)JRGetTransList:(NSString*)uid curpage:(NSInteger)curPage pagesize:(NSInteger)pagesize type:(NSInteger)type success:(void (^)(NSInteger iStatus ,TransInfo *info, NSString* strErrorCode))success failure:(void (^)(NSError *error))failure;

/*获取还款清单*/
+ (void)JRGetPaybackList:(NSString*)uid curpage:(NSInteger)curPage pagesize:(NSInteger)pagesize success:(void (^)(NSInteger iStatus ,PaybackInfo *info, NSString* strErrorCode))success failure:(void (^)(NSError *error))failure;

/*获取理财帐户清单*/
+ (void)JRGetPersonMoneyList:(NSString*)uid curpage:(NSInteger)curPage pagesize:(NSInteger)pagesize success:(void (^)(NSInteger iStatus ,PaybackInfo *info, NSString* strErrorCode))success failure:(void (^)(NSError *error))failure;

/*获取理财某项的账单记录*/
+ (void)JRGetAccountItems:(NSString *)uid bid:(NSString*)bid curpage:(NSInteger)curPage pagesize:(NSInteger)pagesize success:(void (^)(NSInteger iStatus, NSMutableArray *arrItems, NSString *strErrorCode))success failure:(void (^)(NSError *error))failure;

/*获取我要借款首页的认证资料信息*/
+ (void)JRGetBorrowCertifyInfo:(NSString*)uid success:(void (^)(NSInteger iStatus ,NSMutableArray *info, NSString* strErrorCode))success failure:(void (^)(NSError *error))failure;

/*根据产品的id获取该产品的基本信息*/
+ (void)JRGetProductInfoByID:(NSString*)pid success:(void (^)(NSInteger iStatus ,NSMutableDictionary *info, NSString* strErrorCode))success failure:(void (^)(NSError *error))failure;

/*根据产品的id获取该产品的详细信息*/
+ (void)JRGetProductDetailInfoByID:(NSString*)uid pid:(NSString *)pid success:(void (^)(NSInteger iStatus ,NSMutableDictionary *info, NSString* strErrorCode))success failure:(void (^)(NSError *error))failure;

/*计算利息*/
+ (void)JRGetInterest:(NSInteger)iAmount rate:(NSString*)rate unit:(NSInteger)iUnit period:(NSInteger)iPeriod paybackmode:(NSString*)pmode success:(void (^)(NSInteger iStatus ,CGFloat fMoney, NSString* strErrorCode))success failure:(void (^)(NSError *error))failure;

/*申请表信息提交*/
+ (void)JRApplyInfoCommit:(NSMutableDictionary*)dicInfo success:(void (^)(NSInteger iStatus ,NSString* strErrorCode))success failure:(void (^)(NSError *error))failure;

/*获取申请表信息*/
+ (void)JRGetApplyInfo:(NSString*)uid auditItemId:(NSString*)auditItemId mark:(NSString*)mark success:(void (^)(NSInteger iStatus ,NSMutableDictionary *info, NSString* strErrorCode))success failure:(void (^)(NSError *error))failure;

/*提交借款申请*/
+ (void)JRBorrowInfoCommit:(NSMutableDictionary*)dicInfo success:(void (^)(NSInteger iStatus ,NSString* bid ,NSString* strErrorCode))success failure:(void (^)(NSError *error))failure;

/*还款计划*/
+ (void)JRGetPaybackSchedule:(NSString*)uid borrowid:(NSString*)borrowid success:(void (^)(NSInteger iStatus ,NSMutableDictionary *info, NSString* strErrorCode))success failure:(void (^)(NSError *error))failure;

/*还款对账单*/
+ (void)JRGetPaybackInfo:(NSString*)uid billid:(NSString*)billid success:(void (^)(NSInteger iStatus ,NSMutableDictionary *info, NSString* strErrorCode))success failure:(void (^)(NSError *error))failure;

/*个人认证*/
+ (void)JRCertifyUserInfo:(NSMutableDictionary*)dicInfo success:(void (^)(NSInteger iStatus ,NSString* strErrorCode))success failure:(void (^)(NSError *error))failure;
//上传视频
+ (void)JRProUploadVideo:(NSData *)data name:(NSString *)name type:(NSString *)type finish:(void (^)(NSInteger, NSString *))finish progress:(void (^)(NSUInteger, long long, long long))progress;
+ (void)JRProUploadVideo2:(NSData *)data name:(NSString *)name type:(NSString *)type finish:(void (^)(NSInteger, NSString *))finish progress:(void (^)(NSUInteger, long long, long long))progress;
+ (void)checkNetStatusWith:(void(^)(NSInteger status))netblock;
//理财额度规范
+ (void)JRGetMoneyLimitWith:(NSString *)uid  borrowId:(NSString *)borrowId finish:(void(^)(NSString * limitMoney))finish;
//新的上传图片,视频通道
+ (void)JRPostFile:(NSString *)file orFileURL:(NSURL *)fileUrl fileName:(NSString *)name type:(NSString *)type finish:(void(^)(NSInteger iStatus,NSString * error))finish failure:(void(^)(NSUInteger bytesWritten,long long totalBytesWritten,long long expectedBytes))failure;
@end
