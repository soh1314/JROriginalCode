//
//  JiuRongHttp.m
//  JiuRong
//
//  Created by iMac on 15/9/9.
//  Copyright (c) 2015年 huoqiangshou. All rights reserved.
//

#import "JiuRongHttp.h"
#import "Public.h"
#import <AFNetworking/AFNetworking.h>
#import <CJSONDeserializer.h>
#import "BorrowInfo.h"

@implementation JiuRongHttp

+ (void)JRGetAppstoreVersion:(void (^)(NSInteger, NSString *, NSString*, NSString *))success failure:(void (^)(NSError *))failure
{
//    NSString *strOperator = [NSString stringWithFormat:@"http://itunes.apple.com/cn/lookup?id=%i", APP_ID];
    NSString *strOperator = [NSString stringWithFormat:@"http://itunes.apple.com/cn/lookup?id=%i", 1018134664];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    [manager POST:strOperator parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         NSString *html = operation.responseString;
         NSData* data = [html dataUsingEncoding:NSUTF8StringEncoding];
         
         NSMutableDictionary *pData = [[CJSONDeserializer deserializer] deserialize:data error:nil];
         
         NSArray *arr = [pData objectForKey:@"results"];
         NSDictionary *resultDict = [arr objectAtIndex:0];
         NSString *newVersion = [resultDict objectForKey:@"version"];
         
         NSString *newVersionURlString = [[resultDict objectForKey:@"trackViewUrl"] copy];
         
         success(1,newVersion,newVersionURlString,nil);
         
     } failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         failure(error);
     }];
}

+ (void)JRGetVersionUpgrateInfo:(void (^)(NSInteger, NSString *, NSString *, NSString *))success failure:(void (^)(NSError *))failure
{
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/plain"];
    
    NSMutableDictionary* parameters = [[NSMutableDictionary alloc]init];
    [parameters setObject:@"2" forKey:@"deviceType"];
    [parameters setObject:@"163" forKey:@"OPT"];
    
    
    [manager POST:SERVE_PATH parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         NSString *html = operation.responseString;
         NSData* data = [html dataUsingEncoding:NSUTF8StringEncoding];
         
         NSMutableDictionary *pData = [[CJSONDeserializer deserializer] deserialize:data error:nil];
         
         NSInteger iStatus = [[pData objectForKey:@"error"] integerValue];
         
         if (iStatus == -1)
         {
             NSString *url = [pData objectForKey:@"url"];
             NSString *newversion = [pData objectForKey:@"version"];
             NSString *des = [pData objectForKey:@"changeDesc"];
             NSLog(@"%@",des);
             
             success(1,newversion,url,nil);
         }
         else
         {
             NSString *strerror = [pData objectForKey:@"msg"];
             success(iStatus,nil,nil,strerror);
         }
         
     } failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         failure(error);
     }];

}

+ (void)JRGetAuthcode:(NSString *)phone type:(NSString *)type success:(void (^)(NSInteger, NSString *))success failure:(void (^)(NSError *))failure
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/plain"];
    
    NSMutableDictionary* parameters = [[NSMutableDictionary alloc]init];
    [parameters setObject:phone forKey:@"mobile"];
    //reg:注册 commit:忘记密码
    [parameters setObject:type forKey:@"operFlag"];
    [parameters setObject:@"161" forKey:@"OPT"];
    [parameters setObject:@"ios" forKey:@"dataSource"];
    
    [manager POST:SERVE_PATH parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         NSString *html = operation.responseString;
         NSData* data = [html dataUsingEncoding:NSUTF8StringEncoding];
         
         NSMutableDictionary *pData = [[CJSONDeserializer deserializer] deserialize:data error:nil];
         
         NSInteger iStatus = [[pData objectForKey:@"error"] integerValue];
         
         if (iStatus == -1)
         {
             success(1,nil);
         }
         else
         {
             NSString *strerror = [pData objectForKey:@"msg"];
             success(iStatus,strerror);
         }
         
     } failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         failure(error);
     }];

}

+ (void)JRRegister:(NSString*)password authcode:(NSString*)code phone:(NSString*)phone recommendUserName:(NSString *)recommendUserName success:(void (^)(NSInteger iStatus ,NSString* userid ,NSString* strErrorCode))success failure:(void (^)(NSError *error))failure
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/plain"];
    
    NSMutableDictionary* parameters = [[NSMutableDictionary alloc]init];
    [parameters setObject:password forKey:@"pwd"];
    [parameters setObject:password forKey:@"tpwd"];
    [parameters setObject:code forKey:@"randomCode"];
    [parameters setObject:phone forKey:@"mobile"];
    [parameters setObject:@"2" forKey:@"OPT"];
    [parameters setObject:@"ios" forKey:@"dataSource"];
    [parameters setObject:recommendUserName forKey:@"recommendUserName"];
    [manager POST:SERVE_PATH parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         NSString *html = operation.responseString;
         NSData* data = [html dataUsingEncoding:NSUTF8StringEncoding];
         
         NSMutableDictionary *pData = [[CJSONDeserializer deserializer] deserialize:data error:nil];
         
         NSInteger iStatus = [[pData objectForKey:@"error"] integerValue];
         
         if (iStatus == -1)
         {
             NSString *userid = [pData objectForKey:@"id"];
             success(1,userid,nil);
         }
         else
         {
             NSString *strerror = [pData objectForKey:@"msg"];
             success(iStatus,nil,strerror);
         }
         
     } failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         failure(error);
     }];

}

+ (void)JRLogin:(NSString *)username pwd:(NSString *)password success:(void (^)(NSInteger, NSString *, NSString *))success failure:(void (^)(NSError *))failure
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/plain"];
    
    NSMutableDictionary* parameters = [[NSMutableDictionary alloc]init];
    [parameters setObject:username forKey:@"name"];
    [parameters setObject:password forKey:@"pwd"];
    [parameters setObject:@"2" forKey:@"deviceType"];
    [parameters setObject:@"1" forKey:@"OPT"];
    [parameters setObject:@"ios" forKey:@"dataSource"];
    
    [manager POST:SERVE_PATH parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         NSString *html = operation.responseString;
         NSData* data = [html dataUsingEncoding:NSUTF8StringEncoding];
         
         NSMutableDictionary *pData = [[CJSONDeserializer deserializer] deserialize:data error:nil];
         NSInteger iStatus = [[pData objectForKey:@"error"] integerValue];
         if (iStatus == -1)
         {
             NSString *userid = [pData objectForKey:@"id"];
             success(1,userid,nil);
         }
         else
         {
             NSString *strerror = [pData objectForKey:@"msg"];
             success(iStatus,nil,strerror);
         }
         
     } failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         failure(error);
     }];

}

+ (void)JRCertifyAuthcode:(NSString *)phone authcode:(NSString *)code success:(void (^)(NSInteger, NSString *))success failure:(void (^)(NSError *))failure
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/plain"];
    
    NSMutableDictionary* parameters = [[NSMutableDictionary alloc]init];
    [parameters setObject:phone forKey:@"mobile"];
    [parameters setObject:code forKey:@"randomCode"];
    [parameters setObject:@"5" forKey:@"OPT"];
    [parameters setObject:@"ios" forKey:@"dataSource"];
    
    [manager POST:SERVE_PATH parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         NSString *html = operation.responseString;
         NSData* data = [html dataUsingEncoding:NSUTF8StringEncoding];
         
         NSMutableDictionary *pData = [[CJSONDeserializer deserializer] deserialize:data error:nil];
         
         NSInteger iStatus = [[pData objectForKey:@"error"] integerValue];
         
         if (iStatus == -1)
         {
             success(1,nil);
         }
         else
         {
             NSString *strerror = [pData objectForKey:@"msg"];
             success(iStatus,strerror);
         }
         
     } failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         failure(error);
     }];
}

+ (void)JRResetPassword:(NSString *)phone pwd:(NSString *)password authcode:(NSString *)code success:(void (^)(NSInteger, NSString *))success failure:(void (^)(NSError *))failure
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/plain"];
    
    NSMutableDictionary* parameters = [[NSMutableDictionary alloc]init];
    [parameters setObject:phone forKey:@"mobile"];
    [parameters setObject:password forKey:@"newpwd"];
    [parameters setObject:code forKey:@"randomCode"];
    [parameters setObject:@"6" forKey:@"OPT"];
    [parameters setObject:@"ios" forKey:@"dataSource"];
    
    [manager POST:SERVE_PATH parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         NSString *html = operation.responseString;
         NSData* data = [html dataUsingEncoding:NSUTF8StringEncoding];
         
         NSMutableDictionary *pData = [[CJSONDeserializer deserializer] deserialize:data error:nil];
         
         NSInteger iStatus = [[pData objectForKey:@"error"] integerValue];
         
         if (iStatus == -1)
         {
             success(1,nil);
         }
         else
         {
             NSString *strerror = [pData objectForKey:@"msg"];
             success(iStatus,strerror);
         }
         
     } failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         failure(error);
     }];

}

