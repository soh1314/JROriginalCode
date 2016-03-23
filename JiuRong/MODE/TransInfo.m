//
//  TransInfo.m
//  JiuRong
//
//  Created by iMac on 15/9/24.
//  Copyright (c) 2015年 huoqiangshou. All rights reserved.
//

#import "TransInfo.h"

@implementation TransBaseInfo

@end

@implementation TransGroup

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        self.arrBaseInfo = [[NSMutableArray alloc] init];
    }
    return self;
}

@end
@implementation TransInfo


+ (TransInfo*)GetTransInfo
{
    static dispatch_once_t once;
    static TransInfo *pInfo;
    dispatch_once(&once, ^ {
        pInfo = [[TransInfo alloc] init];
        pInfo.dicTransGroup = [[NSMutableDictionary alloc] init];
    });
    return pInfo;
}

@end
