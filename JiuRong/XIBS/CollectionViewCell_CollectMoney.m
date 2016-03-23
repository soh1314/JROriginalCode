//
//  CollectionViewCell_CollectMoney.m
//  JiuRong
//
//  Created by iMac on 15/9/1.
//  Copyright (c) 2015年 huoqiangshou. All rights reserved.
//

#import "CollectionViewCell_CollectMoney.h"
#import "BorrowInfo.h"

#import "Public.h"
#import <Foundation/Foundation.h>

@implementation CollectionViewCell_CollectMoney

- (void)awakeFromNib {
    // Initialization code
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self = [[[NSBundle mainBundle] loadNibNamed:@"CollectionViewCell_CollectMoney" owner:self options:nil] lastObject];
    }
    
    return self;
}

+ (id)CreateCollectMoneyCell
{
    return [[[NSBundle mainBundle] loadNibNamed:@"CollectionViewCell_CollectMoney" owner:self options:nil] lastObject];
}

- (void)UpdateInfo:(BorrowInfo *)info
{
    switch (info.type)
    {
        case 0:
            _imageviewType.image = [UIImage imageNamed:@"icon1@2x.png"];
            break;
        case 1:
            _imageviewType.image = [UIImage imageNamed:@"icon2@2x.png"];
            break;
        case 2:
            _imageviewType.image = [UIImage imageNamed:@"icon3@2x.png"];
            break;
        case 3:
            _imageviewType.image = [UIImage imageNamed:@"icon-a@2x.png"];
            break;
        default:
            break;
    }
    
    _labelTitle.text = info.text;
    _labelRate.text = [NSString stringWithFormat:@"%.2f%%",info.rate];
    _labelAmount.text = [NSString stringWithFormat:@"%ld,%.3ld",info.amount/1000,info.amount%1000];
//    _labelLimit.text = [NSString stringWithFormat:@"%ld个月",info.limit];
    
    NSMutableArray *arr = [[NSMutableArray alloc] init];
    [arr addObject:[NSString stringWithFormat:@"%ld",info.limit]];
    if (info.limitunit == -1)
    {
        [arr addObject:@"年"];
    }
    else if (info.limitunit == 0)
    {
        [arr addObject:@"个月"];
    }
    else
    {
        [arr addObject:@"日"];
    }
    _labelLimit.attributedText = [Public CreateRichtext:2 arrtext:arr arrcolor:[NSArray arrayWithObjects:@"0x000000",@"0x000000",nil] arrfont:[NSArray arrayWithObjects:@"18",@"12",nil]];
    
    if (info.progress - 100.00f >= 0.0f)
    {
        _progressValue.hidden = YES;
        _imageviewFull.hidden = NO;
        _imageviewFull.image = [UIImage imageNamed:@"icon-a@2x.png"];
    }
    else
    {
        _progressValue.hidden = NO;
        _imageviewFull.hidden = YES;
        _progressValue.progress = info.progress/100;
    }
  
}

@end
