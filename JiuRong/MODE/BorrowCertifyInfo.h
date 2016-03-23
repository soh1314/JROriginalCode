//
//  BorrowCertifyInfo.h
//  JiuRong
//
//  Created by iMac on 15/9/25.
//  Copyright (c) 2015年 huoqiangshou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CertifyBaseInfo : NSObject

@property (nonatomic, retain) NSString *name;
@property (nonatomic, assign) NSInteger uid;
@property (nonatomic, assign) NSInteger status;
@property (nonatomic, assign) NSInteger type;
@property (nonatomic, retain) NSString *imageURL;
@property (nonatomic, retain) NSString *mark;
@property (nonatomic, assign) NSInteger iNeed;
@property (nonatomic, copy) NSString * Description;

@end

@interface BorrowCertifyInfo : NSObject

@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *uid;
@property (nonatomic, retain) NSMutableArray *arrItems;

@end