+ (void)JRGetHomeData:(NSString *)isHome curpage:(NSInteger)curpage pagesize:(NSInteger)pagesize success:(void (^)(NSInteger, NSInteger, NSInteger, NSInteger, NSMutableArray *, NSString *))success failure:(void (^)(NSError *))failure
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/plain"];
    
    NSMutableDictionary* parameters = [[NSMutableDictionary alloc]init];
    [parameters setObject:isHome forKey:@"isHome"];
    [parameters setObject:[NSString stringWithFormat:@"%ld",curpage] forKey:@"currPage"];
    [parameters setObject:[NSString stringWithFormat:@"%ld",pagesize] forKey:@"pageSize"];
    [parameters setObject:@"10" forKey:@"OPT"];
    [parameters setObject:@"ios" forKey:@"dataSource"];
    
    [manager POST:SERVE_PATH parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         NSString *html = operation.responseString;
         NSData* data = [html dataUsingEncoding:NSUTF8StringEncoding];
         
         NSMutableDictionary *pData = [[CJSONDeserializer deserializer] deserialize:data error:nil];
         
         NSInteger iStatus = [[pData objectForKey:@"error"] integerValue];
         
         if (iStatus == -1)
         {
             NSInteger registerNum = [[pData objectForKey:@"totalRegisterUserCount"] integerValue];
             NSInteger platAmount = [[pData objectForKey:@"totalInvestDealAmount"] integerValue];
             NSInteger earnAmount = [[pData objectForKey:@"totalBillAmount"] integerValue];
             
             NSMutableArray *products = [pData objectForKey:@"list"];
             NSInteger iCount = [products count];
             NSMutableArray *arr = [[NSMutableArray alloc] init];
             for (NSInteger i = 0; i < iCount; i++)
             {
                 BorrowInfo *info = [[BorrowInfo alloc] init];
                 info.ID = [[products[i] objectForKey:@"id"] integerValue];
                 info.productImage = [products[i] objectForKey:@"product_filename"];
                 info.text = [products[i] objectForKey:@"title"];
                 info.amount = [[products[i] objectForKey:@"amount"] integerValue];
                 info.status = [[products[i] objectForKey:@"status"] integerValue];
                 info.progress = [[products[i] objectForKey:@"loan_schedule"] integerValue];
                 info.limit = [[products[i] objectForKey:@"period"] integerValue];
                 info.limitunit = [[products[i] objectForKey:@"period_unit"] integerValue];
                 info.rate = [[products[i] objectForKey:@"apr"] floatValue];
                 info.isbest = [[products[i] objectForKey:@"is_agency"] integerValue];
    
                 
                 [arr addObject:info];
             }
             success(1,registerNum,platAmount,earnAmount,arr,nil);
         }
         else
         {
             NSString *strerror = [pData objectForKey:@"msg"];
             success(iStatus,0,0,0,nil,strerror);
         }
         
     } failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         failure(error);
     }];

}

+ (void)JRGetProjectList:(NSInteger)pagesize index:(NSInteger)index isBest:(NSString *)isBest success:(void (^)(NSInteger, NSInteger, NSMutableArray *, NSString *))success failure:(void (^)(NSError *))failure
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/plain"];
    
    NSMutableDictionary* parameters = [[NSMutableDictionary alloc]init];
    [parameters setObject:isBest forKey:@"isQuality"];
    [parameters setObject:[NSString stringWithFormat:@"%ld",index] forKey:@"currPage"];
    [parameters setObject:[NSString stringWithFormat:@"%ld",pagesize] forKey:@"pageSize"];
    [parameters setObject:@"10" forKey:@"OPT"];
    [parameters setObject:@"ios" forKey:@"dataSource"];
    
    [manager POST:SERVE_PATH parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         NSString *html = operation.responseString;
         NSData* data = [html dataUsingEncoding:NSUTF8StringEncoding];
         
         NSMutableDictionary *pData = [[CJSONDeserializer deserializer] deserialize:data error:nil];
         
         NSInteger iStatus = [[pData objectForKey:@"error"] integerValue];
         
         if (iStatus == -1)
         {
             NSInteger listCount = [[pData objectForKey:@"totalNum"] integerValue];
             
             NSMutableArray *products = [pData objectForKey:@"list"];
             NSInteger iCount = [products count];
             NSMutableArray *arr = [[NSMutableArray alloc] init];
             for (NSInteger i = 0; i < iCount; i++)
             {
                 BorrowInfo *info = [[BorrowInfo alloc] init];
                 info.ID = [[products[i] objectForKey:@"id"] integerValue];
//                 info.productImage = [products[i] objectForKey:@"product_filename"];
                 info.text = [products[i] objectForKey:@"title"];
                 info.amount = [[products[i] objectForKey:@"amount"] integerValue];
                 info.status = [[products[i] objectForKey:@"status"] integerValue];
                 info.progress = [[products[i] objectForKey:@"loan_schedule"] integerValue];
                 info.limit = [[products[i] objectForKey:@"period"] integerValue];
                 info.limitunit = [[products[i] objectForKey:@"period_unit"] integerValue];
                 info.rate = [[products[i] objectForKey:@"apr"] floatValue];
                 [arr addObject:info];
             }
             success(1,listCount,arr,nil);
         }
         else
         {
             NSString *strerror = [pData objectForKey:@"msg"];
             success(iStatus,0,nil,strerror);
         }
         
     } failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         failure(error);
     }];
}

+ (void)JRProjectDetial:(NSInteger)ID success:(void (^)(NSInteger, BorrowInfo *, NSString *))success failure:(void (^)(NSError *))failure
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/plain"];
    
    NSMutableDictionary* parameters = [[NSMutableDictionary alloc]init];
    [parameters setObject:[NSString stringWithFormat:@"%ld",ID] forKey:@"borrowId"];
    [parameters setObject:@"11" forKey:@"OPT"];
    [parameters setObject:@"ios" forKey:@"dataSource"];
    
    [manager POST:SERVE_PATH parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         NSString *html = operation.responseString;
         NSData* data = [html dataUsingEncoding:NSUTF8StringEncoding];
         
         NSMutableDictionary *pData = [[CJSONDeserializer deserializer] deserialize:data error:nil];
         NSInteger iStatus = [[pData objectForKey:@"error"] integerValue];
         if (iStatus == -1)
         {
             BorrowInfo *info = [[BorrowInfo alloc] init];//
             info.ID = [[pData objectForKey:@"borrowId"] integerValue];
             info.no = [pData objectForKey:@"borrowerNo"];
             info.text = [pData objectForKey:@"borrowTitle"];
             info.amount = [[pData objectForKey:@"borrowAmount"] integerValue];
             info.KAmount = [pData objectForKey:@"borrowAmount"];
             info.status = [[pData objectForKey:@"borrowStatus"] integerValue];
             info.progress = [[pData objectForKey:@"schedules"] integerValue];
             info.limit = [[pData objectForKey:@"deadline"] integerValue];
             info.Klimit = [pData objectForKey:@"deadline"];
             info.rate = [[pData objectForKey:@"annualRate"] floatValue];
             info.paymentAmount  = [[pData objectForKey:@"paymentMode"] integerValue];
             info.KpaymentAmount = [pData objectForKey:@"paymentAmount"];
             info.creditRating = [pData objectForKey:@"creditRating"];
             info.creditScore = [[pData objectForKey:@"creditScore"] integerValue];
 //            info.creditLevel = [[pData objectForKey:@"creditLevel"] integerValue];
             info.realityName = [pData objectForKey:@"realityName"];
             info.sex = [pData objectForKey:@"sex"];
             info.age = [[pData objectForKey:@"age"] integerValue];
             info.idNumber = [pData objectForKey:@"idNumber"];
             info.familyAddress = [pData objectForKey:@"familyAddress"];
             info.educationName = [pData objectForKey:@"educationName"];
             info.maritalName = [pData objectForKey:@"maritalName"];
             info.houseName = [pData objectForKey:@"houseName"];
             info.carName = [pData objectForKey:@"carName"];
             info.purpose = [pData objectForKey:@"purpose"];
             info.borrowDetails = [pData objectForKey:@"borrowDetails"];
             info.auditSuggest = [pData objectForKey:@"auditSuggest"];
             info.borrowSuccessNum = [[pData objectForKey:@"borrowSuccessNum"] integerValue];
             info.borrowFailureNum = [[pData objectForKey:@"borrowFailureNum"] integerValue];
             info.repaymentNormalNum = [[pData objectForKey:@"repaymentNormalNum"] integerValue];
             info.repaymentOverdueNum = [[pData objectForKey:@"repaymentOverdueNum"] integerValue];
             info.borrowingAmount = [[pData objectForKey:@"borrowingAmount"] integerValue];
             info.KborrowingAmount = [pData objectForKey:@"borrowingAmount"];
             info.borrowerheadImg = [pData objectForKey:@"borrowerheadImg"];
             info.financialBidNum = [[pData objectForKey:@"financialBidNum"] integerValue];
             info.paymentAmount = [[pData objectForKey:@"paymentAmount"] integerValue];
             info.reimbursementAmount = [[pData objectForKey:@"reimbursementAmount"] integerValue];
             info.KreimbursementAmount = [pData objectForKey:@"reimbursementAmount"];
             info.minTenderedSum = [[pData objectForKey:@"minTenderedSum"] integerValue];
             info.registrationTime = [pData objectForKey:@"registrationTime"];
             info.investExpireTime = [pData objectForKey:@"investExpireTime"];
             info.hasinvestedamount = [[pData objectForKey:@"hasinvestedamount"] integerValue];
             
             success(1,info,nil);
         }
         else
         {
             NSString *strerror = [pData objectForKey:@"msg"];
             success(iStatus,nil,strerror);
         }
         
     } failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         failure(error);
     }];
}

