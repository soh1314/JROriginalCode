//
//  TransInfo.h
//  JiuRong
//
//  Created by iMac on 15/9/24.
//  Copyright (c) 2015年 huoqiangshou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TransBaseInfo : NSObject

@property (nonatomic, retain) NSString *time;
@property (nonatomic, assign) NSInteger type;
@property (nonatomic, assign) CGFloat typemoney;
@property (nonatomic, assign) CGFloat money;
@property (nonatomic, assign) CGFloat remainmoney;
@property (nonatomic, retain) NSString *name;
@end

@interface TransGroup : NSObject

@property (nonatomic, assign) NSInteger pageID;
@property (nonatomic, assign) NSInteger pageSize;
@property (nonatomic ,retain) NSMutableArray *arrBaseInfo;

@end

@interface TransInfo : NSObject

@property (nonatomic, assign) NSInteger pages;
@property (nonatomic, assign) NSInteger pagesize;
@property (nonatomic, retain) NSMutableDictionary *dicTransGroup;

+ (TransInfo*)GetTransInfo;

@end
