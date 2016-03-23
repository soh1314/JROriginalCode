//
//  CollectionViewCell_PersonRecord.m
//  JiuRong
//
//  Created by iMac on 15/9/23.
//  Copyright (c) 2015年 huoqiangshou. All rights reserved.
//

#import "CollectionViewCell_PersonRecord.h"

@implementation CollectionViewCell_PersonRecord

- (void)awakeFromNib {
    // Initialization code
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self = [[[NSBundle mainBundle] loadNibNamed:@"CollectionViewCell_PersonRecord" owner:self options:nil] lastObject];
    }
    
    return self;
}

- (void)UpdateInfo:(NSString *)title money:(NSInteger)iMoney status:(NSInteger)iStatus
{
    _labelTitle.text = title;
    _labelMoney.text = [NSString stringWithFormat:@"%ld元",iMoney];
    switch (iStatus)
    {
        case 0:
            _labelStatus.text = @"审核中";
            break;
        case -1:
            _labelStatus.text = @"审核不通过";
            break;
        case -2:
            _labelStatus.text = @"借款不通过";
            break;
        case -3:
            _labelStatus.text = @"放款不通过";
            break;
        case -4:
            _labelStatus.text = @"流标";
            break;
        case -100:
            _labelStatus.text = @"审核中";
            break;
        case -5:
            _labelStatus.text = @"撤销";
            break;
        case 3:
            _labelStatus.text = @"待放款";
            break;
        case 4:
            _labelStatus.text = @"还款中";
            break;
        case 5:
            _labelStatus.text = @"已还款";
            break;
        case 1:
            _labelStatus.text = @"提前借款";
            break;
        case 2:
            _labelStatus.text = @"筹款中";
            break;
        default:
            _labelStatus.text = @"未知错误";
            break;
    }
}
- (void)JRUpdateInfo:(NSString *)title money:(NSString *)KMoney status:(NSInteger)iStatus
{
    _labelTitle.text = title;
    _labelMoney.text = [NSString stringWithFormat:@"%@元",KMoney];
    switch (iStatus)
    {
        case 0:
            _labelStatus.text = @"审核中";
            break;
        case -1:
            _labelStatus.text = @"审核不通过";
            break;
        case -2:
            _labelStatus.text = @"借款不通过";
            break;
        case -3:
            _labelStatus.text = @"放款不通过";
            break;
        case -4:
            _labelStatus.text = @"流标";
            break;
        case -100:
            _labelStatus.text = @"审核中";
            break;
        case -5:
            _labelStatus.text = @"撤销";
            break;
        case 3:
            _labelStatus.text = @"待放款";
            break;
        case 4:
            _labelStatus.text = @"还款中";
            break;
        case 5:
            _labelStatus.text = @"已还款";
            break;
        case 1:
            _labelStatus.text = @"提前借款";
            break;
        case 2:
            _labelStatus.text = @"筹款中";
            break;
        default:
            _labelStatus.text = @"未知错误";
            break;
    }
}
@end