+ (void)JRGetDetialMoneyList:(NSInteger)ID index:(NSInteger)index size:(NSInteger)pagesize success:(void (^)(NSInteger, NSMutableArray *, NSString *))success failure:(void (^)(NSError *))failure
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/plain"];
    
    NSMutableDictionary* parameters = [[NSMutableDictionary alloc]init];
    [parameters setObject:[NSString stringWithFormat:@"%ld",ID] forKey:@"borrowId"];
    [parameters setObject:[NSString stringWithFormat:@"%ld",index] forKey:@"currPage"];
    [parameters setObject:[NSString stringWithFormat:@"%ld",pagesize] forKey:@"pageSize"];
    [parameters setObject:@"12" forKey:@"OPT"];
    [parameters setObject:@"ios" forKey:@"dataSource"];
    
    [manager POST:SERVE_PATH parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         NSString *html = operation.responseString;
         NSData* data = [html dataUsingEncoding:NSUTF8StringEncoding];
         
         NSMutableDictionary *pData = [[CJSONDeserializer deserializer] deserialize:data error:nil];
         
         NSInteger iStatus = [[pData objectForKey:@"error"] integerValue];
         
         if (iStatus == -1)
         {
             NSMutableArray *products = [pData objectForKey:@"list"];
             NSInteger iCount = [products count];
             NSMutableArray *arr = [[NSMutableArray alloc] init];
             for (NSInteger i = 0; i < iCount; i++)
             {
                 MoneyInfo *info = [[MoneyInfo alloc] init];

                 info.name = [products[i] objectForKey:@"name"];
                 info.amount = [[products[i] objectForKey:@"invest_amount"] integerValue];
                 info.status = [[products[i] objectForKey:@"transfer_status"] integerValue];
                 info.time = [products[i] objectForKey:@"time"];
                 [arr addObject:info];
             }
             success(1,arr,nil);
         }
         else
         {
             NSString *strerror = [pData objectForKey:@"msg"];
             success(iStatus,nil,strerror);
         }
         
     } failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         failure(error);
     }];

}

+ (void)JRGetPersonData:(NSString*)userid success:(void (^)(NSInteger, NSInteger, NSString *, NSString * , NSString *, NSString *))success failure:(void (^)(NSError *))failure
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/plain"];
    
    NSMutableDictionary* parameters = [[NSMutableDictionary alloc]init];
    [parameters setObject:userid forKey:@"userId"];
    [parameters setObject:@"162" forKey:@"OPT"];
    [parameters setObject:@"ios" forKey:@"dataSource"];
    
    [manager POST:SERVE_PATH parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         NSString *html = operation.responseString;
         NSData* data = [html dataUsingEncoding:NSUTF8StringEncoding];
         
         NSMutableDictionary *pData = [[CJSONDeserializer deserializer] deserialize:data error:nil];
         
         NSInteger iStatus = [[pData objectForKey:@"error"] integerValue];
         
         if (iStatus == -1)
         {
             NSString * remainMoney = [pData objectForKey:@"availableBalance"]  ;
             
             NSString * otherMoney = [pData objectForKey:@"repaymentAmount"] ;
             NSString * sumRecvMoney = [pData objectForKey:@"sumReceiveAmount"];
             NSInteger lastdayRecvMoney = [[pData objectForKey:@"receiveAmount"] integerValue];
             
             success(1,lastdayRecvMoney, remainMoney, sumRecvMoney, otherMoney,nil);
         }
         else
         {
             NSString *strerror = [pData objectForKey:@"msg"];
             success(iStatus,0,0,0,0,strerror);
         }
         
     } failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         failure(error);
     }];
}

+ (void)JRGetPersonBaseInfo:(NSString*)userid success:(void (^)(NSInteger, UserBaseInfo *, NSString *))success failure:(void (^)(NSError *))failure
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/plain"];
    
    NSMutableDictionary* parameters = [[NSMutableDictionary alloc]init];
    [parameters setObject:userid forKey:@"id"];
    [parameters setObject:@"3" forKey:@"OPT"];
    [parameters setObject:@"ios" forKey:@"dataSource"];
    
    [manager POST:SERVE_PATH parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         NSString *html = operation.responseString;
         NSData* data = [html dataUsingEncoding:NSUTF8StringEncoding];
         
         NSMutableDictionary *pData = [[CJSONDeserializer deserializer] deserialize:data error:nil];
         
         NSInteger iStatus = [[pData objectForKey:@"error"] integerValue];
         
         if (iStatus == -1)
         {
             UserBaseInfo *info = [[UserBaseInfo alloc] init];
             info.name = [pData objectForKey:@"name"];
             info.realname = [pData objectForKey:@"realName"];
             info.creditScore = [[pData objectForKey:@"creditScore"] integerValue];
             info.creditLevel = [[pData objectForKey:@"creditLevelId"] integerValue];
             info.score = [[pData objectForKey:@"score"] integerValue];
             info.creditValue = [[pData objectForKey:@"creditLine"] integerValue];
             info.registerTime  = [pData objectForKey:@"createTime"];
             
             NSMutableDictionary *dic = [pData objectForKey:@"investAmount"];
             info.sendTimes = [[dic objectForKey:@"bid_count"] integerValue];
             info.recvTimes = [[dic objectForKey:@"invest_count"] integerValue];
             info.otherTimes = [[dic objectForKey:@"transfer_count"] integerValue];
             
             success(1,info,nil);
         }
         else
         {
             NSString *strerror = [pData objectForKey:@"msg"];
             success(iStatus,nil,strerror);
         }
         
     } failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         failure(error);
     }];
}

+ (void)JRCertifyName:(NSString*)userid name:(NSString *)name idnum:(NSString *)idnum success:(void (^)(NSInteger, NSString *))success failure:(void (^)(NSError *))failure
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/plain"];
    
    NSMutableDictionary* parameters = [[NSMutableDictionary alloc]init];
    [parameters setObject:userid forKey:@"userId"];
    [parameters setObject:name forKey:@"realName"];
    [parameters setObject:idnum forKey:@"idNumber"];
    [parameters setObject:@"166" forKey:@"OPT"];
    [parameters setObject:@"ios" forKey:@"dataSource"];
    
    [manager POST:SERVE_PATH parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         NSString *html = operation.responseString;
         NSData* data = [html dataUsingEncoding:NSUTF8StringEncoding];
         
         NSMutableDictionary *pData = [[CJSONDeserializer deserializer] deserialize:data error:nil];
         
         NSInteger iStatus = [[pData objectForKey:@"error"] integerValue];
         
         if (iStatus == -1)
         {
             success(1,nil);
         }
         else
         {
             NSString *strerror = [pData objectForKey:@"msg"];
             success(iStatus,strerror);
         }
         
     } failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         failure(error);
     }];
}

+ (void)JRBindPhone:(NSString *)userid phone:(NSString *)phone authcode:(NSString *)authcode success:(void (^)(NSInteger, NSString *))success failure:(void (^)(NSError *))failure
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/plain"];
    
    NSMutableDictionary* parameters = [[NSMutableDictionary alloc]init];
    [parameters setObject:userid forKey:@"id"];
    [parameters setObject:phone forKey:@"mobile"];
    [parameters setObject:authcode forKey:@"randomCode"];
    [parameters setObject:@"7" forKey:@"OPT"];
    [parameters setObject:@"ios" forKey:@"dataSource"];
    
    [manager POST:SERVE_PATH parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         NSString *html = operation.responseString;
         NSData* data = [html dataUsingEncoding:NSUTF8StringEncoding];
         
         NSMutableDictionary *pData = [[CJSONDeserializer deserializer] deserialize:data error:nil];
         
         NSInteger iStatus = [[pData objectForKey:@"error"] integerValue];
         
         if (iStatus == -1)
         {
             success(1,nil);
         }
         else
         {
             NSString *strerror = [pData objectForKey:@"msg"];
             success(iStatus,strerror);
         }
         
     } failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         failure(error);
     }];
}

+ (void)JRRebindPhone:(NSString*)userid old:(NSString *)oldphone new:(NSString *)newphone code:(NSString *)authcode flag:(NSString *)flag success:(void (^)(NSInteger, NSString *))success failure:(void (^)(NSError *))failure
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/plain"];
    
    NSMutableDictionary* parameters = [[NSMutableDictionary alloc]init];
    [parameters setObject:userid forKey:@"id"];
    [parameters setObject:oldphone forKey:@"oldmobile"];
    [parameters setObject:newphone forKey:@"newmobile"];
    [parameters setObject:authcode forKey:@"randomCode"];
    [parameters setObject:flag forKey:@"operFlay"];
    [parameters setObject:@"168" forKey:@"OPT"];
    [parameters setObject:@"ios" forKey:@"dataSource"];
    
    [manager POST:SERVE_PATH parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         NSString *html = operation.responseString;
         NSData* data = [html dataUsingEncoding:NSUTF8StringEncoding];
         
         NSMutableDictionary *pData = [[CJSONDeserializer deserializer] deserialize:data error:nil];
         
         NSInteger iStatus = [[pData objectForKey:@"error"] integerValue];
         
         if (iStatus == -1)
         {
             success(1,nil);
         }
         else
         {
             NSString *strerror = [pData objectForKey:@"msg"];
             success(iStatus,strerror);
         }
         
     } failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         failure(error);
     }];
}

