//
//  CollectionViewCell_Transfer.m
//  JiuRong
//
//  Created by iMac on 15/9/7.
//  Copyright (c) 2015年 huoqiangshou. All rights reserved.
//

#import "CollectionViewCell_Transfer.h"
#import "Public.h"

@implementation CollectionViewCell_Transfer

- (void)awakeFromNib {
    // Initialization code
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self = [[[NSBundle mainBundle] loadNibNamed:@"CollectionViewCell_Transfer" owner:self options:nil] lastObject];
    }
    
    return self;
}

- (void)UpdateInfo:(TransBaseInfo *)info
{
    _labelTime.text = info.time;
//    _labelMoney.text = [NSString stringWithFormat:@"%.2f",info.money]/*[Public Number2String:info.money]*/;
    
    _labelRemainMoney.text = [NSString stringWithFormat:@"%.2f",info.remainmoney]/*[Public Number2String:info.remainmoney]*/;
    
    //1：充值、2提现、3服务费、4账单还款、5账单收入
/*    switch (info.type)
    {
        case 1:
            _labelOut.text = @"充值";
            break;
        case 2:
            _labelOut.text = @"提现";
            break;
        case 3:
            _labelOut.text = @"服务费";
            break;
        case 4:
            _labelOut.text = @"账单还款";
            break;
        case 5:
            _labelOut.text = @"账单收入";
            break;
    }
 */
    _labelOut.text = info.name;;
    if (info.type == 1 || info.type == 5)
    {
        _labelIn.text = [NSString stringWithFormat:@"+%.2f",info.typemoney];
        
    }
    else
    {
        _labelIn.text = [NSString stringWithFormat:@"-%.2f",info.typemoney];
        
    }

}
@end
