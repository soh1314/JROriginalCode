//
//  JRCycleView.m
//  YingbaFinance
//
//  Created by jingshuihuang on 16/3/10.
//  Copyright © 2016年 huoqiangshou. All rights reserved.
//

#import "JRCycleView.h"

@implementation JRCycleView
- (instancetype)initWithFrame:(CGRect)frame imageArray:(NSArray *)imageArray
{
    if (self = [super initWithFrame:frame]) {
        _scrollView = [[UIScrollView alloc]initWithFrame:frame];
        [self addSubview:_scrollView];
        _scrollView.backgroundColor = [UIColor redColor];
    }
    return self;
}

@end