+ (void)JRBindEmail:(NSString*)userid email:(NSString *)email success:(void (^)(NSInteger, NSString *))success failure:(void (^)(NSError *))failure
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/plain"];
    
    NSMutableDictionary* parameters = [[NSMutableDictionary alloc]init];
    [parameters setObject:userid forKey:@"id"];
    [parameters setObject:email forKey:@"emailaddress"];
    [parameters setObject:@"110" forKey:@"OPT"];
    [parameters setObject:@"ios" forKey:@"dataSource"];
    
    [manager POST:SERVE_PATH parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         NSString *html = operation.responseString;
         NSData* data = [html dataUsingEncoding:NSUTF8StringEncoding];
         
         NSMutableDictionary *pData = [[CJSONDeserializer deserializer] deserialize:data error:nil];
         
         NSInteger iStatus = [[pData objectForKey:@"error"] integerValue];
         
         if (iStatus == -1)
         {
             success(1,nil);
         }
         else
         {
             NSString *strerror = [pData objectForKey:@"msg"];
             success(iStatus,strerror);
         }
         
     } failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         failure(error);
     }];
}

+ (void)JRResetBindEmail:(NSString*)userid old:(NSString *)oldemail new:(NSString *)newemail success:(void (^)(NSInteger, NSString *))success failure:(void (^)(NSError *))failure
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/plain"];
    
    NSMutableDictionary* parameters = [[NSMutableDictionary alloc]init];
    [parameters setObject:userid forKey:@"id"];
    [parameters setObject:oldemail forKey:@"oldemail"];
    [parameters setObject:newemail forKey:@"newemail"];
    [parameters setObject:@"167" forKey:@"OPT"];
    [parameters setObject:@"ios" forKey:@"dataSource"];
    
    [manager POST:SERVE_PATH parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         NSString *html = operation.responseString;
         NSData* data = [html dataUsingEncoding:NSUTF8StringEncoding];
         
         NSMutableDictionary *pData = [[CJSONDeserializer deserializer] deserialize:data error:nil];
         
         NSInteger iStatus = [[pData objectForKey:@"error"] integerValue];
         
         if (iStatus == -1)
         {
             success(1,nil);
         }
         else
         {
             NSString *strerror = [pData objectForKey:@"msg"];
             success(iStatus,strerror);
         }
         
     } failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         failure(error);
     }];
}

+ (void)JRInvest:(NSString*)userid borrowid:(NSInteger)borrowid amount:(NSInteger)amount pwd:(NSString *)password success:(void (^)(NSInteger, NSString *))success failure:(void (^)(NSError *))failure
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/plain"];
    
    NSMutableDictionary* parameters = [[NSMutableDictionary alloc]init];
    [parameters setObject:userid forKey:@"userId"];
    [parameters setObject:[NSString stringWithFormat:@"%ld",borrowid] forKey:@"borrowId"];
    [parameters setObject:[NSString stringWithFormat:@"%ld",amount] forKey:@"amount"];
//    [parameters setObject:password forKey:@"dealPwd"];
    [parameters setObject:@"ios" forKey:@"dataSource"];
    [parameters setObject:@"16" forKey:@"OPT"];
    
    [manager POST:SERVE_PATH parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         NSString *html = operation.responseString;
         NSData* data = [html dataUsingEncoding:NSUTF8StringEncoding];
         
         NSMutableDictionary *pData = [[CJSONDeserializer deserializer] deserialize:data error:nil];
         
         NSInteger iStatus = [[pData objectForKey:@"error"] integerValue];
         
         if (iStatus == -1)
         {
             success(1,nil);
         }
         else
         {
             NSString *strerror = [pData objectForKey:@"msg"];
             success(iStatus,strerror);
         }
         
     } failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         failure(error);
     }];
}

+ (void)JRUpload:(NSString*)userid type:(NSInteger)type success:(void (^)(NSInteger, NSString *, NSString *))success failure:(void (^)(NSError *))failure
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/plain"];
    
    NSMutableDictionary* parameters = [[NSMutableDictionary alloc]init];
    [parameters setObject:userid forKey:@"userId"];
    [parameters setObject:[NSString stringWithFormat:@"%ld",type] forKey:@"bizType"];
    [parameters setObject:@"164" forKey:@"OPT"];
    [parameters setObject:@"ios" forKey:@"dataSource"];
    
    [manager POST:SERVE_PATH parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         NSString *html = operation.responseString;
         NSData* data = [html dataUsingEncoding:NSUTF8StringEncoding];
         
         NSMutableDictionary *pData = [[CJSONDeserializer deserializer] deserialize:data error:nil];
         
         NSInteger iStatus = [[pData objectForKey:@"error"] integerValue];
         
         if (iStatus == -1)
         {
             NSString *url = [pData objectForKey:@"imgStr"];
             success(1,url,nil);
         }
         else
         {
             NSString *strerror = [pData objectForKey:@"msg"];
             success(iStatus,nil,strerror);
         }
         
     } failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         failure(error);
     }];
}

+ (void)JRProUploadImage:(UIImage*)image name:(NSString *)name type:(NSString *)type finish:(void (^)(NSInteger, NSString *))finish progress:(void (^)(NSUInteger, long long, long long))progress
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    
    NSMutableDictionary* parameters = [[NSMutableDictionary alloc]init];
    
    NSData *imageData = UIImageJPEGRepresentation(image, 0.5);
//    NSData *imageData = UIImagePNGRepresentation(image);
//    Byte *tmpData =  (Byte*)[imageData bytes];
//    NSString *aString = [[NSString alloc] initWithData:imageData encoding:NSUTF8StringEncoding];
//    [parameters setObject:imageData forKey:@"appFile"];
    [parameters setValue:imageData forKey:@"appFile"];
    [parameters setObject:@"ios" forKey:@"dataSource"];
    [parameters setObject:type forKey:@"type"];
    [manager POST:IMAGE_PATH parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         NSString *html = operation.responseString;
         NSData* data = [html dataUsingEncoding:NSUTF8StringEncoding];
         NSMutableDictionary *pData = [[CJSONDeserializer deserializer] deserialize:data error:nil];
         NSInteger iStatus = [[pData objectForKey:@"error"] integerValue];
         
         if (iStatus == -1)
         {
             NSString *strFileName = [pData objectForKey:@"fileName"];
             NSString *strFileType = [pData objectForKey:@"fileType"];
             NSLog(@"%@  %@",strFileName, strFileType);
             finish(1,strFileName);
         }
         else
         {
             NSString *strerror = [pData objectForKey:@"msg"];
             finish(iStatus,strerror);
         };
         
     } failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         NSLog(@"%@",error.localizedDescription);
     }];
}

+ (void)JRUploadImage:(UIImage *)image name:(NSString *)name type:(NSString *)type finish:(void (^)(NSInteger, NSString *))finish progress:(void (^)(NSUInteger, long long, long long))progress
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    
    NSMutableDictionary* parameters = [[NSMutableDictionary alloc]init];
    [parameters setObject:name forKey:@"appFile"];
    [parameters setObject:@"ios" forKey:@"dataSource"];
    
    AFHTTPRequestOperation *operation = [manager POST:IMAGE_PATH parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData)
    {
        
        NSData *imageData = UIImageJPEGRepresentation(image, 0.5);
//        NSData *imageData = UIImagePNGRepresentation(image);
        
        // 上传图片，以文件流的格式
        [formData appendPartWithFileData:imageData name:IMAGE_PATH fileName:name mimeType:type];
         
        
//         NSURL *fileURL = [[NSBundle mainBundle] URLForResource:@"无记录@2x.png" withExtension:nil];
//        [formData appendPartWithFileURL:fileURL name:@"test00002" error:NULL];
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject)
    {
        NSString *html = operation.responseString;
        NSData* data = [html dataUsingEncoding:NSUTF8StringEncoding];
        
        NSMutableDictionary *pData = [[CJSONDeserializer deserializer] deserialize:data error:nil];
        NSInteger iStatus = [[pData objectForKey:@"error"] integerValue];
        
        if (iStatus == -1)
        {
            NSString *strFileName = [pData objectForKey:@"fileName"];
            NSString *strFileType = [pData objectForKey:@"fileType"];
            NSLog(@"%@  %@",strFileName, strFileType);
            finish(1,nil);
        }
        else
        {
            NSString *strerror = [pData objectForKey:@"msg"];
            finish(iStatus,strerror);
        };
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error)
    {
        NSLog(@"error ---- %@",error.localizedDescription);
    }];
    
    [operation setUploadProgressBlock:^(NSUInteger bytesWritten, long long totalBytesWritten, long long totalBytesExpectedToWrite)
     {
         NSLog(@"bytesWritten=%lu, totalBytesWritten=%lld, totalBytesExpectedToWrite=%lld", (unsigned long)bytesWritten, totalBytesWritten, totalBytesExpectedToWrite);
         progress(bytesWritten,totalBytesWritten,totalBytesExpectedToWrite);
     }];
}

