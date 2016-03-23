//
//  CollectionViewCell_AccountItem.m
//  JiuRong
//
//  Created by iMac on 15/12/11.
//  Copyright © 2015年 huoqiangshou. All rights reserved.
//

#import "CollectionViewCell_AccountItem.h"

@implementation CollectionViewCell_AccountItem

- (void)awakeFromNib {
    // Initialization code
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self = [[[NSBundle mainBundle] loadNibNamed:@"CollectionViewCell_AccountItem" owner:self options:nil] lastObject];
    }
    
    return self;
}

- (void)UpdateInfo:(NSString *)TimeEnd money:(NSInteger)iMoney status:(NSInteger)iStatus mark:(NSString *)mark timereally:(NSString *)TimeReally
{
    _labelTimeEnd.text = TimeEnd;
    _labelTimeReally.text = TimeReally;
    _labelMoney.text = [NSString stringWithFormat:@"%ld元",iMoney];
    _labelMark.text = mark;
    switch (iStatus)
    {
        case 0:
            _labelStatus.text = @"正常收款";
            break;
        case -1:
            _labelStatus.text = @"未收款";
            break;
        case -2:
            _labelStatus.text = @"逾期未收款";
            break;
        case -3:
            _labelStatus.text = @"本金垫付收款";
            break;
        case -4:
            _labelStatus.text = @"逾期收款";
            break;
        case -5:
            _labelStatus.text = @"待收款";
            break;
        case -6:
            _labelStatus.text = @"逾期待收款";
            break;
        case -7:
            _labelStatus.text = @"已转让";
            break;
        case 1:
            _labelStatus.text = @"正常收款";
            break;
        case 2:
            _labelStatus.text = @"审核中";
            break;
        default:
            _labelStatus.text = @"未知错误";
            break;
    }
}
- (void)JRUpdateInfo:(NSString *)TimeEnd money:(NSString *)iMoney status:(NSInteger)iStatus mark:(NSString *)mark timereally:(NSString *)TimeReally
{
    _labelTimeEnd.text = TimeEnd;
    _labelTimeReally.text = TimeReally;
    _labelMoney.text = [NSString stringWithFormat:@"%@元",iMoney];
    _labelStatus.text = mark;
    switch (iStatus)
    {
        case 0:
            _labelMark.text = @"正常收款";
            break;
        case -1:
            _labelMark.text = @"未收款";
            break;
        case -2:
            _labelMark.text = @"逾期未收款";
            break;
        case -3:
            _labelMark.text = @"本金垫付收款";
            break;
        case -4:
            _labelMark.text = @"逾期收款";
            break;
        case -5:
            _labelMark.text = @"待收款";
            break;
        case -6:
            _labelMark.text = @"逾期待收款";
            break;
        case -7:
            _labelMark.text = @"已转让";
            break;
        case 1:
            _labelMark.text = @"正常收款";
            break;
        case 2:
            _labelMark.text = @"审核中";
            break;
        default:
            _labelMark.text = @"未知错误";
            break;
    }
}
@end
