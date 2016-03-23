//
//  CollectionViewCell_Borrow2.m
//  JiuRong
//
//  Created by iMac on 15/9/8.
//  Copyright (c) 2015年 huoqiangshou. All rights reserved.
//

#import "CollectionViewCell_Borrow2.h"
#import "PaybackInfo.h"

@implementation CollectionViewCell_Borrow2

- (void)awakeFromNib {
    // Initialization code
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self = [[[NSBundle mainBundle] loadNibNamed:@"CollectionViewCell_Borrow2" owner:self options:nil] lastObject];
    }
    
    return self;
}

- (void)UpdateInfo:(PaybackBaseInfo *)info
{
    _labelTitle.text = [NSString stringWithFormat:@"%@  %@",info.bidno,info.title];
    _labelApplyTime.text = info.begintime;
    _labelApplyMoney.text = [NSString stringWithFormat:@"%ld",info.money];
    
    switch (info.status)
    {
        case 0:
            _labelStatus.text = @"审核中";
            break;
        case 1:
            _labelStatus.text = @"提前借款";
            break;
        case 2:
            _labelStatus.text = @"筹款中";
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
        case -1:
            _labelStatus.text = @"审核不通过";
            break;
        case -2:
            _labelStatus.text = @"借款中不通过";
            break;
        case -3:
            _labelStatus.text = @"放款中不通过";
            break;
        case -4:
            _labelStatus.text = @"流标";
            break;
        case -5:
            _labelStatus.text = @"撤销";
            break;
        case -100:
            _labelStatus.text = @"审核中";
            break;
        default:
            _labelStatus.text = @"未知状态";
            break;
    }
    
    if (info.status == 4 || info.status == 5)
    {
        _labelCommitTime.hidden = NO;
        _labelCommitMoney.hidden = NO;
        _labelEndMoney.hidden = NO;
        _labelEndtime.hidden = NO;
        _labelCommitTime.text = info.endtime;
        _labelCommitMoney.text = [NSString stringWithFormat:@"%ld",info.money];
    }
    else
    {
        _labelCommitTime.hidden = YES;
        _labelCommitMoney.hidden = YES;
        _labelEndMoney.hidden = YES;
        _labelEndtime.hidden = YES;
    }
    
}

@end