+ (void)JRCertifyInfo:(NSString*)userid mark:(NSString*)mark imagepath:(NSString *)path success:(void (^)(NSInteger, NSString *))success failure:(void (^)(NSError *))failure
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/plain"];
    
    NSMutableDictionary* parameters = [[NSMutableDictionary alloc]init];
    [parameters setObject:userid forKey:@"userId"];
    [parameters setObject:mark forKey:@"mark"];
    [parameters setObject:path forKey:@"items"];
    [parameters setObject:@"157" forKey:@"OPT"];
    [parameters setObject:@"ios" forKey:@"dataSource"];
    
    [manager POST:SERVE_PATH parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         NSString *html = operation.responseString;
         NSData* data = [html dataUsingEncoding:NSUTF8StringEncoding];
         
         NSMutableDictionary *pData = [[CJSONDeserializer deserializer] deserialize:data error:nil];
         
         NSInteger iStatus = [[pData objectForKey:@"error"] integerValue];
         
         if (iStatus == -1)
         {
             success(1,nil);
         }
         else
         {
             NSString *strerror = [pData objectForKey:@"msg"];
             success(iStatus,strerror);
         }
         
     } failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         failure(error);
     }];

}

+ (void)JRGetCertifyInfoResult:(NSString *)uid mark:(NSString*)mark success:(void (^)(NSInteger, NSMutableDictionary *, NSString *))success failure:(void (^)(NSError *))failure
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/plain"];
    
    NSMutableDictionary* parameters = [[NSMutableDictionary alloc]init];
    [parameters setObject:uid forKey:@"id"];
    [parameters setObject:mark forKey:@"mark"];
    [parameters setObject:@"95" forKey:@"OPT"];
    [parameters setObject:@"ios" forKey:@"dataSource"];
    
    [manager POST:SERVE_PATH parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         NSString *html = operation.responseString;
         NSData* data = [html dataUsingEncoding:NSUTF8StringEncoding];
         
         NSMutableDictionary *pData = [[CJSONDeserializer deserializer] deserialize:data error:nil];
         
         NSInteger iStatus = [[pData objectForKey:@"error"] integerValue];
         
         if (iStatus == -1)
         {
             success(1,pData,nil);
         }
         else
         {
             NSString *strerror = [pData objectForKey:@"msg"];
             success(iStatus,nil,strerror);
         }
         
     } failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         failure(error);
     }];
}

+ (NSString *)JRCreateAccount:(NSString *)uid
{
    return [NSString stringWithFormat:@"%@%@?sign=%@",SERVE_ROOT,ACCOUNT_CREATE,uid];
}

+ (NSString *)JRRecharge:(NSString *)uid
{
    return [NSString stringWithFormat:@"%@%@?sign=%@",SERVE_ROOT,RECHARGE,uid];
}

+ (NSString *)JRWithdrawCash:(NSString *)uid
{
    return [NSString stringWithFormat:@"%@%@?sign=%@",SERVE_ROOT,WITHDRAW_CASH,uid];
}

+ (NSString*)JRPayback:(NSString *)uid billid:(NSString *)bid
{
    return [NSString stringWithFormat:@"%@%@?sign=%@&billId=%@",SERVE_ROOT,PAYBACK,uid,bid];
}

+ (NSString *)JRBindBankCard:(NSString *)uid
{
    return [NSString stringWithFormat:@"%@%@?sign=%@",SERVE_ROOT,BANKCARD,uid];
}

+ (NSString *)JRGetHFLogin:(NSString *)uid
{
    return [NSString stringWithFormat:@"%@%@?sign=%@",SERVE_ROOT,HFLOGIN,uid];
}

+ (NSString *)JRGetInvest:(NSString *)userid borrowid:(NSString*)borrowid amount:(NSInteger)amount pwd:(NSString *)password
{
    return [NSString stringWithFormat:@"%@%@?sign=%@&bidId=%@&investAmountStr=%ld&dealpwd=%@",SERVE_ROOT,INVEST_PATH,userid,borrowid,amount,password];
}

+ (NSString *)JRGetHFBLogin:(NSString *)uid bid:(NSString *)billid
{
    return [NSString stringWithFormat:@"%@%@?sign=%@&bidId=%@",SERVE_ROOT,HFBLOGIN,uid,billid];
}

+ (NSString*)JRGetImagePath:(NSString *)name
{
    return [NSString stringWithFormat:@"%@%@",SERVE_ROOT,name];
}

+ (NSString*)JRGetProtocolPath
{
    return PROTOCOL;
}
+ (NSString *)JRGetVideoPath
{
    return [NSString stringWithFormat:@"%@?appFile=%@&dataSource=%@",IMAGE_PATH,@"certifyVideo",@"ios"];
}
+ (void)JRLoadImage:(NSString *)strImagePath finished:(void (^)(UIImage *))finished
{
    NSURL *url = [NSURL URLWithString:strImagePath];
    
    dispatch_queue_t queue =dispatch_queue_create("loadImage",NULL);
    dispatch_async(queue, ^{
        
        NSData *resultData = [NSData dataWithContentsOfURL:url];
        UIImage *img = [UIImage imageWithData:resultData];
        
        finished(img);
    });
}

+ (void)JRGetCertifyInfo:(NSString *)uid success:(void (^)(NSInteger, CertifyInfo *, NSString *))success failure:(void (^)(NSError *))failure
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/plain"];
    
    NSMutableDictionary* parameters = [[NSMutableDictionary alloc]init];
    [parameters setObject:uid forKey:@"userId"];
    [parameters setObject:@"165" forKey:@"OPT"];
    [parameters setObject:@"ios" forKey:@"dataSource"];
    
    [manager POST:SERVE_PATH parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         NSString *html = operation.responseString;
         NSData* data = [html dataUsingEncoding:NSUTF8StringEncoding];
         
         NSMutableDictionary *pData = [[CJSONDeserializer deserializer] deserialize:data error:nil];
         
         NSInteger iStatus = [[pData objectForKey:@"error"] integerValue];
         
         if (iStatus == -1)
         {
             CertifyInfo *info = [[CertifyInfo alloc] init];
             info.name = [pData objectForKey:@"realName"];
             info.namestatus = [[pData objectForKey:@"isIdCard"] integerValue];
             info.emailstatus = [[pData objectForKey:@"isEmail"] integerValue];
             info.idcard = [pData objectForKey:@"idNumber"];
             info.phonestatus = [[pData objectForKey:@"isMobile"] integerValue];
             info.depositstatus  = [[pData objectForKey:@"isAcctNo"] integerValue];
//             info.email = [pData objectForKey:@"email"];
             info.phone = [pData objectForKey:@"mobile"];
             info.deposit = [pData objectForKey:@"acctNo"];
             info.baseinfostatis = [[pData objectForKey:@"info"] integerValue];
             success(1,info,nil);
         }
         else
         {
             NSString *strerror = [pData objectForKey:@"msg"];
             success(iStatus,nil,strerror);
         }
         
     } failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         failure(error);
     }];

}

+ (void)JRGetTransList:(NSString *)uid curpage:(NSInteger)curPage pagesize:(NSInteger)pagesize type:(NSInteger)type success:(void (^)(NSInteger, TransInfo *, NSString *))success failure:(void (^)(NSError *))failure
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/plain"];
    
    NSMutableDictionary* parameters = [[NSMutableDictionary alloc]init];
    [parameters setObject:uid forKey:@"id"];
    [parameters setObject:[NSString stringWithFormat:@"%ld",curPage] forKeyedSubscript:@"currPage"];
    [parameters setObject:[NSString stringWithFormat:@"%ld",pagesize] forKeyedSubscript:@"pageSize"];
    [parameters setObject:[NSString stringWithFormat:@"%ld",type] forKeyedSubscript:@"purpose"];
    [parameters setObject:@"97" forKey:@"OPT"];
    [parameters setObject:@"ios" forKey:@"dataSource"];
    
    [manager POST:SERVE_PATH parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         NSString *html = operation.responseString;
         NSData* data = [html dataUsingEncoding:NSUTF8StringEncoding];
         
         NSMutableDictionary *pData = [[CJSONDeserializer deserializer] deserialize:data error:nil];
         
         NSInteger iStatus = [[pData objectForKey:@"error"] integerValue];
         
         if (iStatus == -1)
         {
             
             TransInfo *tmpinfo = [TransInfo GetTransInfo];
             
             NSMutableDictionary *pPage = [pData objectForKey:@"page"];
             NSMutableArray *pInfos = [pPage objectForKey:@"page"];
             
             NSInteger iCurPage = [[pPage objectForKey:@"currPage"] integerValue];
             TransGroup *groupInfo = [tmpinfo.dicTransGroup objectForKey:[NSString stringWithFormat:@"%ld",iCurPage]];
             if (groupInfo)
             {
                 [groupInfo.arrBaseInfo removeAllObjects];
             }
             else
             {
                 groupInfo = [[TransGroup alloc] init];
                 [tmpinfo.dicTransGroup setObject:groupInfo forKey:[NSString stringWithFormat:@"%ld",iCurPage]];
             }
             
             NSInteger iCount = [pInfos count];
             groupInfo.pageSize = iCount;
             groupInfo.pageID = iCurPage;
             
             for (NSInteger i = 0; i < iCount; i++)
             {
                 TransBaseInfo *baseinfo = [[TransBaseInfo alloc] init];
                 baseinfo.time = [pInfos[i] objectForKey:@"time"];
                 baseinfo.type = [[pInfos[i] objectForKey:@"type"] integerValue];
                 baseinfo.money = [[pInfos[i] objectForKey:@"user_balance"] floatValue];
                 baseinfo.remainmoney = [[pInfos[i] objectForKey:@"balance"] floatValue];
                 baseinfo.typemoney = [[pInfos[i] objectForKey:@"amount"] floatValue];
                 baseinfo.name = [pInfos[i] objectForKey:@"name"];
                 [groupInfo.arrBaseInfo addObject:baseinfo];
             }
             
             success(1,tmpinfo,nil);
         }
         else
         {
             NSString *strerror = [pData objectForKey:@"msg"];
             success(iStatus,nil,strerror);
         }
         
     } failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         failure(error);
     }];
}

