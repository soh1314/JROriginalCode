//
//  BorrowCertifyInfo.m
//  JiuRong
//
//  Created by iMac on 15/9/25.
//  Copyright (c) 2015年 huoqiangshou. All rights reserved.
//

#import "BorrowCertifyInfo.h"

@implementation CertifyBaseInfo


@end

@implementation BorrowCertifyInfo

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        self.arrItems = [[NSMutableArray alloc] init];
    }
    
    return self;
}
@end