+ (void)JRGetPaybackList:(NSString *)uid curpage:(NSInteger)curPage pagesize:(NSInteger)pagesize success:(void (^)(NSInteger, PaybackInfo *, NSString *))success failure:(void (^)(NSError *))failure
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/plain"];
    
    NSMutableDictionary* parameters = [[NSMutableDictionary alloc]init];
    [parameters setObject:uid forKey:@"userId"];
    [parameters setObject:[NSString stringWithFormat:@"%ld",curPage] forKeyedSubscript:@"currPage"];
    [parameters setObject:[NSString stringWithFormat:@"%ld",pagesize] forKeyedSubscript:@"pageSize"];
    [parameters setObject:@"169" forKey:@"OPT"];
    [parameters setObject:@"ios" forKey:@"dataSource"];
    
    [manager POST:SERVE_PATH parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         NSString *html = operation.responseString;
         NSData* data = [html dataUsingEncoding:NSUTF8StringEncoding];
         
         NSMutableDictionary *pData = [[CJSONDeserializer deserializer] deserialize:data error:nil];
         
         NSInteger iStatus = [[pData objectForKey:@"error"] integerValue];
         
         if (iStatus == -1)
         {
             
             PaybackInfo *tmpinfo = [PaybackInfo GetPaybackInfo];
             
             NSMutableDictionary *pPage = [pData objectForKey:@"page"];
             NSMutableArray *pInfos = [pPage objectForKey:@"page"];
             
             NSInteger iCurPage = [[pPage objectForKey:@"currPage"] integerValue];
             PaybackGroup *groupInfo = [tmpinfo.dicPaybackGroup objectForKey:[NSString stringWithFormat:@"%ld",iCurPage]];
             if (groupInfo)
             {
                 [groupInfo.arrPaybackInfo removeAllObjects];
             }
             else
             {
                 groupInfo = [[PaybackGroup alloc] init];
                 [tmpinfo.dicPaybackGroup setObject:groupInfo forKey:[NSString stringWithFormat:@"%ld",iCurPage]];
             }
             
             NSInteger iCount = [pInfos count];
             groupInfo.pageSize = iCount;
             groupInfo.pageID = iCurPage;
             
             for (NSInteger i = 0; i < iCount; i++)
             {
                 PaybackBaseInfo *baseinfo = [[PaybackBaseInfo alloc] init];
                 baseinfo.begintime = [pInfos[i] objectForKey:@"time"];
                 baseinfo.endtime = [pInfos[i] objectForKey:@"audit_time"];
                 baseinfo.title = [pInfos[i] objectForKey:@"title"];
                 baseinfo.status = [[pInfos[i] objectForKey:@"status"] integerValue];
//                 baseinfo.no = [[pInfos[i] objectForKey:@"bid_no"] integerValue];
                 baseinfo.bidno = [pInfos[i] objectForKey:@"bid_no"];
                 baseinfo.ID = [[pInfos[i] objectForKey:@"id"] integerValue];
                 baseinfo.money = [[pInfos[i] objectForKey:@"amount"] integerValue];
                 [groupInfo.arrPaybackInfo addObject:baseinfo];
             }
             
             success(1,tmpinfo,nil);
         }
         else
         {
             NSString *strerror = [pData objectForKey:@"msg"];
             success(iStatus,nil,strerror);
         }
         
     } failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         failure(error);
     }];
}

+ (void)JRGetPersonMoneyList:(NSString *)uid curpage:(NSInteger)curPage pagesize:(NSInteger)pagesize success:(void (^)(NSInteger, PaybackInfo *, NSString *))success failure:(void (^)(NSError *))failure
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/plain"];
    
    NSMutableDictionary* parameters = [[NSMutableDictionary alloc]init];
    [parameters setObject:uid forKey:@"userId"];
    [parameters setObject:[NSString stringWithFormat:@"%ld",curPage] forKeyedSubscript:@"currPage"];
    [parameters setObject:[NSString stringWithFormat:@"%ld",pagesize] forKeyedSubscript:@"pageSize"];
//    [parameters setObject:@"35" forKey:@"OPT"];
    [parameters setObject:@"179" forKey:@"OPT"];
    [parameters setObject:@"ios" forKey:@"dataSource"];
    
    [manager POST:SERVE_PATH parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         NSString *html = operation.responseString;
         NSData* data = [html dataUsingEncoding:NSUTF8StringEncoding];
         
         NSMutableDictionary *pData = [[CJSONDeserializer deserializer] deserialize:data error:nil];
         
         NSInteger iStatus = [[pData objectForKey:@"error"] integerValue];
         if (iStatus == -1)
         {
             
             PaybackInfo *tmpinfo = [PaybackInfo GetPaybackInfo];
             NSMutableArray *pPage = [pData objectForKey:@"list"];
             PaybackGroup *groupInfo = [tmpinfo.dicPaybackGroup objectForKey:[NSString stringWithFormat:@"%ld",curPage]];
             if (groupInfo)
             {
                 [groupInfo.arrPaybackInfo removeAllObjects];
             }
             else
             {
                 groupInfo = [[PaybackGroup alloc] init];
                 [tmpinfo.dicPaybackGroup setObject:groupInfo forKey:[NSString stringWithFormat:@"%ld",curPage]];
             }
             
             NSInteger iCount = [pPage count];
             groupInfo.pageSize = iCount;
             groupInfo.pageID = curPage;
             
             for (NSInteger i = 0; i < iCount; i++)
             {
                 PaybackBaseInfo *baseinfo = [[PaybackBaseInfo alloc] init];
//                 baseinfo.begintime = [pPage[i] objectForKey:@"repayment_time"];
                 baseinfo.title = [pPage[i] objectForKey:@"title"];
                 baseinfo.status = [[pPage[i] objectForKey:@"status"] integerValue];
                 baseinfo.no = [pPage[i] objectForKey:@"no"];
//                 baseinfo.ID = [[pPage[i] objectForKey:@"id"] integerValue];
//                 baseinfo.money = [[pPage[i] objectForKey:@"income_amounts"] integerValue];
                 baseinfo.ID = [[pPage[i] objectForKey:@"bid_id"] integerValue];
                 baseinfo.money = [[pPage[i] objectForKey:@"invest_amount"] integerValue];
                 baseinfo.Kmoney = [pPage[i] objectForKey:@"invest_amount"];
                 [groupInfo.arrPaybackInfo addObject:baseinfo];
             }
             
             success(1,tmpinfo,nil);
         }
         else
         {
             NSString *strerror = [pData objectForKey:@"msg"];
             success(iStatus,nil,strerror);
         }
         
     } failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         failure(error);
     }];
}

+ (void)JRGetAccountItems:(NSString *)uid bid:(NSString*)bid curpage:(NSInteger)curPage pagesize:(NSInteger)pagesize success:(void (^)(NSInteger, NSMutableArray *, NSString *))success failure:(void (^)(NSError *))failure
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/plain"];
    
    NSMutableDictionary* parameters = [[NSMutableDictionary alloc]init];
    [parameters setObject:uid forKey:@"userId"];
    [parameters setObject:bid forKey:@"bidId"];
    [parameters setObject:[NSString stringWithFormat:@"%ld",curPage] forKeyedSubscript:@"currPage"];
    [parameters setObject:[NSString stringWithFormat:@"%ld",pagesize] forKeyedSubscript:@"pageSize"];
    [parameters setObject:@"178" forKey:@"OPT"];
    [parameters setObject:@"ios" forKey:@"dataSource"];
    
    [manager POST:SERVE_PATH parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         NSString *html = operation.responseString;
         NSData* data = [html dataUsingEncoding:NSUTF8StringEncoding];
         
         NSMutableDictionary *pData = [[CJSONDeserializer deserializer] deserialize:data error:nil];
         
         NSInteger iStatus = [[pData objectForKey:@"error"] integerValue];
         if (iStatus == -1)
         {
             
             NSMutableArray *pPage = [pData objectForKey:@"list"];
             success(1,pPage,nil);
         }
         else
         {
             NSString *strerror = [pData objectForKey:@"msg"];
             success(iStatus,nil,strerror);
         }
         
     } failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         failure(error);
     }];
}
//我要借款的借款认证信息接口
+ (void)JRGetBorrowCertifyInfo:(NSString *)uid success:(void (^)(NSInteger, NSMutableArray *, NSString *))success failure:(void (^)(NSError *))failure
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/plain"];
    
    NSMutableDictionary* parameters = [[NSMutableDictionary alloc]init];
    [parameters setObject:uid forKey:@"userId"];
    [parameters setObject:@"172" forKey:@"OPT"];
    [parameters setObject:@"ios" forKey:@"dataSource"];
    
    [manager POST:SERVE_PATH parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         NSString *html = operation.responseString;
         NSData* data = [html dataUsingEncoding:NSUTF8StringEncoding];
         
         NSMutableDictionary *pData = [[CJSONDeserializer deserializer] deserialize:data error:nil];
         
         NSInteger iStatus = [[pData objectForKey:@"error"] integerValue];
         if (iStatus == -1)
         {
             
             NSMutableArray *arrProducts = [pData objectForKey:@"products"];
             
             success(1,arrProducts,nil);
         }
         else
         {
             NSString *strerror = [pData objectForKey:@"msg"];
             success(iStatus,nil,strerror);
         }
         
     } failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         failure(error);
     }];

}

+ (void)JRGetProductInfoByID:(NSString *)pid success:(void (^)(NSInteger, NSMutableDictionary *, NSString *))success failure:(void (^)(NSError *))failure
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/plain"];
    
    NSMutableDictionary* parameters = [[NSMutableDictionary alloc]init];
    [parameters setObject:pid forKey:@"productId"];
    [parameters setObject:@"20" forKey:@"OPT"];
    [parameters setObject:@"ios" forKey:@"dataSource"];
    
    [manager POST:SERVE_PATH parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         NSString *html = operation.responseString;
         NSData* data = [html dataUsingEncoding:NSUTF8StringEncoding];
         
         NSMutableDictionary *pData = [[CJSONDeserializer deserializer] deserialize:data error:nil];
         
         NSInteger iStatus = [[pData objectForKey:@"error"] integerValue];
         if (iStatus == -1)
         {
             success(1,pData,nil);
         }
         else
         {
             NSString *strerror = [pData objectForKey:@"msg"];
             success(iStatus,nil,strerror);
         }
         
     } failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         failure(error);
     }];
}

+ (void)JRGetProductDetailInfoByID:(NSString*)uid pid:(NSString *)pid success:(void (^)(NSInteger, NSMutableDictionary *, NSString *))success failure:(void (^)(NSError *))failure
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/plain"];
    
    NSMutableDictionary* parameters = [[NSMutableDictionary alloc]init];
    [parameters setObject:pid forKey:@"productId"];
    [parameters setObject:uid forKey:@"id"];
    [parameters setObject:@"19" forKey:@"OPT"];
    [parameters setObject:@"ios" forKey:@"dataSource"];
    
    [manager POST:SERVE_PATH parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         NSString *html = operation.responseString;
         NSData* data = [html dataUsingEncoding:NSUTF8StringEncoding];
         
         NSMutableDictionary *pData = [[CJSONDeserializer deserializer] deserialize:data error:nil];
         
         NSInteger iStatus = [[pData objectForKey:@"error"] integerValue];
         if (iStatus == -1)
         {
             success(1,pData,nil);
         }
         else
         {
             NSString *strerror = [pData objectForKey:@"msg"];
             success(iStatus,nil,strerror);
         }
         
     } failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         failure(error);
     }];
}

+ (void)JRGetInterest:(NSInteger)iAmount rate:(NSString *)rate unit:(NSInteger)iUnit period:(NSInteger)iPeriod paybackmode:(NSString *)pmode success:(void (^)(NSInteger, CGFloat, NSString *))success failure:(void (^)(NSError *))failure
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/plain"];
    
    NSMutableDictionary* parameters = [[NSMutableDictionary alloc]init];
    [parameters setObject:[NSString stringWithFormat:@"%ld",iAmount] forKey:@"amount"];
    [parameters setObject:rate forKey:@"apr"];
    [parameters setObject:@"175" forKey:@"OPT"];
    [parameters setObject:[NSString stringWithFormat:@"%ld",iUnit] forKey:@"unit"];
    [parameters setObject:[NSString stringWithFormat:@"%ld",iPeriod] forKey:@"period"];
    [parameters setObject:pmode forKey:@"repayment"];
    [parameters setObject:@"ios" forKey:@"dataSource"];
    
    [manager POST:SERVE_PATH parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         NSString *html = operation.responseString;
         NSData* data = [html dataUsingEncoding:NSUTF8StringEncoding];
         
         NSMutableDictionary *pData = [[CJSONDeserializer deserializer] deserialize:data error:nil];
         
         NSInteger iStatus = [[pData objectForKey:@"error"] integerValue];
         if (iStatus == -1)
         {
             CGFloat fMoney =  [[pData objectForKey:@"interest"] floatValue];
             success(1,fMoney,nil);
         }
         else
         {
             NSString *strerror = [pData objectForKey:@"msg"];
             success(iStatus,0,strerror);
         }
         
     } failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         failure(error);
     }];
}

+ (void)JRApplyInfoCommit:(NSMutableDictionary *)dicInfo success:(void (^)(NSInteger, NSString *))success failure:(void (^)(NSError *))failure
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/plain"];
    
    [manager POST:SERVE_PATH parameters:dicInfo success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         NSString *html = operation.responseString;
         NSData* data = [html dataUsingEncoding:NSUTF8StringEncoding];
       
         NSMutableDictionary *pData = [[CJSONDeserializer deserializer] deserialize:data error:nil];
         
         NSInteger iStatus = [[pData objectForKey:@"error"] integerValue];
         if (iStatus == -1)
         {
             success(1,nil);
         }
         else
         {
             NSString *strerror = [pData objectForKey:@"msg"];
             success(iStatus,strerror);
         }
         
     } failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         failure(error);
     }];
}

+ (void)JRGetApplyInfo:(NSString *)uid auditItemId:(NSString*)auditItemId mark:(NSString*)mark success:(void (^)(NSInteger, NSMutableDictionary *, NSString *))success failure:(void (^)(NSError *))failure
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/plain"];
    
    NSMutableDictionary* parameters = [[NSMutableDictionary alloc]init];
    [parameters setObject:uid forKey:@"userId"];
    [parameters setObject:auditItemId forKey:@"auditItemId"];
    [parameters setObject:mark forKey:@"mark"];
    [parameters setObject:@"174" forKey:@"OPT"];
    [parameters setObject:@"ios" forKey:@"dataSource"];
    
    [manager POST:SERVE_PATH parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         NSString *html = operation.responseString;
         NSData* data = [html dataUsingEncoding:NSUTF8StringEncoding];
         
         NSMutableDictionary *pData = [[CJSONDeserializer deserializer] deserialize:data error:nil];
         
         NSInteger iStatus = [[pData objectForKey:@"error"] integerValue];
         if (iStatus == -1)
         {
             success(1,pData,nil);
         }
         else
         {
             NSString *strerror = [pData objectForKey:@"msg"];
             success(iStatus,nil,strerror);
         }
         
     } failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         failure(error);
     }];
}

+ (void)JRBorrowInfoCommit:(NSMutableDictionary *)dicInfo success:(void (^)(NSInteger, NSString *, NSString *))success failure:(void (^)(NSError *))failure
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/plain"];
    
    [manager POST:SERVE_PATH parameters:dicInfo success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         NSString *html = operation.responseString;
         NSData* data = [html dataUsingEncoding:NSUTF8StringEncoding];
         
         NSMutableDictionary *pData = [[CJSONDeserializer deserializer] deserialize:data error:nil];
         
         NSInteger iStatus = [[pData objectForKey:@"error"] integerValue];
         if (iStatus == -1)
         {
             NSString *bID = [pData objectForKey:@"bidId"];
             success(1,bID,nil);
         }
         else
         {
             NSString *strerror = [pData objectForKey:@"msg"];
             success(iStatus,nil,strerror);
         }
         
     } failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         failure(error);
     }];
}

+ (void)JRGetPaybackSchedule:(NSString *)uid borrowid:(NSString *)borrowid success:(void (^)(NSInteger, NSMutableDictionary *, NSString *))success failure:(void (^)(NSError *))failure
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/plain"];
    
    NSMutableDictionary* parameters = [[NSMutableDictionary alloc]init];
    [parameters setObject:uid forKey:@"userId"];
    [parameters setObject:borrowid forKey:@"borrowId"];
    [parameters setObject:@"170" forKey:@"OPT"];
    [parameters setObject:@"ios" forKey:@"dataSource"];
    
    [manager POST:SERVE_PATH parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         NSString *html = operation.responseString;
         NSData* data = [html dataUsingEncoding:NSUTF8StringEncoding];
         
         NSMutableDictionary *pData = [[CJSONDeserializer deserializer] deserialize:data error:nil];
         
         NSInteger iStatus = [[pData objectForKey:@"error"] integerValue];
         if (iStatus == -1)
         {
             success(1,pData,nil);
         }
         else
         {
             NSString *strerror = [pData objectForKey:@"msg"];
             success(iStatus,nil,strerror);
         }
         
     } failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         failure(error);
     }];
}

+ (void)JRGetPaybackInfo:(NSString *)uid billid:(NSString *)billid success:(void (^)(NSInteger, NSMutableDictionary *, NSString *))success failure:(void (^)(NSError *))failure
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/plain"];
    
    NSMutableDictionary* parameters = [[NSMutableDictionary alloc]init];
    [parameters setObject:uid forKey:@"userId"];
    [parameters setObject:billid forKey:@"billId"];
    [parameters setObject:@"171" forKey:@"OPT"];
    [parameters setObject:@"ios" forKey:@"dataSource"];
    
    [manager POST:SERVE_PATH parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         NSString *html = operation.responseString;
         NSData* data = [html dataUsingEncoding:NSUTF8StringEncoding];
         
         NSMutableDictionary *pData = [[CJSONDeserializer deserializer] deserialize:data error:nil];
         
         NSInteger iStatus = [[pData objectForKey:@"error"] integerValue];
         if (iStatus == -1)
         {
             success(1,pData,nil);
         }
         else
         {
             NSString *strerror = [pData objectForKey:@"msg"];
             success(iStatus,nil,strerror);
         }
         
     } failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         failure(error);
     }];
}

+ (void)JRCertifyUserInfo:(NSMutableDictionary *)dicInfo success:(void (^)(NSInteger, NSString *))success failure:(void (^)(NSError *))failure
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager POST:CERTIFY_INFO parameters:dicInfo success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         NSString *html = operation.responseString;
         NSData* data = [html dataUsingEncoding:NSUTF8StringEncoding];
         
         NSMutableDictionary *pData = [[CJSONDeserializer deserializer] deserialize:data error:nil];
         
         NSInteger iStatus = [[pData objectForKey:@"error"] integerValue];

         if (iStatus == -1)
         {
             success(1,nil);
         }
         else
         {
             NSString *strerror = [pData objectForKey:@"msg"];
             success(iStatus,strerror);
         }
         
         
     } failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         failure(error);
     }];
}
+ (void)checkNetStatusWith:(void(^)(NSInteger status))netblock
{
    [GLobalRealReachability reachabilityWithBlock:^(ReachabilityStatus status) {
        switch (status)
        {
            case RealStatusNotReachable:
            {
                netblock(status);
                break;
            }
                
            case RealStatusViaWiFi:
            {
                netblock(status);
                break;
            }
                
            case RealStatusViaWWAN:
            {
                netblock(status);
                break;
            }
                
            default:
                break;
        }
    }];
}
+ (void)JRProUploadVideo:(NSData *)data name:(NSString *)name type:(NSString *)type finish:(void (^)(NSInteger, NSString *))finish progress:(void (^)(NSUInteger, long long, long long))progress
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    
    NSMutableDictionary* parameters = [[NSMutableDictionary alloc]init];
    
    //    NSData *imageData = UIImagePNGRepresentation(image);
    //    Byte *tmpData =  (Byte*)[imageData bytes];
    //    NSString *aString = [[NSString alloc] initWithData:imageData encoding:NSUTF8StringEncoding];
    //    [parameters setObject:imageData forKey:@"appFile"];
    [parameters setValue:data forKey:@"appFile"];
    [parameters setObject:@"ios" forKey:@"dataSource"];
//    [parameters setObject:@"3" forKey:@"bizType"];
    [manager POST:IMAGE_PATH parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         NSString *html = operation.responseString;
         NSData* data = [html dataUsingEncoding:NSUTF8StringEncoding];
         
         NSMutableDictionary *pData = [[CJSONDeserializer deserializer] deserialize:data error:nil];
         NSInteger iStatus = [[pData objectForKey:@"error"] integerValue];
         
         if (iStatus == -1)
         {
             NSString *strFileName = [pData objectForKey:@"fileName"];
             NSString *strFileType = [pData objectForKey:@"fileType"];
             NSLog(@"%@  %@",strFileName, strFileType);
             finish(1,strFileName);
         }
         else
         {
             NSString *strerror = [pData objectForKey:@"msg"];
             finish(iStatus,strerror);
         };
         
     } failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         ;
     }];
 
}
+ (void)JRProUploadVideo2:(NSData *)data name:(NSString *)name type:(NSString *)type finish:(void (^)(NSInteger, NSString *))finish progress:(void (^)(NSUInteger, long long, long long))progress
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    
    NSMutableDictionary* parameters = [[NSMutableDictionary alloc]init];
    
    //    NSData *imageData = UIImagePNGRepresentation(image);
    //    Byte *tmpData =  (Byte*)[imageData bytes];
    //    NSString *aString = [[NSString alloc] initWithData:imageData encoding:NSUTF8StringEncoding];
    //    [parameters setObject:imageData forKey:@"appFile"];
    [parameters setValue:data forKey:@"appFile"];
    [parameters setObject:@"3" forKey:@"type"];
    [parameters setObject:@"ios" forKey:@"dataSource"];
    //    [parameters setObject:@"3" forKey:@"bizType"];
    [manager POST:IMAGE_PATH parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         NSString *html = operation.responseString;
         NSData* data = [html dataUsingEncoding:NSUTF8StringEncoding];
         
         NSMutableDictionary *pData = [[CJSONDeserializer deserializer] deserialize:data error:nil];
         NSInteger iStatus = [[pData objectForKey:@"error"] integerValue];
         
         if (iStatus == -1)
         {
             NSString *strFileName = [pData objectForKey:@"fileName"];
             NSString *strFileType = [pData objectForKey:@"fileType"];
             NSLog(@"%@  %@",strFileName, strFileType);
             finish(1,strFileName);
         }
         else
         {
             NSString *strerror = [pData objectForKey:@"msg"];
             finish(iStatus,strerror);
         };
         
     } failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         NSLog(@"%@",error.localizedDescription);
     }];

}
+ (void)JRGetMoneyLimitWith:(NSString *)uid  borrowId:(NSString *)borrowId finish:(void(^)(NSString * limitMoney))finish
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/plain"];
    
    NSMutableDictionary* parameters = [[NSMutableDictionary alloc]init];
    [parameters setObject:uid forKey:@"userId"];
    [parameters setObject:borrowId forKey:@"borrowId"];
    [parameters setObject:@"11" forKey:@"OPT"];
    [parameters setObject:@"ios" forKey:@"dataSource"];
    [manager POST:SERVE_PATH parameters:parameters success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        finish(responseObject[@"minTenderedSum"]);
        
        NSLog(@"%@",responseObject[@"minTenderedSum"]);
    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
        NSLog(@"%@",error.localizedDescription);
    }];

}
+ (void)JRPostFile:(NSString *)file orFileURL:(NSURL *)fileUrl fileName:(NSString *)name type:(NSString *)type finish:(void(^)(NSInteger iStatus,NSString * error))finish failure:(void(^)(NSUInteger bytesWritten,long long totalBytesWritten,long long expectedBytes))failure
{
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    NSMutableDictionary * dic = [[NSMutableDictionary alloc]init];
    [dic setValue:type forKey:@"type"];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [manager.requestSerializer setValue:@"multipart/form-data" forHTTPHeaderField:@"Content-Type"];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/plain",@"text/html" ,nil];
    [manager POST:VEDIO_PATH parameters:dic constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        if ([type isEqualToString:@"1"]) {
            UIImage * image = [UIImage imageNamed:file];
            NSData *imageData = UIImageJPEGRepresentation(image, 0.5);
            [formData appendPartWithFileData:imageData name:@"appFile" fileName:@"test001.mov" mimeType:@"image/jpg"];
        }
        else
        {
             NSData * videoData = [NSData dataWithContentsOfURL:fileUrl];
              [formData appendPartWithFileData:videoData  name:@"appFile" fileName:@"test001.mov" mimeType:@"video/MOV"];
        }
       
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *html = operation.responseString;
        NSData* data = [html dataUsingEncoding:NSUTF8StringEncoding];
        NSMutableDictionary *pData = [[CJSONDeserializer deserializer] deserialize:data error:nil];
        NSInteger iStatus = [[pData objectForKey:@"error"] integerValue];
        
        if (iStatus == -1)
        {
            NSString *strFileName = [pData objectForKey:@"fileName"];
            NSString *strFileType = [pData objectForKey:@"fileType"];
            NSLog(@"%@  %@",strFileName, strFileType);
            finish(1,strFileName);
        }
        else
        {
            NSString *strerror = [pData objectForKey:@"msg"];
            finish(iStatus,strerror);
        };
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error.localizedDescription);
        
    }];
}
@end
